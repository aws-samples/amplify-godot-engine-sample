import { defineBackend } from '@aws-amplify/backend';
import * as iam from "aws-cdk-lib/aws-iam"
import { auth } from './auth/resource';
import { data } from './data/resource';
import { storage,gluestorage,analyticsstorage } from './storage/resource'
import { Stack } from "aws-cdk-lib";
import { PolicyStatement } from "aws-cdk-lib/aws-iam";
import { myApiFunction } from "./functions/myApi/resource";
import { FirehoseToS3 } from './analytics/resource';
import { gluecrawler } from './etl/resources';
import { Duration } from 'aws-cdk-lib';
import { ApiGatewayConstruct } from './api/resource';
import { adsImageGenerator } from './functions/ads-image-generator/resource'
import { GenAiCommentary } from './functions/gen-ai-commentary/resource'
import { GenAiChat } from './functions/gen-ai-chat/resource'

/**
 * @see https://docs.amplify.aws/react/build-a-backend/ to add storage, functions, and more
 */
export const backend = defineBackend({
    auth,
    data,
    storage,
    myApiFunction,
    analyticsstorage,
    gluestorage,
    adsImageGenerator,
    GenAiCommentary,
    GenAiChat
});
backend.auth.resources.cfnResources.cfnUserPoolClient.explicitAuthFlows = [
    "ALLOW_CUSTOM_AUTH",
    "ALLOW_REFRESH_TOKEN_AUTH",
    "ALLOW_USER_SRP_AUTH",
    "ALLOW_USER_PASSWORD_AUTH"
]

const analyticsStack = backend.createStack('Gameanalytics');

const analyticsStream = new FirehoseToS3(analyticsStack, "GameAnalyticsStream", {
  streamName: `${process.env.STACK_NAME}-analytics-firehosestream`,
  bucket: backend.analyticsstorage.resources.bucket,
  bufferInterval: Duration.seconds(60),
  bufferSize: 1,
  prefix: "data/!{timestamp:yyyy}/!{timestamp:MM}/!{timestamp:dd}/",
  errorPrefix: "errors/data/!{firehose:error-output-type}/!{timestamp:yyyy}/!{timestamp:MM}/!{timestamp:dd}/",
});
const lambdastatement = new PolicyStatement({
  actions: ['firehose:PutRecord', 'firehose:PutRecordBatch'],
  resources: ['arn:aws:firehose:*:*:deliverystream/' + analyticsStream.deliveryStream.deliveryStreamName]
});

const firehoselambda = backend.myApiFunction.resources.lambda;
firehoselambda.addToRolePolicy(lambdastatement);
// Export the resources if needed
const crawler = new gluecrawler(analyticsStack, "GlueCrawler", {
  bucket: backend.analyticsstorage.resources.bucket,
  databaseName: `${process.env.STACK_NAME}-gdcgameanalytics`,
  tableName: "squashgodot"
});

const apiStack = backend.createStack("analytics-api-stack");
const { cfnUserPoolClient } = backend.auth.resources.cfnResources;
cfnUserPoolClient.explicitAuthFlows = [ 'ALLOW_USER_PASSWORD_AUTH', 'ALLOW_REFRESH_TOKEN_AUTH', 'ALLOW_USER_SRP_AUTH']
cfnUserPoolClient.allowedOAuthScopes = ['openid','profile'];
cfnUserPoolClient.generateSecret = false;
const { userPool } = backend.auth.resources;

const apiGateway = new ApiGatewayConstruct(apiStack, "AnalyticsApi", {
  lambda: backend.myApiFunction.resources.lambda,
  authenticatedRole: backend.auth.resources.authenticatedUserIamRole,
  unauthenticatedRole: backend.auth.resources.unauthenticatedUserIamRole,
  userPoolId: backend.auth.resources.userPool.userPoolId,
  authorizationType: 'API_KEY',
  apiKeyRequired: true
});



// Create analytics resources after backend is defined
// add outputs to the configuration file
backend.addOutput({
  custom: {
    analytics: {
      endpoint: apiGateway.api.url,
      region: Stack.of(apiGateway.api).region,
      apiName: apiGateway.api.restApiName,
      apiKeyID: apiGateway.apiKey.keyId,
      apiKeyValue: "run [aws apigateway get-api-key --api-key <api-key-id> --include-value --query \"value\" --output text] and paste here"
    }
  }
});

const adsImageGeneratorLambda = backend.adsImageGenerator.resources.lambda


const statement = new iam.PolicyStatement({
  sid: "AllowInvokeBedrockModelAndGetDynamoDBItem",
  actions: ["bedrock:InvokeModel"],
  resources: [
    "arn:aws:bedrock:us-east-1::foundation-model/*",
  ],
})

adsImageGeneratorLambda.addToRolePolicy(statement)

const adsGenAiCommentaryLambda = backend.GenAiCommentary.resources.lambda

adsGenAiCommentaryLambda.addToRolePolicy(statement)


// TODO: Need to exchange the across account role to be dynamic and not hard coded
const adsGenAIChatStatement = new iam.PolicyStatement({
  sid: "AllowBedrockCrossAccountAccess",
  actions: [
    "bedrock:InvokeModel",
    "bedrock:InvokeAgent",
    "sts:AssumeRole"
  ],
  resources: [
    "arn:aws:bedrock:us-east-1::foundation-model/*",
    "arn:aws:iam::495599745041:role/GenAIChat-Sandbox"
  ],
})
const adsGenAIChat = backend.GenAiChat.resources.lambda
adsGenAIChat.addToRolePolicy(adsGenAIChatStatement)
  
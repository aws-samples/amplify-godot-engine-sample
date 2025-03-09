import { defineBackend } from '@aws-amplify/backend';
import * as iam from "aws-cdk-lib/aws-iam"
import { auth } from './auth/resource';
import { data } from './data/resource';
import { storage,gluestorage,analyticsstorage } from './storage/resource'
import { Stack, CustomResource} from "aws-cdk-lib";
import { Effect, PolicyStatement } from "aws-cdk-lib/aws-iam";
import { myApiFunction } from "./functions/myApi/resource";
import { queryFunction } from "./functions/query-data/resource";
import { FirehoseToS3 } from './analytics/resource';
import { gluecrawler } from './etl/resources';
import { ApiGatewayConstruct } from './api/resource';
import { adsImageGenerator } from './functions/ads-image-generator/resource'
import { Provider } from "aws-cdk-lib/custom-resources";
import * as lambda from "aws-cdk-lib/aws-lambda";
import * as path from "path";
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
    queryFunction
});
backend.auth.resources.cfnResources.cfnUserPoolClient.explicitAuthFlows = [
    "ALLOW_CUSTOM_AUTH",
    "ALLOW_REFRESH_TOKEN_AUTH",
    "ALLOW_USER_SRP_AUTH",
    "ALLOW_USER_PASSWORD_AUTH"
]

export const analyticsStack = backend.createStack('Gameanalytics');

const analyticsStream = new FirehoseToS3(analyticsStack, "GameAnalyticsStream", {
  streamName: `${process.env.STACK_NAME}-game-analytics-firehosestream`,
  bucket: backend.analyticsstorage.resources.bucket,
});

const lambdastatement = new PolicyStatement({
  actions: ['firehose:PutRecord', 'firehose:PutRecordBatch'],
  resources: ['arn:aws:firehose:*:*:deliverystream/' + analyticsStream.deliveryStream.deliveryStreamName]
});
const athenalambdastatement = new PolicyStatement({
  actions: ['athena:StartQueryExecution', 'athena:GetQueryExecution', 'athena:GetQueryResults', 'glue:GetTables', 'glue:GetTable','glue:GetPartitions',
    'glue:GetPartition', 'glue:BatchGetPartition','glue:GetDatabases','glue:GetDatabase','s3:GetBucketLocation','s3:GetObject','s3:ListBucket','s3:PutObject'],
  resources: ['arn:aws:athena:*:*:workgroup/*',`arn:aws:s3:::${backend.gluestorage.resources.bucket.bucketName}/*`,
    `arn:aws:s3:::${backend.gluestorage.resources.bucket.bucketName}`,
    `arn:aws:s3:::${backend.analyticsstorage.resources.bucket.bucketName}/*`,
    `arn:aws:s3:::${backend.analyticsstorage.resources.bucket.bucketName}`,
    'arn:aws:glue:*']
});

backend.queryFunction.addEnvironment('TABLE_NAME', backend.analyticsstorage.resources.bucket.bucketName);
backend.queryFunction.addEnvironment('ATHENA_QUERY_LOCATION', backend.gluestorage.resources.bucket.bucketName);
const firehoselambda = backend.myApiFunction.resources.lambda;
const querylambda = backend.queryFunction.resources.lambda;

firehoselambda.addToRolePolicy(lambdastatement);
querylambda.addToRolePolicy(athenalambdastatement);
const crawler = new gluecrawler(analyticsStack, "GlueCrawler", {
  bucket: backend.analyticsstorage.resources.bucket,
  databaseName: `${process.env.STACK_NAME}-gdcgameanalytics`,
  tableName: `${process.env.STACK_NAME}-squashgodot`
});

const apiStack = backend.createStack("analytics-api-stack");
/*const { cfnUserPoolClient } = backend.auth.resources.cfnResources;
cfnUserPoolClient.explicitAuthFlows = [ 'ALLOW_USER_PASSWORD_AUTH', 'ALLOW_REFRESH_TOKEN_AUTH', 'ALLOW_USER_SRP_AUTH']
cfnUserPoolClient.allowedOAuthScopes = ['openid','profile'];
cfnUserPoolClient.generateSecret = false;
const { userPool } = backend.auth.resources;*/

const apiGateway = new ApiGatewayConstruct(apiStack, "AnalyticsApi", {
  lambda: backend.myApiFunction.resources.lambda,
  querylambda: backend.queryFunction.resources.lambda,
  authenticatedRole: backend.auth.resources.authenticatedUserIamRole,
  unauthenticatedRole: backend.auth.resources.unauthenticatedUserIamRole,
  userPoolId: backend.auth.resources.userPool.userPoolId,
  authorizationType: 'API_KEY',
  apiKeyRequired: true
});

const getApiKeyFunction = new lambda.Function(apiStack, 'GetApiKeyFunction', {
  runtime: lambda.Runtime.NODEJS_18_X,
  handler: 'index.handler',
  code: lambda.Code.fromAsset(path.join('./amplify/functions/getApiKey')),
});

// Add permissions to get API key
getApiKeyFunction.addToRolePolicy(
  new PolicyStatement({
    effect: Effect.ALLOW,
    actions: ['apigateway:GET'],
    resources: [`arn:aws:apigateway:${Stack.of(apiStack).region}::/apikeys/*`],
  })
);

// Create the custom resource provider
const provider = new Provider(apiStack, 'GetApiKeyProvider', {
  onEventHandler: getApiKeyFunction,
});

// Create the custom resource
const apiKeyResource = new CustomResource(apiStack, 'ApiKeyResource', {
  serviceToken: provider.serviceToken,
  properties: {
    apiKeyId: apiGateway.apiKey.keyId,
  },
});

// Create analytics resources after backend is defined
// add outputs to the configuration file
backend.addOutput({
  custom: {
    custom_analytics: {
      endpoint: apiGateway.api.url,
      region: Stack.of(apiGateway.api).region,
      apiName: apiGateway.api.restApiName,
      apiKeyID: apiGateway.apiKey.keyId,
      apiKeyValue: apiKeyResource.getAttString('apiKeyValue'),
      glueCatalogTable: crawler.tableName,
      glueDatabaseName: `${process.env.STACK_NAME}-gdcgameanalytics`
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

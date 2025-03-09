import { Construct } from 'constructs';
import { Stack } from "aws-cdk-lib";
import {
  ApiKeySourceType,
  AuthorizationType,
  CognitoUserPoolsAuthorizer,
  Cors,
  IApiKey,
  LambdaIntegration,
  RestApi,
} from "aws-cdk-lib/aws-apigateway";
import { Policy, PolicyStatement, IRole } from "aws-cdk-lib/aws-iam";
import { IFunction } from 'aws-cdk-lib/aws-lambda';


//allows for the creation of api gateways backend.ts
export interface ApiGatewayProps {
  lambda: IFunction;
  querylambda: IFunction;
  authenticatedRole: IRole;
  unauthenticatedRole: IRole;
  userPoolId: string;
  authorizationType: 'API_KEY',
  apiKeyRequired: true
}

export class ApiGatewayConstruct extends Construct {
  public readonly api: RestApi;
  public readonly apiKey: IApiKey;
  constructor(scope: Construct, id: string, props: ApiGatewayProps) {
    super(scope, id);

    // Create REST API
    this.api = new RestApi(this, "AnalyticsRESTAPI", {
      restApiName: "AnalyticsRESTAPI",
      deploy: true,
      deployOptions: {
        stageName: "dev",
      },
      defaultCorsPreflightOptions: {
        allowOrigins: Cors.ALL_ORIGINS,
        allowMethods: Cors.ALL_METHODS,
        allowHeaders: [...Cors.DEFAULT_HEADERS,'x-api-key'],
      },
      apiKeySourceType: ApiKeySourceType.HEADER
    });
    
    
    
    // Integrats lambda function to API gateway
    const lambdaIntegration = new LambdaIntegration(props.lambda);
    const queryLambdaIntegration = new LambdaIntegration(props.querylambda);
    // Create data path
    const itemsPath = this.api.root.addResource("data");
    const queryPath = this.api.root.addResource("query");
    //create cognito authoriser, to only allow users from amplify created user pool to use API gateway
    


    // Create API policy to allow invocation
    const AnalyticsAPIPolicy = new Policy(this, "AnalyticsAPIPolicy", {
      statements: [
        new PolicyStatement({
          actions: ["execute-api:Invoke"],
          resources: [
            `${this.api.arnForExecuteApi("*", "/data", "dev")}`,
            `${this.api.arnForExecuteApi("*", "/data/*", "dev")}`,
            `${this.api.arnForExecuteApi("*", "/query", "dev")}`, // Add query path
            `${this.api.arnForExecuteApi("*", "/query/*", "dev")}`, // Add query path
          ],
        }),
      ],
    });

    // Attach policies to roles
    props.authenticatedRole.attachInlinePolicy(AnalyticsAPIPolicy);
    props.unauthenticatedRole.attachInlinePolicy(AnalyticsAPIPolicy);
    //attach cognito authoriser to api gateway to only allow authenticated users to push data to AWS, also allows PUT requests to use lambda function
    itemsPath.addMethod("PUT", lambdaIntegration, {
      apiKeyRequired: true,
      authorizationType: AuthorizationType.NONE
    });
    queryPath.addMethod("GET", queryLambdaIntegration, {
      apiKeyRequired: true,
      authorizationType: AuthorizationType.NONE
    });
    // Create API key
     this.apiKey = this.api.addApiKey('DefaultApiKey', {
      apiKeyName: `${process.env.STACK_NAME}-analytics-api-key`,
      description: 'API key for Analytics API'
    });

    // Create usage plan
    const usagePlan = this.api.addUsagePlan('DefaultUsagePlan', {
      name: 'Standard',
      description: 'Standard usage plan'
    });

    // Add API stage to usage plan
    usagePlan.addApiStage({
      api: this.api,
      stage: this.api.deploymentStage
    });

    // Associate API key with usage plan
    usagePlan.addApiKey(this.apiKey);
    // 
  }
}

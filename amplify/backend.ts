import { defineBackend } from '@aws-amplify/backend';
import { auth } from './auth/resource';
import { data } from './data/resource';
import { storage } from './storage/resource'
import { CfnUser } from 'aws-cdk-lib/aws-iam';

/**
 * @see https://docs.amplify.aws/react/build-a-backend/ to add storage, functions, and more
 */
const backend = defineBackend({
  auth,
  data,
  storage
});

const { cfnUserPoolClient } = backend.auth.resources.cfnResources;

cfnUserPoolClient.explicitAuthFlows = [ 'ALLOW_USER_PASSWORD_AUTH', "ALLOW_REFRESH_TOKEN_AUTH", "ALLOW_USER_SRP_AUTH" ];

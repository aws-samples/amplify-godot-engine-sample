import { defineBackend } from '@aws-amplify/backend';
import { storage } from './storage/resource';
import * as iam from "aws-cdk-lib/aws-iam"
/**
 * @see https://docs.amplify.aws/react/build-a-backend/ to add storage, functions, and more
 */
const backend = defineBackend({
    storage: storage
});
backend.storage.resources.bucket.grantWrite(new iam.ServicePrincipal("amplify.amazonaws.com"))
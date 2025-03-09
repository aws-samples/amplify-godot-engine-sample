import { defineFunction } from "@aws-amplify/backend";
import { defineBackend } from '@aws-amplify/backend';
import { FirehoseToS3 } from '../../analytics/resource';
import * as iam from 'aws-cdk-lib/aws-iam';
//defines lambda function in handler.ts, passes environment variable containing stream name
export const myApiFunction = defineFunction({name: "api-function",
    environment: {
      FIREHOSE_STREAM_NAME: `${process.env.STACK_NAME}-game-analytics-firehosestream`
    }
  });


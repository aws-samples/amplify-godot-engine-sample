import * as firehose from "aws-cdk-lib/aws-kinesisfirehose";
import {
  Policy,
  Effect,
  PolicyStatement,
  Role,
  ServicePrincipal,
} from "aws-cdk-lib/aws-iam";
import { Construct } from "constructs";
import { CfnDeliveryStream } from "aws-cdk-lib/aws-kinesisfirehose";
import { Duration } from "aws-cdk-lib";
import { Bucket } from "aws-cdk-lib/aws-s3";
import { IBucket } from "aws-cdk-lib/aws-s3";
export interface FirehoseProps {
    bucket: IBucket;
    streamName: string;
  }
  export class FirehoseToS3 extends Construct {
    public readonly deliveryStream: CfnDeliveryStream;
    public readonly role: Role;
  
    constructor(scope: Construct, id: string, props: FirehoseProps) {
      super(scope, id);
  
      // Create IAM role for Firehose
      this.role = new Role(scope, `${props.streamName}-role`, {
        assumedBy: new ServicePrincipal("firehose.amazonaws.com"),
        description: `IAM role for Firehose stream ${props.streamName}`,
      });
  
      // Add S3 permissions to the role
      this.role.addToPolicy(
        new PolicyStatement({
          effect: Effect.ALLOW,
          actions: [
            "s3:AbortMultipartUpload",
            "s3:GetBucketLocation",
            "s3:GetObject",
            "s3:ListBucket",
            "s3:ListBucketMultipartUploads",
            "s3:PutObject",
          ],
          resources: [
            props.bucket.bucketArn,
            `${props.bucket.bucketArn}/*`,
          ],
        })
      );
  
      // Create the Firehose delivery stream
      this.deliveryStream = new CfnDeliveryStream(
        scope,
        `${props.streamName}`,
        {
          deliveryStreamName: props.streamName,
          deliveryStreamType: "DirectPut",
          s3DestinationConfiguration: {
            bucketArn: props.bucket.bucketArn,
            roleArn: this.role.roleArn,
            bufferingHints: {
              intervalInSeconds: 0,
              sizeInMBs: 1,
            },
            prefix: "data/!{timestamp:yyyy}/!{timestamp:MM}/!{timestamp:dd}",
            errorOutputPrefix: "errors/!{firehose:error-output-type}/!{timestamp:yyyy}/!{timestamp:MM}/!{timestamp:dd}",
            compressionFormat: "GZIP",
          },
        }
      );
    }
  }
  


//build a glue crawler
import { Stack, StackProps } from 'aws-cdk-lib';
import { Construct } from 'constructs';
import { aws_glue as glue } from 'aws-cdk-lib';
import { aws_iam as iam } from 'aws-cdk-lib';
import { aws_s3 as s3 } from 'aws-cdk-lib';
import { IBucket } from 'aws-cdk-lib/aws-s3';

export interface glueprops
{
    bucket: IBucket;
    databaseName: string;
    tableName: string; 
}

export class gluecrawler extends Construct {
    public crawler: glue.CfnCrawler;
    public database: glue.CfnDatabase;
    public table: glue.CfnTable;
    public role: iam.Role;
    public readonly tableName: string;

    constructor(scope: Construct, id: string, props: glueprops) {
        super(scope, id);
        this.tableName = props.tableName;
        // Create IAM role for Glue
        this.role = new iam.Role(this, 'GlueRole', {
            assumedBy: new iam.ServicePrincipal('glue.amazonaws.com'),
            description: 'Role for Glue crawler and catalog',
        });

        // Add managed policy for Glue service
        this.role.addManagedPolicy(
            iam.ManagedPolicy.fromAwsManagedPolicyName('service-role/AWSGlueServiceRole')
        );

        // Add S3 read permissions for the specific bucket
        this.role.addToPolicy(new iam.PolicyStatement({
            effect: iam.Effect.ALLOW,
            actions: [
                's3:GetObject',
                's3:ListBucket'
            ],
            resources: [
                props.bucket.bucketArn,
                `${props.bucket.bucketArn}/*`
            ],
        }));

        
        


        // Create the database
        this.database = new glue.CfnDatabase(this, 'glueDatabase', {
            catalogId: Stack.of(this).account,
            databaseInput: {
                name: props.databaseName,
                description: `Database for ${props.databaseName}`,
            }
        });
        // Create the table
        /*this.table = new glue.CfnTable(this, 'glueTable', {
            databaseName: props.databaseName,
            catalogId: Stack.of(this).account,
            tableInput: {
                name: props.tableName,
                description: `Table for ${props.tableName}`,
                tableType: 'EXTERNAL_TABLE',
                storageDescriptor: {
                    location: `s3://${props.bucket.bucketName}`,
                    inputFormat: 'org.apache.hadoop.mapred.TextInputFormat',
                    outputFormat: 'org.apache.hadoop.hive.ql.io.HiveIgnoreKeyTextOutputFormat',
                    serdeInfo: {
                        serializationLibrary: 'org.apache.hadoop.hive.serde2.lazy.LazySimpleSerDe',
                        parameters: {
                            'serialization.format': '1',
                            'ignore.malformed.json': 'true',
                            'case.insensitive': 'true',
                            'dots.in.keys': 'false'
                        }
                    },
                    compressed: false,
                    storedAsSubDirectories: false,
                    parameters: {
                        'classification': 'json'
                    },
                    columns: [
                        { name: 'Event', type: 'struct<Ad_Clicked:string,Event_Type:string,Genre_Selected:string,Score:int,X_Position:float,Y_Position:float>' },
                        { name: 'Game_Build', type: 'int' },
                        { name: 'Session_Id', type: 'string' },
                        { name: 'Time', type: 'string' },
                        { name: 'User_Id', type: 'string' },
                        { name: 'Version', type: 'int' }
                    ]
                }
            }
        });*/

        this.table = new glue.CfnTable(this, 'glueTable', {
            databaseName: props.databaseName,
            catalogId: Stack.of(this).account,
            tableInput: {
                name: props.tableName,
                description: `Table for ${props.tableName}`,
                storageDescriptor: {
                    location: `s3://${props.bucket.bucketName}`,
                    inputFormat: 'org.apache.hadoop.mapred.TextInputFormat',
                    outputFormat: 'org.apache.hadoop.hive.ql.io.HiveIgnoreKeyTextOutputFormat',
                    serdeInfo: {
                        serializationLibrary: 'org.apache.hadoop.hive.serde2.lazy.LazySimpleSerDe',
                        parameters: {
                            'serialization.format': '1'
                        }
                    }
                }
            }
        });

        // Create the crawler
        this.crawler = new glue.CfnCrawler(this, 'gluecrawler', {
            role: this.role.roleArn,
            targets: {
                s3Targets: [
                    {
                        path: `s3://${props.bucket.bucketName}`
                    }
                ]
            },
            databaseName: props.databaseName,
            name: props.tableName,
            schedule: {
                scheduleExpression: 'cron(15 12 * * ? *)'
            },
            schemaChangePolicy: {
                updateBehavior: 'UPDATE_IN_DATABASE',
                deleteBehavior: 'LOG'
            },
            

        });

        
        this.crawler.addDependency(this.database);
        this.table.addDependency(this.database);
    }
}
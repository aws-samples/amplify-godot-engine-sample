# Amplify Godot Engine Sample

This project will provide sample code and explanation on how to build and deploy a game with AWS Amplify.
We are using the popular open source game engine Godot: https://godotengine.org/

## Prerequisites

### Allow your amplify app build pipeline to deploy to S3

#### 1. Create the Amplify Service Role

see [Create a service role for your amplify app](https://docs.aws.amazon.com/amplify/latest/userguide/how-to-service-role-amplify-console.html)

### 2. Create and Attach the Policy

1. Go to your Amplify service role.
2. Go to the **Permissions** tab.
3. Click on the **Add inline policy** button.
4. Switch to the **JSON** tab in the policy creation screen.
5. Copy and paste the following policy JSON, which grants the necessary S3 permissions:

    ```json
    {
        "Version": "2012-10-17",
        "Statement": [
            {
                "Effect": "Allow",
                "Action": [
                    "s3:PutObject",
                    "s3:PutObjectAcl",
                    "s3:ListBucket"
                ],
                "Resource": [
                    "arn:aws:s3:::amplify*",
                    "arn:aws:s3:::amplify*/*"
                ]
            }
        ]
    }
    ```

6. Click on **Review policy**.
7. Name your policy (e.g., `AmplifyS3DeployPolicy`) and click on **Create policy**.

## Security

See [CONTRIBUTING](CONTRIBUTING.md#security-issue-notifications) for more information.

## License

This library is licensed under the MIT-0 License. See the LICENSE file.

const { APIGatewayClient, GetApiKeyCommand } = require("@aws-sdk/client-api-gateway");

exports.handler = async (event) => {
  const client = new APIGatewayClient();
  const apiKeyId = event.ResourceProperties.apiKeyId;
  
  try {
    const command = new GetApiKeyCommand({
      apiKey: apiKeyId,
      includeValue: true
    });
    const response = await client.send(command);
    return {
      PhysicalResourceId: apiKeyId,
      Data: {
        apiKeyValue: response.value
      }
    };
  } catch (error) {
    console.error('Error:', error);
    throw error;
  }
};


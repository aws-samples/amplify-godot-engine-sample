import type { Handler } from "aws-lambda";
import { BedrockAgentRuntimeClient, InvokeAgentCommand } from "@aws-sdk/client-bedrock-agent-runtime";
import { STSClient, AssumeRoleCommand } from "@aws-sdk/client-sts";
import { AwsCredentialIdentity } from "@aws-sdk/types";

const stsClient = new STSClient({ region: "us-east-1" });

// Improve typing for getCredentials
async function getCredentials(): Promise<AwsCredentialIdentity> {
  const params = {
    // RoleArn: process.env.CROSS_ACCOUNT_ROLE_ARN,
    RoleArn: "arn:aws:iam::495599745041:role/GenAIHelperAgent-Sandbox",
    RoleSessionName: "BedrockAgentCrossAccountSession",
    DurationSeconds: 900
  };

  try {
    const command = new AssumeRoleCommand(params);
    const response = await stsClient.send(command);
    
    if (!response.Credentials?.AccessKeyId || 
        !response.Credentials?.SecretAccessKey || 
        !response.Credentials?.SessionToken) {
      throw new Error("Failed to get valid credentials");
    }

    return {
      accessKeyId: response.Credentials.AccessKeyId,
      secretAccessKey: response.Credentials.SecretAccessKey,
      sessionToken: response.Credentials.SessionToken
    };
  } catch (error) {
    console.error("Error assuming role:", error);
    throw error;
  }
}

function cleanResponse(text: string): string {
  // Remove common source reference patterns and markdown formatting
  let cleaned = text
    // Remove markdown style links while keeping link text
    .replace(/\[([^\]]+)\]\([^\)]+\)/g, '$1')
    
    // Remove URL references
    .replace(/(?:https?:\/\/)?(?:www\.)?[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9()]{1,6}\b(?:[-a-zA-Z0-9()@:%_\+.~#?&\/=]*)/g, '')
    
    // Remove "Source:" or "Reference:" lines
    .replace(/(?:Source|Reference)s?:.*(?:\r?\n|$)/g, '')
    
    // Remove citations like [1], [2], etc.
    .replace(/\[\d+\]/g, '')
    
    // Remove markdown headers (#, ##, etc.)
    .replace(/^#+\s*/gm, '')
    
    // Remove markdown bold and italic
    .replace(/\*\*(.+?)\*\*/g, '$1')  // Bold
    .replace(/\*(.+?)\*/g, '$1')      // Italic
    .replace(/_(.+?)_/g, '$1')        // Underscore italic
    
    // Remove markdown code blocks and inline code
    .replace(/```[\s\S]*?```/g, '')   // Code blocks
    .replace(/`([^`]+)`/g, '$1')      // Inline code
    
    // Remove markdown lists
    .replace(/^\s*[-*+]\s+/gm, '')    // Unordered lists
    .replace(/^\s*\d+\.\s+/gm, '')    // Ordered lists
    
    // Remove blockquotes
    .replace(/^\s*>\s+/gm, '')
    
    // Clean up any double spaces or empty lines created by removals
    .replace(/\n\s*\n\s*\n/g, '\n\n')
    .replace(/  +/g, ' ')
    .trim();

  return cleaned;
}

export const handler: Handler = async (event) => {
  console.log(event)
  const { prompt } = event.arguments;

  try {
    const credentials = await getCredentials();

    const bedrockAgentClient = new BedrockAgentRuntimeClient({
      region: "us-west-2",
      credentials
    });

    const response = await bedrockAgentClient.send(
      new InvokeAgentCommand({
        agentId: process.env.AGENT_ID || "TEHSL4B2MV",
        agentAliasId: process.env.AGENT_ALIAS_ID || "Y5CNEKZP7D",
        sessionId: event.arguments.sessionId || "default-session",
        inputText: prompt
      })
    );

    // Process the event stream
    let finalAnswer = '';
    const eventStream = response.completion;

    const decoder = new TextDecoder('utf-8');
    console.log(response)
    if (eventStream) {
      console.log(eventStream)
      for await (const event of eventStream) {

        if ('chunk' in event) {
          const chunk = event.chunk?.bytes;
          console.log(chunk)
          finalAnswer += decoder.decode(chunk);
        }
        // Optionally process other event types
        if ('trace' in event) {
          console.log('Trace data:', event.trace);
        }
      }
    }

    console.log(response)

    // Clean the response before sending it back
    const cleanedAnswer = cleanResponse(finalAnswer);

    return {
      statusCode: 200,
      body: { answer: cleanedAnswer },
    };
  } catch (error) {
    console.error("Error processing request:", error);
    return {
      statusCode: 500,
      body: { error: `There was an error: ${error}` },
    };
  }
};

import type { Handler } from "aws-lambda";
import { BedrockRuntimeClient, ConverseCommand, ConversationRole } from "@aws-sdk/client-bedrock-runtime";

const bedrockClient = new BedrockRuntimeClient({ region: "us-east-1" });

/**
 * Polly the Parrot AI Commentary Function (Uses Leaderboard Provided in Prompt)
 */
export const handler: Handler = async (event) => {
  const { prompt } = event.arguments; // User's leaderboard input as a string

  console.log(event)
  console.log(prompt)

  try {
    // Final input for Polly with user-provided leaderboard
    const fullPrompt = `Here be the scoreboard:\n${prompt}\nTell Polly where the player stands!`;

    console.log("Final Prompt for Polly:", fullPrompt);

    // System Prompt: Polly's Behavior Instructions
    const systemPrompt = [
      {
        text: `Squawk! You're to Polly the Parrot, the most fearsome feathered pirate commentator! 
        - Polly repeats words! Squawk! Likes rhymes! Arrr!
        - Share where they are in the leaderboard, then continue.
        - If player passes a pirate, Polly cheers! "Squawk! Ye beat ‘em, beat ‘em!"
        - If they trail behind, Polly mocks! "Laggin’! Laggin’! Squawk!"
        - If the player's score is higher than all pirates, Polly compares them to Legend of the Sea who is on the top of the leaderboard.
        - 20 words MAX! No more! 
        - If there is nothing for the leaderboard, then there are not leaders. If there are no leaders, then the person playing is in first place.
        - Only use names from the provided scoreboard.
        - Responses must be in a piratey, parrot-like manner. No extra explanations.
        `
      }
    ];

    // User Input (Leaderboard & Player Score)
    const conversation = [
      {
        role: ConversationRole.USER, // Fix: Use uppercase `USER`
        content: [{ text: fullPrompt }]
      }
    ];

    // Inference Configurations for Faster, Controlled Response
    const inferenceConfig = {
      maxTokens: 50,
      temperature: 0.7
    };

    // Send request to Amazon Bedrock
    const response = await bedrockClient.send(
      new ConverseCommand({
        modelId: "amazon.nova-micro-v1:0",
        system: systemPrompt,
        messages: conversation,
        inferenceConfig,
      })
    );

    // Handle Bedrock Response
    const responseText = response.output?.message?.content?.[0]?.text || "Squawk! Polly got no words! Try again!";

    console.log("Polly's Response:", responseText);

    return {
      statusCode: 200,
      body: { commentary: responseText },
    };
  } catch (error) {
    console.error("Error processing request:", error);
    return {
      statusCode: 500,
      body: { error: `There was an error: ${error}` },
    };
  }
};

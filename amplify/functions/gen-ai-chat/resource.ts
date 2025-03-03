import { defineFunction } from "@aws-amplify/backend";

export const GenAiChat = defineFunction({
  name: "gen-ai-chat",
  entry: "./handler.ts",
  timeoutSeconds: 60 
});

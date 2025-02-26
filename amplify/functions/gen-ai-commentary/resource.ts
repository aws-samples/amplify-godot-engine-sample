import { defineFunction} from "@aws-amplify/backend";

export const GenAiCommentary = defineFunction({
  name: "gen-ai-commentary",
  entry: "./handler.ts",
  timeoutSeconds: 60 
});

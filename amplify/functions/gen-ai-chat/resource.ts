import { defineFunction, secret } from "@aws-amplify/backend";

export const GenAiChat = defineFunction({
  name: "gen-ai-chat",
  entry: "./handler.ts",
  timeoutSeconds: 60,
  environment: {
    AGENT_ID: secret("AGENT_ID"),
    AGENT_ALIAS_ID: secret("AGENT_ALIAS_ID"),
  }
});

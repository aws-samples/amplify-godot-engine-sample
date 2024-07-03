import { defineStorage } from '@aws-amplify/backend';

export const storage = defineStorage({
  name: 'gameBuilds',
  access: (allow) => ({
    'releases/*': [
      allow.authenticated.to(['read']) // additional actions such as "write" and "delete" can be specified depending on your use case
    ]
  })
});
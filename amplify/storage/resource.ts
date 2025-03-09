import { defineStorage } from "@aws-amplify/backend";

export const storage = defineStorage({
  name: 'builds',
  isDefault: true
})


export const analyticsstorage =  defineStorage({
  name: 'analytics'
  
})

export const gluestorage =  defineStorage({
  name: 'gluebucket'
})
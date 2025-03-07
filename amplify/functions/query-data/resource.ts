import { defineFunction } from "@aws-amplify/backend";
import {backend} from  '../../backend';

//defines lambda function in handler.ts, passes environment variable containing stream name

export const queryFunction = defineFunction({name: "query-data",
    environment: {
      DATABASE_NAME:  `${process.env.STACK_NAME}-gdcgameanalytics`,
    }
  });
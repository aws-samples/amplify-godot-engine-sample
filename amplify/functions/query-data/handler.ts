import { 
    AthenaClient, 
    StartQueryExecutionCommand, 
    GetQueryResultsCommand,
    GetQueryExecutionCommand,
    QueryExecutionState,
    GetQueryResultsCommandOutput,
    Row as AthenaRow
} from "@aws-sdk/client-athena";

// Create the Athena client
const client = new AthenaClient({ region: process.env.AWS_REGION });

async function executeAthenaQuery(query: string): Promise<AthenaRow[]> {
    // Start the query execution
    const startQueryResponse = await client.send(new StartQueryExecutionCommand({
        QueryString: query,
        WorkGroup: process.env.ATHENA_WORKGROUP || 'primary',
        ResultConfiguration: {
            OutputLocation: "s3://" + process.env.ATHENA_QUERY_LOCATION
        }
        
    }));

    const queryExecutionId = startQueryResponse.QueryExecutionId;
    if (!queryExecutionId) {
        throw new Error('Failed to get QueryExecutionId');
    }

    // Wait for the query to complete
    const maxRetries = 10;
    let retryCount = 0;
    
    while (retryCount < maxRetries) {
        // Check query execution status
        const executionResponse = await client.send(new GetQueryExecutionCommand({
            QueryExecutionId: queryExecutionId
        }));

        const status = executionResponse.QueryExecution?.Status?.State;

        switch (status) {
            case QueryExecutionState.SUCCEEDED:
                // Query completed successfully, get the results
                const results = await client.send(new GetQueryResultsCommand({
                    QueryExecutionId: queryExecutionId,
                }));
                
                if (results.ResultSet?.Rows) {
                    return results.ResultSet.Rows;
                }
                throw new Error('No results returned');

            case QueryExecutionState.FAILED:
                throw new Error(`Query failed: ${executionResponse.QueryExecution?.Status?.StateChangeReason}`);

            case QueryExecutionState.CANCELLED:
                throw new Error('Query was cancelled');

            case QueryExecutionState.QUEUED:
            case QueryExecutionState.RUNNING:
                // Wait before checking again
                await new Promise(resolve => setTimeout(resolve, 1000));
                retryCount++;
                continue;
        }
    }

    throw new Error('Query execution timed out');
}

interface LambdaEvent {
    [key: string]: unknown;
}
const tableName = process.env.TABLE_NAME?.replace(/-/g, '_')
const databaseName = process.env.DATABASE_NAME

export const handler = async (event: LambdaEvent) => {
    try {

        const query = `
            SELECT 
                COUNT(CASE WHEN "event"."ad_clicked" = 'personalized' THEN 1 END) as personalized_count,
                COUNT(CASE WHEN "event"."ad_clicked" = 'neutral' THEN 1 END) as neutral_count
            FROM "${databaseName}"."${tableName}"
            WHERE "event"."ad_clicked" IN ('personalized', 'neutral')
        `;

        const rows = await executeAthenaQuery(query);
        
        if (!rows || rows.length < 2) {
            console.log('Error, no rows returned');
            throw new Error('No results returned from query');
            
        }

        // Ensure data exists and has the expected structure
        const data = rows[1].Data;
        if (!data || data.length < 2) {
            console.log('Error, invalid response');
            throw new Error('Invalid data structure returned from query');
        }

        const personalizedCount = parseInt(data[0].VarCharValue || '0');
        const neutralCount = parseInt(data[1].VarCharValue || '0');
        console.log('Successfully retrieved ad click counts', personalizedCount, neutralCount)
        return {
            statusCode: 200,
            body: JSON.stringify({
                message: "Successfully retrieved ad click counts",
                data: {
                    personalizedClicks: personalizedCount,
                    neutralClicks: neutralCount
                }
            })
        };
    } catch (error: unknown) {
        console.error('Error:', error);
        return {
            statusCode: 500,
            body: JSON.stringify({
                message: "Error retrieving ad click counts " + tableName + " " + databaseName,
                error: error instanceof Error ? error.message : 'Unknown error occurred'
            })
        };
    }
};
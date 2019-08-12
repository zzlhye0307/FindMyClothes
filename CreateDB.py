import boto3

dynamodb = boto3.resource('dynamodb')

table = dynamodb.create_table(
	TableName = 'Products',
	KeySchema = [
		{
			'AttributeName': 'id',
			'KeyType': 'HASH'
		}
	],
	AttributeDefinitions = [
		{
			'AttributeName': 'id',
			'AttributeType': 'N'
		}
	],
	ProvisionedThroughput = {
		'ReadCapacityUnits': 5,
		'WriteCapacityUnits': 5
	}
)

table.meta.client.get_waiter('table_exists').wait(TableName='Products')

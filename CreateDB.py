import boto3

dynamodb = boto3.resource('dynamodb')

table = dynamodb.create_table(
	TableName = 'Products',
	KeySchema = [
		{
			'AttributeName': 'shopname',
			'KeyType': 'HASH'
		},
		{
			'AttributeName': 'title',
			'KeyType': 'HASH'
		}
	],
	AttributeDefinitions = [
		{
			'AttributeName': 'shopname',
			'AttributeType': 'S'
		},
		{
			'AttributeName': 'title',
			'AttributeType': 'S'
		}
	],
	ProvisionedThroughput = {
		'ReadCapacityUnits': 10,
		'WriteCapacityUnits': 10
	}
)

table.meta.client.get_waiter('table_exists').wait(TableName='Products')

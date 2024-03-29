# -*- coding: utf-8 -*-
import boto3

dynamodb = boto3.resource('dynamodb')
table = dynamodb.Table('Products')

with open('/home/ubuntu/Desktop/ProductsInfo', "rt") as f:
    products = f.readlines()

with open('/home/ubuntu/Desktop/MatchedProducts', "rt") as f:
    labels = f.readlines()

with table.batch_writer() as batch:
    for i in range(0, len(products)):
        batch.put_item(
            Item={
                'link': products[i].split("\'")[1],
                'img': products[i].split("\'")[3],
                'title': products[i].split("\'")[5],
                'price': products[i].split("\'")[7],
		'shopname': products[i].split("\'")[11],
                'category': labels[i].split("\'")[1],
                'fabric': labels[i].split("\'")[3],
                'pattern': labels[i].split("\'")[5],
                'sum': int(labels[i].split("\'")[7]),
		'variance': int(labels[i].split("\'")[9])
            }
        )

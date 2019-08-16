//
//  Products.swift
//  Project
//
//  Created by mac on 13/08/2019.
//  Copyright © 2019 mac. All rights reserved.
//

import Foundation
import UIKit
import AWSDynamoDB
import AWSMobileClient
import AWSAuthCore

class Products: AWSDynamoDBObjectModel, AWSDynamoDBModeling {
    @objc var _id: NSNumber?
    @objc var _category: String?
    @objc var _pattern: String?
    @objc var _fabric: String?
    @objc var img: String?
    @objc var _title: String?
    @objc var link: String?
    @objc var price: String?
    @objc var variance: NSNumber?
    @objc var sum: NSNumber?
    @objc var _desc: String?
    
    static func dynamoDBTableName() -> String {
        return "Products"
    }
    
    static func hashKeyAttribute() -> String {
        return "_id"
    }
    
    override class func jsonKeyPathsByPropertyKey() -> [AnyHashable: Any] {
        return [
            "_id" : "id",
            "_category" : "category",
            "_pattern" : "pattern",
            "_fabric" : "fabric",
            "img" : "img",
            "_title" : "title",
            "link" : "link",
            "price" : "price",
            "variance" : "variance",
            "sum" : "sum",
            "_desc" : "desc"
        ]
    }
    
    func readItems() {
        let dynamoDBObjectMapper = AWSDynamoDBObjectMapper.default()
        
//        let items: Products = Products()
        
        dynamoDBObjectMapper.load(Products.self, hashKey: 1, rangeKey: "피크린넨반팔JK").continueWith{ (task: AWSTask<AnyObject>) -> Any? in
            print("data loading......")
            if let error = task.error as? NSError {
                print("error is occured during loading")
                print("----------------\n\(error)")
                return nil
            }
            let output = task.result as! Products
            
            for info in output._title! {
                print(info)
            }
            return nil
        }
    }
    
    func queryItems() {
        let queryExpression = AWSDynamoDBQueryExpression()
        
        queryExpression.keyConditionExpression = "#id = :Id"
        
        queryExpression.expressionAttributeNames = [
            "#id": "id"
        ]
        
        queryExpression.expressionAttributeValues = [
            ":Id" : 1000
        ]
 
        let dynamoDBObjectMapper = AWSDynamoDBObjectMapper.default()
        
        dynamoDBObjectMapper.query(Products.self, expression: queryExpression) { (output: AWSDynamoDBPaginatedOutput?, error: Error?) in
            if error != nil {
                print("The request is failed. Error: \(String(describing: error))")
            }
            if output != nil {
                for clothes in output!.items {
                    let clothesItem = clothes as! Products
                    print("\(clothesItem._title!)")
                    print("\(clothesItem._desc!)")
                    print("\(clothesItem.img!)")
                }
            }
        }
    }
    
    func scanItems(category: String, pattern: String, fabric: String) {
        var count = 0
        let scanExpression = AWSDynamoDBScanExpression()
        scanExpression.filterExpression = "#category = :Category AND #pattern = :Pattern AND #fabric = :Fabric"
        scanExpression.expressionAttributeNames = [
            "#category": "category",
            "#pattern": "pattern",
            "#fabric": "fabric"
        ]
        scanExpression.expressionAttributeValues = [
            ":Category" : category,
            ":Pattern" : pattern,
            ":Fabric" : fabric
        ]
        let dynamoDBObjectMapper = AWSDynamoDBObjectMapper.default()
        
        dynamoDBObjectMapper.scan(Products.self, expression: scanExpression) {(output: AWSDynamoDBPaginatedOutput?, error: Error?) in
            if error != nil {
                print("The request is failed. Error: \(String(describing: error))")
            }
            /*
            var page = 1
            while (true) {
                print("<Page : \(page)>")
                if output != nil {
                    print("******SCAN RESULT*******")
                    for clothes in output!.items {
                        let clothesItem = clothes as! Products
                        print("\(count) | [\(clothesItem._id!)]")
                        print("\(clothesItem._title!)")
                        print("\(clothesItem._desc!)")
                        count += 1
                    }
                }
                else {
                    break
                }
                output?.loadNextPage()
                page += 1
            }
            */
            if output != nil {
                testId.removeAll()
                testTitle.removeAll()
                testPrice.removeAll()
                testImgLink.removeAll()
                testLink.removeAll()
                print("******SCAN RESULT*******")            
                for clothes in output!.items {
                    let clothesItem = clothes as! Products
                    print("\(count) | [\(clothesItem._id!)]")
                    print("\(clothesItem._title!)")
                    print("\(clothesItem._desc!)")
                    testId.append(clothesItem._id as! Int)
                    testTitle.append(clothesItem._title!)
                    testImgLink.append(clothesItem.img!)
                    testLink.append(clothesItem.link!)
                    testPrice.append(clothesItem.price!)
                    count += 1
                }
            }
            print("total: \(count)")
            print("************************")
            print("Check")
            for i in 0 ..< testId.count {
                print("[\(i)] : \(testId[i]) and \(testTitle[i])")
                print(testImgLink[i])
            }
            isFinished = true
            print("after Scan \(testId.count)")
        }
    }
}

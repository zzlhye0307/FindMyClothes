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
            
            if output != nil {
                test.removeAll()
                print("******SCAN RESULT*******")            
                for clothes in output!.items {
                    let clothesItem = clothes as! Products
                    if (!self.isAvailableAddress(clothesItem.img!)) {
                        clothesItem.img = "https:" + clothesItem.img!
                    }
                    test.append(clothesItem)
                    count += 1
                }
            }
            self.sortArrayByPriority()
            print("total: \(count)")
//            print("************************")
//            print("Check")
            isFinished = true
//            print("after Scan \(test.count)")
        }
    }
    
    func isAvailableAddress(_ link: String) -> Bool {
        if (link.hasPrefix("http:")) {
            return true
        }
        else if (link.hasPrefix("https://")) {
            return true
        }
        else {
            return false
        }
    }
    
    func sortArrayByPriority() {
        test = test.sorted(by: {
            if $0.sum != $1.sum {
                return Int(truncating: $0.sum!) > Int(truncating: $1.sum!)
            }
            else {
                return Float(truncating: $0.variance!) < Float(truncating: $1.variance!)
            }
        })
    }
    
}

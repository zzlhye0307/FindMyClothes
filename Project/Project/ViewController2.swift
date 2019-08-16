//
//  ViewController2.swift
//  
//
//  Created by mac on 12/08/2019.
//

import UIKit
import AWSCore
import AWSDynamoDB
import AWSMobileClient
import AWSAuthCore
import SDWebImage

class ViewController2: UIViewController {

    @IBOutlet var imgView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("view controller2 in")
        
        imgView.sd_setImage(with: URL(string: "https://66girls.co.kr/web/product/medium/201902/30cbf05ae76561c1d8d9805a28bda97c.jpg"))
        
        let dynamoDB = AWSDynamoDB.default()
        let listTableInput = AWSDynamoDBListTablesInput()
        
        dynamoDB.listTables(listTableInput!).continueWith{ (task:AWSTask<AWSDynamoDBListTablesOutput>) -> Any? in
            print("----------DB CONNECT---------")
            if let error = task.error as? NSError {
                print("Error occured")
                print("----------------------------\n\(error)")
                return nil
            }
            let listTablesOutput = task.result
            
            for tableName in listTablesOutput!.tableNames! {
                print("\(tableName)")
            }
            return nil
        }
        /*
        let batchTableInput = try! AWSDynamoDBBatchGetItemInput(dictionary: ["TableName": "Products"], error: ( print("batch error")))
        dynamoDB.batchGetItem(batchTableInput).continueWith{ (task:AWSTask<AWSDynamoDBBatchGetItemOutput>) -> Any? in
            print("---------BATCH ITEM-----------")
            if let error = task.error as? NSError {
                print("batch error occured")
                print("-------------------------------\n\(error)")
                return nil
            }
            let listItemsOutput = task.result
//            for item in listItemsOutput!. {
                
//            }
            return nil
        }
 */
        let item = Products()
        print(isFinished)
        print("#1 : \(testId.count)")
        item?.scanItems(category: "dress", pattern: "stripe", fabric: "cotton")
        print(isFinished)
        print("#2 : \(testId.count)")
        while (!isFinished) {
            print("while: \(isFinished)")
            Thread.sleep(forTimeInterval: 0.1)
        }
        print("#3 : \(testId.count)")
    }
}

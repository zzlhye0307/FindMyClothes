//
//  RecentViewController.swift
//  Project
//
//  Created by mac on 07/08/2019.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit
import CoreData

class RecentViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    let CELL_HEIGHT: CGFloat = 85.0
    
    var userLog: [NSManagedObject] = []
    
   @IBOutlet var recentView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchLogData()
        recentView.delegate = self
        recentView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        fetchLogData()
        recentView.reloadData()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userLog.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CELL_HEIGHT
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "logCell") as! RecentViewCell
        let rowIndex = indexPath.row
        let log = userLog[rowIndex] as! Log
        
        cell.recentImgView.image = UIImage(data: log.img!)
        cell.recentCategoryLbl.text = log.category!
        cell.recentPatternLbl.text = log.pattern!
        cell.recentFabricLbl.text = log.fabric!
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd - HH:mm:ss"
        cell.recentDateLbl.text = formatter.string(from: log.date!)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let rowIndex = indexPath.row
            deleteLogData(index: rowIndex)
            userLog.remove(at: rowIndex)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "삭제"
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "logCell") as! RecentViewCell
        let cell = tableView.cellForRow(at: indexPath) as! RecentViewCell
        let category = cell.recentCategoryLbl.text!
        let pattern = cell.recentPatternLbl.text!
        let fabric = cell.recentFabricLbl.text!
        
        let resultView = self.storyboard?.instantiateViewController(withIdentifier: "searchResultView") as! SearchResultViewController
        resultView.categoryResult = category
        resultView.patternResult = pattern
        resultView.fabricResult = fabric
        present(resultView, animated: true, completion: nil)
    }
    func fetchLogData() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Log")
        do {
            userLog = try managedContext.fetch(fetchRequest)
        } catch let error as NSError{
            print("error: \(error)")
        }
    }
    
    func deleteLogData(index: Int) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        let logToDelete = userLog[index]
        managedContext.delete(logToDelete)
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("error: \(error)")
        }
    }
    
    @IBAction func editBtnPressed(_ sender: UIBarButtonItem) {
        if recentView.isEditing {
            sender.title = "Edit"
            recentView.setEditing(false, animated: true)
        }
        else {
            sender.title = "Done"
            recentView.setEditing(true, animated: true)
        }

    }
}

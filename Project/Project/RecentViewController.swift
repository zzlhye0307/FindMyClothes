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
        formatter.dateFormat = "yyyy.MM.dd - HH:mm:ss"
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
        let cell = tableView.cellForRow(at: indexPath) as! RecentViewCell
        let category = cell.recentCategoryLbl.text!.lowercased()
        let pattern = cell.recentPatternLbl.text!.lowercased()
        let fabric = cell.recentFabricLbl.text!
        
        let resultView = self.storyboard?.instantiateViewController(withIdentifier: "searchResultView") as! SearchResultViewController
        isFinished = false
        let item = Products()
        item?.scanItems(category: category, pattern: pattern, fabric: fabric)

        while (!isFinished) {
            Thread.sleep(forTimeInterval: 0.3)
        }
        
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
    
    func deleteAll() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        fetchLogData()
        for log in userLog {
            managedContext.delete(log)
        }
        try! managedContext.save()
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
    @IBAction func deleteAllBtn(_ sender: UIBarButtonItem) {
        let confirmAlarm = UIAlertController(title: "삭제", message: "전부 삭제하시겠습니까?", preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: "네", style: UIAlertAction.Style.default) { (Action) in
            self.deleteAll()
            self.viewWillAppear(true)
        }
        let noAction = UIAlertAction(title: "아니요", style: UIAlertAction.Style.default, handler: nil)
        confirmAlarm.addAction(okAction)
        confirmAlarm.addAction(noAction)
        present(confirmAlarm, animated: true, completion: nil)
    }
}

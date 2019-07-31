//
//  SecondViewController.swift
//  Project
//
//  Created by mac on 30/07/2019.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit

class FavoriteViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var items = ["[어커버] 타탄 체크 팬츠", "[스컬프터] 레트로 레투스-엣지 탑"]
    var itemsImageFile = ["top.jpg", "pants.jpg"]
    
    @IBOutlet var favoriteListView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        favoriteListView.delegate = self
        favoriteListView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        favoriteListView.reloadData()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath)
        let rowIndex = (indexPath as NSIndexPath).row
        
        cell.textLabel?.text = items[rowIndex]
        cell.imageView?.image = UIImage(named: itemsImageFile[rowIndex])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let rowIndex = (indexPath as NSIndexPath).row
        
        if editingStyle == .delete {
            items.remove(at: rowIndex)
            itemsImageFile.remove(at: rowIndex)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
        else if editingStyle == .insert {}
    }
    
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "삭제"
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let moveIndex = (sourceIndexPath as NSIndexPath).row
        let itemToMove = items[moveIndex]
        let itemImageToMove = itemsImageFile[moveIndex]
        items.remove(at: moveIndex)
        itemsImageFile.remove(at: moveIndex)
        
        let toIndex = (destinationIndexPath as NSIndexPath).row
        items.insert(itemToMove, at: toIndex)
        itemsImageFile.insert(itemImageToMove, at: toIndex)
    }
    
    @IBAction func editBtnPressed(_ sender: UIBarButtonItem) {
        if favoriteListView.isEditing {
            sender.title = "Edit"
            favoriteListView.setEditing(false, animated: true)
        }
        else {
            sender.title = "Done"
            favoriteListView.setEditing(true, animated: true)
        }
    }
}


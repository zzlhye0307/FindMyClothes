//
//  SecondViewController.swift
//  Project
//
//  Created by mac on 30/07/2019.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit
import CoreData
import SDWebImage
import SDWebImageWebPCoder

var storedFavoriteItems: [NSManagedObject] = []

class FavoriteViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    let CELL_HEIGHT: CGFloat = 80
    
    @IBOutlet var favoriteListView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        favoriteListView.delegate = self
        favoriteListView.dataSource = self
        fetchData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        fetchData()
        favoriteListView.reloadData()
    }
    
    func fetchData() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else{
            return
        }
        
        let managedObject = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Favorite")
        
        do {
            storedFavoriteItems = try managedObject.fetch(fetchRequest) as! [NSManagedObject]
        } catch let error as NSError {
            print("error : \(error)")
        }
    }
    
    func showData() {
        fetchData()
        
        print("*****************************************************")
        print("Favorite Table")
        for i in 0 ..< storedFavoriteItems.count {
            let myItem = storedFavoriteItems[i] as! Favorite
            print("---------------------------------------------------------")
            let id = myItem.id
            let title = myItem.title
            let price = myItem.price
            let link = myItem.link
            let imgLink = myItem.imgLink
//            let img = myItem.img
            print("id: \(id)")
            print("title: \(title!)")
            print("price: \(price!)")
            print("link: \(link!)")
            print("image link: \(imgLink)")
//            print("img: \(img!)")
        }
     }
    
    func insertData() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedObject = appDelegate.persistentContainer.viewContext
        
        let favoriteEntity = NSEntityDescription.entity(forEntityName: "Favorite", in: managedObject)!
        /*
        for i in 0 ..< 7 {
            let favorite = NSManagedObject(entity: favoriteEntity, insertInto: managedObject)
            let newImg = UIImage(named: itemsImageFile[i])?.jpegData(compressionQuality: 1.0)
            favorite.setValue((i+1), forKey: "id")
            favorite.setValue(itemsTitle[i], forKey: "title")
            favorite.setValue(itemsPrice[i], forKey: "price")
            favorite.setValue(itemsLink[i], forKey: "link")
            favorite.setValue(newImg, forKey: "img")
            managedObject.insert(favorite)
        }
        */
        do {
            managedObject.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
            try managedObject.save()
        } catch let error as NSError {
            print("error: \(error)")
        }
        
        print("Insert task is finished")
    }
    
    func deleteData(index: Int) {
        print("count: \(storedFavoriteItems.count)")
        if (index < storedFavoriteItems.count) {
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
                return
            }
            let managedObject = appDelegate.persistentContainer.viewContext
            let deleteObject = storedFavoriteItems[index]
        
            managedObject.delete(deleteObject)
            do {
                try managedObject.save()
            } catch let error as NSError {
                print("error : \(error)")
            }
            print("Delete task is finished")
            fetchData()
//            showData()
        }
        else {
            print("index is out of range")
        }
    }
    
    func deleteAll() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let managedObject = appDelegate.persistentContainer.viewContext
        fetchData()
        
        for i in 0 ..< storedFavoriteItems.count {
            let deleteObject = storedFavoriteItems[i]
            managedObject.delete(deleteObject)
        }
        
        do {
            try managedObject.save()
        } catch let error as NSError {
            print("error: \(error)")
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return storedFavoriteItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell") as! TableViewCell
        let rowIndex = (indexPath as NSIndexPath).row
        
        let favorite = storedFavoriteItems[rowIndex] as! Favorite
        
//        cell.cellImgView.image = UIImage(data: favorite.img!)
        cell.cellImgView.sd_setImage(with: URL(string: favorite.imgLink!))
        cell.cellTitleLabel.text = favorite.title
        cell.cellPriceLabel.text = favorite.price!
        cell.cellLikeBtn.setImage(cell.heartOn, for: UIControl.State.normal)
        cell.isHeartOn = true
        cell.tableView = self
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CELL_HEIGHT
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let rowIndex = (indexPath as NSIndexPath).row
        
        if editingStyle == .delete {
            deleteData(index: rowIndex)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
        else if editingStyle == .insert {}
    }
    
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "삭제"
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let rowIndex = (indexPath as NSIndexPath).row
        let urlString = storedFavoriteItems[rowIndex].value(forKey: "link") as! String
        
        openURL(urlString)
    }
    
    func openURL(_ urlString :String) {
        guard let url = URL(string: urlString) else { return }
        
        if (UIApplication.shared.canOpenURL(url)) {
            if #available(iOS 12, *) {
                UIApplication.shared.open(url, options: [:], completionHandler: {
                    (success) in
                    if success {
                        
                    }
                })
            }
            else {
                if UIApplication.shared.openURL(url) {}
            }
        }
        else {
            let failedAlert = UIAlertController(title: "URL Connection", message: "인터넷 연결에 실패했습니다", preferredStyle: UIAlertController.Style.alert)
            let action = UIAlertAction(title: "확인", style: UIAlertAction.Style.default, handler: nil)
            failedAlert.addAction(action)
            present(failedAlert, animated: true, completion: nil)
        }
    }
    
    func deleteHeartOffCell(_ cell: TableViewCell) {
        let indexPath = favoriteListView.indexPath(for: cell)!
        let removeIndex = (indexPath as NSIndexPath).row
        deleteData(index: removeIndex)
        favoriteListView.deleteRows(at: [indexPath], with: .fade)
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


//
//  SearchResultViewController.swift
//  Project
//
//  Created by mac on 30/07/2019.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit
import CoreData
import SDWebImage
import SDWebImageWebPCoder

var test: [Products] = []
var isFinished: Bool = false

class SearchResultViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource{
    @IBOutlet var infoLabel: UILabel!
    @IBOutlet var searchResultView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchResultView.delegate = self
        searchResultView.dataSource = self
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(SearchResultViewController.handleLongPress))
        longPress.minimumPressDuration = 0.5
        longPress.delegate = self
        searchResultView.addGestureRecognizer(longPress)
        if test.count == 0 {
            infoLabel.isHidden = false
        }
    }
    
    /* return the number of collection cells */
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return test.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = searchResultView.dequeueReusableCell(withReuseIdentifier: "resultCell", for: indexPath) as! CollectionViewCell
        let cellIndex = (indexPath as NSIndexPath).row
        let cellItem = test[cellIndex]
        
        let WebPCoder = SDImageWebPCoder.shared
        SDImageCodersManager.shared.addCoder(WebPCoder)

        cell.cellTitleLabel.text = cellItem._title
        cell.cellImageView.sd_setImage(with: URL(string: cellItem.img!))
        cell.cellPriceLabel.text = cellItem.price

        return cell
    }
        
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cellIndex = (indexPath as NSIndexPath).row
        
        let urlLink = test[cellIndex].link!
        
        openURL(urlLink)
    }
    // FavoriteViewController 에도 같은 코드 중복되므로 나중에 class 따로 분리하는 방법도 생각해보기
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

    
    @IBAction func goBackBtn(_ sender: UIBarButtonItem) {
        infoLabel.isHidden = true
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func respondToLongPressGesture(recognizer: UILongPressGestureRecognizer) {
        print("Favorite에 등록되었습니다")
    }
    
    func insertItemToFavorite(shop: String, title: String, price: String, link: String, imgLink: String) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        let favoriteEntity = NSEntityDescription.entity(forEntityName: "Favorite", in: managedContext)!
        let favoriteItem = NSManagedObject(entity: favoriteEntity, insertInto: managedContext)
        favoriteItem.setValue(shop, forKeyPath: "shop")
        favoriteItem.setValue(title, forKey: "title")
        favoriteItem.setValue(price, forKey: "price")
        favoriteItem.setValue(link, forKey: "link")
        favoriteItem.setValue(imgLink, forKey: "imgLink")
        
        do {
            managedContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
            try managedContext.insert(favoriteItem)
            try managedContext.save()
        } catch let error as NSError {
            print("Insert")
            print("error : \(error)")
        }
    }
    
    func isItemAlreadyExisted(shop: String, title: String) -> Bool {
        var result: Bool = false
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return true
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Favorite")
        fetchRequest.predicate = NSPredicate(format: "shop = %@ && title = %@", shop, title)
        
        do {
            let item = try managedContext.fetch(fetchRequest)
            if item.count != 0 {
                result = true
            }
        } catch let error as NSError {
            print("error : \(error)")
        }
        return result
    }
}

extension SearchResultViewController: UIGestureRecognizerDelegate {
    @objc public func handleLongPress(_ longPressGesture: UILongPressGestureRecognizer) {
        let p = longPressGesture.location(in: self.searchResultView)
        let indexPath = self.searchResultView.indexPathForItem(at: p)
        
        if indexPath == nil {
            print("Long press on table view, not row")
        }
        else if (longPressGesture.state == UIGestureRecognizer.State.began) {
            let cellIndex = (indexPath! as NSIndexPath).row
            let cellItem = test[cellIndex]
            
            let shop = cellItem.shop!
            let title = cellItem._title!
            let price = cellItem.price!
            let link = cellItem.link!
            let imgLink = cellItem.img!
            
            if isItemAlreadyExisted(shop: shop, title: title) {
                let failAlert = UIAlertController(title: "LIKE", message: "이미 Favorite에 등록되어있는 상품입니다.", preferredStyle: UIAlertController.Style.alert)
                let okAction = UIAlertAction(title: "ok", style: UIAlertAction.Style.default, handler: nil)
                failAlert.addAction(okAction)
                present(failAlert, animated: true, completion: nil)
            }
            else {
                let likeAlert = UIAlertController(title: "LIKE", message: "Favorite 에 등록되었습니다.",    preferredStyle: UIAlertController.Style.alert)
                let okAction = UIAlertAction(title: "ok", style: UIAlertAction.Style.default, handler: nil)
                likeAlert.addAction(okAction)
                present(likeAlert, animated: true, completion: nil)
            
                insertItemToFavorite(shop: shop, title: title, price: price, link: link, imgLink: imgLink)
            }
        }
    }
}

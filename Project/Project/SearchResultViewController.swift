//
//  SearchResultViewController.swift
//  Project
//
//  Created by mac on 30/07/2019.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit
import CoreData

var searchItemsId = [101, 102, 103, 104, 105, 106, 107, 108, 109, 1010, 1011, 1012, 1013, 1014, 1015, 1016, 1017]
var searchItemsTitle = ["[이즈] 린넨 밴딩 팬츠 [베이지]", "[시티브리즈] 브리즈 슬림 원피스 블랙", "[로맨틱크라운] Stripe Cardigan_Yellow", "[카인드라운지] 글로우 새틴 미디 스커트_카키", "[로맨틱크라운] GNAC Skirt Short_Purple", "[오드원아웃] 하트 참 원피스_블랙", "[바이바이섭] V-NECK PUFF SHIRTS BLUE", "[어낫띵] DROP_SHOULDER SANTA SWEAT_SHIRT", "[스컬프터] [SSS]글리터 니트 크롭 티[멀티 피치]", "[오드원아웃] 플라워 스퀘어 넥_핑크"]
var searchItemsImageFile = ["sImg/s1.png", "sImg/s2.png", "sImg/s3.png", "sImg/s4.png", "sImg/s5.png", "sImg/s6.png", "sImg/s7.png", "sImg/s8.png", "sImg/s9.png", "sImg/s10.png"]
var searchItemsPrice = ["45,000", "46,000", "32,000", "63,000", "46,000", "54,000", "68,000", "74,000", "34,000", "48,000"]
var searchItemsLink = [
    "https://wusinsa.musinsa.com/app/product/detail/1047949/0",
    "https://wusinsa.musinsa.com/app/product/detail/1045665/0",
    "https://wusinsa.musinsa.com/app/product/detail/802994/0",
    "https://wusinsa.musinsa.com/app/product/detail/1100363/0",
    "https://wusinsa.musinsa.com/app/product/detail/1008469/0",
    "https://wusinsa.musinsa.com/app/product/detail/1104137/0",
    "https://wusinsa.musinsa.com/app/product/detail/861897/0",
    "https://wusinsa.musinsa.com/app/product/detail/866473/0",
    "https://wusinsa.musinsa.com/app/product/detail/1063709/0",
    "https://wusinsa.musinsa.com/app/product/detail/1029573/0"
]

class SearchResultViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource{
    var categoryResult = ""
    var patternResult = ""
    var fabricResult = ""
    @IBOutlet var searchResultView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        searchResultView.delegate = self
        searchResultView.dataSource = self

        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(SearchResultViewController.handleLongPress))
        longPress.minimumPressDuration = 0.5
        longPress.delegate = self
        searchResultView.addGestureRecognizer(longPress)
    }
    
    /* return the number of collection cells */
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchItemsTitle.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = searchResultView.dequeueReusableCell(withReuseIdentifier: "resultCell", for: indexPath) as! CollectionViewCell
        let cellIndex = (indexPath as NSIndexPath).row
        
        cell.cellImageView.image = UIImage(named: searchItemsImageFile[cellIndex])
        cell.cellTitleLabel.text = searchItemsTitle[cellIndex]
        cell.cellPriceLabel.text = searchItemsPrice[cellIndex] + "원"

        return cell
    }
        
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cellIndex = (indexPath as NSIndexPath).row
        let urlLink = searchItemsLink[cellIndex]
        
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
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func respondToLongPressGesture(recognizer: UILongPressGestureRecognizer) {
        print("Favorite에 등록되었습니다")
    }
    
    func insertItemToFavorite(id: Int32, title: String, price: String, link: String, img: NSData) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        let favoriteEntity = NSEntityDescription.entity(forEntityName: "Favorite", in: managedContext)!
        let favoriteItem = NSManagedObject(entity: favoriteEntity, insertInto: managedContext)
        favoriteItem.setValue(id, forKeyPath: "id")
        favoriteItem.setValue(title, forKey: "title")
        favoriteItem.setValue(price, forKey: "price")
        favoriteItem.setValue(link, forKey: "link")
        favoriteItem.setValue(img, forKey: "img")
        
        do {
            managedContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
            try managedContext.insert(favoriteItem)
            try managedContext.save()
        } catch let error as NSError {
            print("error : \(error)")
        }
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

            let likeAlert = UIAlertController(title: "LIKE", message: "Favorite 에 등록되었습니다.", preferredStyle: UIAlertController.Style.alert)
            let okAction = UIAlertAction(title: "ok", style: UIAlertAction.Style.default, handler: nil)
            likeAlert.addAction(okAction)
            present(likeAlert, animated: true, completion: nil)
            
            itemsTitle.append(searchItemsTitle[cellIndex])
            itemsImageFile.append(searchItemsImageFile[cellIndex])
            itemsPrice.append(searchItemsPrice[cellIndex])
            itemsLink.append(searchItemsLink[cellIndex])
            

            let id = Int32(searchItemsId[cellIndex])
            let title = searchItemsTitle[cellIndex]
            let price = searchItemsPrice[cellIndex]
            let link = searchItemsLink[cellIndex]
            let img = UIImage(named: searchItemsImageFile[cellIndex])?.pngData() as! NSData
            
            insertItemToFavorite(id: id, title: title, price: price, link: link, img: img)
        }
    }
}

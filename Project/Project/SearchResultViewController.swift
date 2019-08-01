//
//  SearchResultViewController.swift
//  Project
//
//  Created by mac on 30/07/2019.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit

class SearchResultViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    var categoryResult = ""
    var patternResult = ""
    var fabricResult = ""
    @IBOutlet var searchResultView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        searchResultView.delegate = self
        searchResultView.dataSource = self
    }
    
    /* return the number of collection cells */
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return itemsTitle.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = searchResultView.dequeueReusableCell(withReuseIdentifier: "resultCell", for: indexPath) as! CollectionViewCell
        let cellIndex = (indexPath as NSIndexPath).row
        
        cell.cellImageView.image = UIImage(named: itemsImageFile[cellIndex])
        cell.cellTitleLabel.text = itemsTitle[cellIndex]
        cell.cellPriceLabel.text = itemsPrice[cellIndex] + "원"
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cellIndex = (indexPath as NSIndexPath).row
        let urlLink = itemsLink[cellIndex]
        
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
}


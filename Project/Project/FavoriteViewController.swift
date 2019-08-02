//
//  SecondViewController.swift
//  Project
//
//  Created by mac on 30/07/2019.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit

var itemsTitle = ["[어커버] 타탄 체크 팬츠", "[스컬프터] 레트로 레투스-엣지 탑", "[마조팩토리] 체크 머메이드 스커트", "[5252 바이 오아이오아이] 2019 SIGNATURE T-SHIRT", "[브렌다 브렌든] 테일러드 원피스-네이비", "[키르시] 스몰 체리 후디 IS[퍼플]", "[버닝] B Winow T-shirt", "[샐러드볼] 데님 오버롤 원피스", "[와이케이] 스테디 로고 반팔티셔츠 물나염 소라", "[와이케이] 오픈슬리브 체크 셔츠 소라", "[하케쉬] Simple Mini Dress_Black", "[키르시] 빅 체리 글리터 티셔츠 IH[블랙]", "[로우 투 로우] WRP022스포티 져지 파이핑 조거 팬츠(우드)", "[어널로이드] 울 체크 자켓 / 베이지", "[스컬프터] 페이즐리 드레스 위드 스크런치[네이비]", "[하케쉬] Tulip Ruffle Dress_Mint"]
var itemsImageFile = ["img/pants.jpg", "img/top.jpg", "img/1.jpg", "img/2.jpg", "img/3.jpg", "img/4.jpg", "img/5.jpg", "img/6.jpg", "img/7.png", "img/8.png", "img/9.png", "img/10.png", "img/11.png", "img/12.png", "img/13.png", "img/14.png"]
var itemsPrice = ["28,000", "28,000", "87,000","39,000", "89,000","69,000", "35,000", "108,000", "39,000", "98,000", "109,000", "42,000", "138,000", "169,000", "98,000", "129,000"]
var itemsLink = ["https://store.musinsa.com/app/product/detail/980968/0", "https://store.musinsa.com/app/product/detail/746280/0", "https://store.musinsa.com/app/product/detail/980968/0", "https://store.musinsa.com/app/product/detail/980968/0",
    "https://store.musinsa.com/app/product/detail/980968/0",
    "https://store.musinsa.com/app/product/detail/980968/0",
    "https://store.musinsa.com/app/product/detail/980968/0",
    "https://store.musinsa.com/app/product/detail/980968/0",
    "https://wusinsa.musinsa.com/app/product/detail/1058944/0",
    "https://wusinsa.musinsa.com/app/product/detail/725599/0",
    "https://wusinsa.musinsa.com/app/product/detail/1059079/0",
    "https://wusinsa.musinsa.com/app/product/detail/1018964/0",
    "https://wusinsa.musinsa.com/app/product/detail/1052108/0",
    "https://wusinsa.musinsa.com/app/product/detail/606011/0",
    "https://wusinsa.musinsa.com/app/product/detail/1021183/0",
    "https://wusinsa.musinsa.com/app/product/detail/1059811/0"]

class FavoriteViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    let CELL_HEIGHT: CGFloat = 80
    
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
        return itemsTitle.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell") as! TableViewCell
        let rowIndex = (indexPath as NSIndexPath).row
        
        cell.cellImgView.image = UIImage(named: itemsImageFile[rowIndex])
        cell.cellTitleLabel.text = itemsTitle[rowIndex]
        cell.cellPriceLabel.text = itemsPrice[rowIndex] + "원"
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
            itemsTitle.remove(at: rowIndex)
            itemsImageFile.remove(at: rowIndex)
            itemsPrice.remove(at: rowIndex)
            itemsLink.remove(at: rowIndex)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
        else if editingStyle == .insert {}
    }
    
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "삭제"
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let moveIndex = (sourceIndexPath as NSIndexPath).row
        let itemToMove = itemsTitle[moveIndex]
        let itemImageToMove = itemsImageFile[moveIndex]
        let itemPrice = itemsPrice[moveIndex]
        let itemLink = itemsLink[moveIndex]
        itemsTitle.remove(at: moveIndex)
        itemsImageFile.remove(at: moveIndex)
        itemsPrice.remove(at: moveIndex)
        itemsLink.remove(at: moveIndex)
        
        let toIndex = (destinationIndexPath as NSIndexPath).row
        itemsTitle.insert(itemToMove, at: toIndex)
        itemsImageFile.insert(itemImageToMove, at: toIndex)
        itemsPrice.insert(itemPrice, at: toIndex)
        itemsLink.insert(itemLink, at: toIndex)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let rowIndex = (indexPath as NSIndexPath).row
        let urlString = itemsLink[rowIndex]
        
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
        
        itemsTitle.remove(at: removeIndex)
        itemsImageFile.remove(at: removeIndex)
        itemsPrice.remove(at: removeIndex)
        itemsLink.remove(at: removeIndex)
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


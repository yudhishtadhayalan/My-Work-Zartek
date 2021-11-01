//
//  UserHomeVC.swift
//  MyWorkZartek
//
//  Created by Yudhishta Dhayalan on 22/10/21.
//

import UIKit
//import SDWebImage

class UserHomeVC: UIViewController {
    
    @IBOutlet weak var tblOutlet: UITableView!
    @IBOutlet weak var buttonSideMenuOutlet: UIButton!
    @IBOutlet weak var collectionViewOutlet: UICollectionView!
    @IBOutlet weak var lbl_TotalPurchase: UILabel!

    var selectedCell: Int?
    var totalPurchasedFoodCount: String?
    var modelCategoryElement: [ModelCategoryElement]!
    var categoryDishArray =  [CategoryDish]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
        sideMenuFunction()
        apiCall()
    }
    
    func initialSetup() {
        tblOutlet.delegate = self
        tblOutlet.dataSource = self
        lbl_TotalPurchase.layer.cornerRadius = lbl_TotalPurchase.frame.height/2
        lbl_TotalPurchase.clipsToBounds = true
    }
    
    func sideMenuFunction()  {
        buttonSideMenuOutlet.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
        revealViewController().rearViewRevealWidth = 275
        view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
    }
    
    func apiCall() {
        VMCategory.delegateCategory = self
        VMCategory.getCategoryDetails()
    }
    
    @IBAction func didTapCart(_ sender: UIButton) {
        SingletonObject.shared.categoryDish = categoryDishArray
        let userHomeVC = storyboard?.instantiateViewController(withIdentifier: "CheckoutVC") as! CheckoutVC        
        self.navigationController?.pushViewController(userHomeVC, animated: true)
    }
    
    
    @objc func didTapPlus(sender: UIButton) {
        var item = modelCategoryElement?.first?.tableMenuList?[selectedCell ?? 0].categoryDishes?[sender.tag]
        let plusAction = (item?.numberOfItems ?? 0) + 1
        item?.numberOfItems = plusAction
        modelCategoryElement?.first?.tableMenuList?[selectedCell ?? 0].categoryDishes?[sender.tag].numberOfItems = item?.numberOfItems
        tblOutlet.reloadData()
        
        if var selectedCategoryDish = modelCategoryElement?.first?.tableMenuList?[selectedCell ?? 0].categoryDishes?[sender.tag]  {

                if let index = categoryDishArray.firstIndex(where: {$0.dishID == selectedCategoryDish.dishID}) {
                    categoryDishArray.remove(at: index)
                categoryDishArray.append(selectedCategoryDish)
                } else {
                    categoryDishArray.append(selectedCategoryDish)
                }
        }

       let noOfItems = categoryDishArray.reduce(Int(0.0)) { $0 + ($1.numberOfItems ?? 0) }
        lbl_TotalPurchase.text = "\(noOfItems)"
        
    }
    
    @objc func didTapMinus(sender: UIButton) {
        
        var item = modelCategoryElement?.first?.tableMenuList?[selectedCell ?? 0].categoryDishes?[sender.tag]
        if item?.numberOfItems != 0 {
            let minusAction = (item?.numberOfItems ?? 0) - 1
            item?.numberOfItems = minusAction
            modelCategoryElement?.first?.tableMenuList?[selectedCell ?? 0].categoryDishes?[sender.tag].numberOfItems = item?.numberOfItems
            tblOutlet.reloadData()
            
            if var selectedCategoryDish = modelCategoryElement?.first?.tableMenuList?[selectedCell ?? 0].categoryDishes?[sender.tag]  {

                    if let index = categoryDishArray.firstIndex(where: {$0.dishID == selectedCategoryDish.dishID}) {
                        categoryDishArray.remove(at: index)
                    categoryDishArray.append(selectedCategoryDish)
                    } else {
                        categoryDishArray.append(selectedCategoryDish)
                    }
            }
        }
        let noOfItems = categoryDishArray.reduce(Int(0.0)) { $0 + ($1.numberOfItems ?? 0) }
         lbl_TotalPurchase.text = "\(noOfItems)"
        
    }
    
}

//MARK: --- Table View Datasource ---
extension UserHomeVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return modelCategoryElement?.first?.tableMenuList?[selectedCell ?? 0].categoryDishes?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tblOutlet.dequeueReusableCell(withIdentifier: "UserHomeTableCell", for: indexPath) as! UserHomeTableCell
        let item = modelCategoryElement?.first?.tableMenuList?[selectedCell ?? 0].categoryDishes?[indexPath.item]
        let imageUrl = item?.dishImage
        let imgDishImage = imageUrl?.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) ?? ""
        cell.lbl_dish_name.text = item?.dishName
        cell.lbl_dish_description.text = item?.dishDescription
//        cell.imgVw_dish_image.sd_setImage(with: URL(string: imgDishImage), placeholderImage: UIImage(named: "placeHolder"))
        if cell.imgVw_dish_image.image == nil {
            cell.imgVw_dish_image.image = #imageLiteral(resourceName: "placeHolderFood")
        }
        if item?.dishType == 1 { // 1 --> Non Vegetarian Food
            cell.imgVw_dish_Type.image = #imageLiteral(resourceName: "Non_Veg")
        } else { // 2 --> Vegetarian Food
            cell.imgVw_dish_Type.image = #imageLiteral(resourceName: "Vegetarian")
        }
        
        cell.btn_Minus.tag = indexPath.row
        cell.btn_Plus.tag = indexPath.row
        cell.btn_Minus.addTarget(self, action: #selector(didTapMinus(sender:)), for: .touchUpInside)
        cell.btn_Plus.addTarget(self, action: #selector(didTapPlus(sender:)), for: .touchUpInside)
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 220
    }
    
}

//MARK: --- Table View Delegate ---
extension UserHomeVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print("Selected")
    }
    
}

//MARK: --- Collection View Datasource ----------
extension UserHomeVC: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return modelCategoryElement?.first?.tableMenuList?.count ?? 0   //[].menuCategory?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SelectCollectionViewCell", for: indexPath) as! SelectCollectionViewCell
        let item = modelCategoryElement?.first?.tableMenuList?[indexPath.item]
        cell.labelCellOutlet.text = item?.menuCategory
        return cell
    }
    
}

//MARK: --- Collection View  Delegate ----------
extension UserHomeVC: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedCell = indexPath.item
        tblOutlet.reloadData()
    }
}


//MARK: --- API CALL ----------
extension UserHomeVC: DelegateCategory {
    
    func successCategoryObj(resObj: [ModelCategoryElement]) {
        modelCategoryElement = resObj
        tblOutlet.reloadData()
        collectionViewOutlet.reloadData()
//        print("\n\n🌼🌼🌼🌼🌼 \(resObj) 🌼🌼🌼🌼🌼\n\n")
    }
    
    func errorCategoryObj(strError: String) {
        print("Error Category API ===  \(strError) ===")
    }

}





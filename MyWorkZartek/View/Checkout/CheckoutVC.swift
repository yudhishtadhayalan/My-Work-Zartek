//
//  CheckoutVC.swift
//  MyWorkZartek
//
//  Created by Yudhishta Dhayalan on 22/10/21.
//

import UIKit

class CheckoutVC: UIViewController {
    
    @IBOutlet weak var tblOutlet: UITableView!
    @IBOutlet weak var lbl_TotalDishes: UILabel!
    @IBOutlet weak var lbl_PlaceOrder: UILabel!
    @IBOutlet weak var lbl_TotalAmount: UILabel!
    
    var modelCategoryElement: [ModelCategoryElement]!
    var categoryDishes: [CategoryDish]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
        categoryDishes = SingletonObject.shared.getCategoryDishElement()
        getTotalAmount()
    }
    
    func initialSetup() {
        tblOutlet.delegate = self
        tblOutlet.dataSource = self
        lbl_TotalDishes.layer.cornerRadius = 10.0
        lbl_TotalDishes.clipsToBounds = true
        lbl_PlaceOrder.layer.cornerRadius = 10.0
        lbl_PlaceOrder.clipsToBounds = true
    }
    
    func getTotalAmount() {
        if let totalAmount = categoryDishes?.reduce(Double(0.0)) { $0 + Double($1.numberOfItems ?? 0) * ($1.dishPrice ?? 0) } {
            lbl_TotalAmount.text = "INR \(totalAmount)"
        }
        if let noOfItems = categoryDishes?.reduce(Int(0.0)) { $0 + ($1.numberOfItems ?? 0) } {
            lbl_TotalDishes.text = "\(categoryDishes?.count ?? 0) Dishes - \(noOfItems) Items"
        }
    }
    
    @objc func didTapPlus(sender: UIButton) {
        
        let item = categoryDishes?[sender.tag].numberOfItems ?? 0
        let plusAction = item + 1
        categoryDishes?[sender.tag].numberOfItems = plusAction
        tblOutlet.reloadData()
        getTotalAmount()
    }
    
    @objc func didTapMinus(sender: UIButton) {
        
        let item = categoryDishes?[sender.tag].numberOfItems ?? 0
        if item != 0 {
            let plusAction = item - 1
            categoryDishes?[sender.tag].numberOfItems = plusAction
            tblOutlet.reloadData()
            getTotalAmount()
        }
    }
    
    @IBAction func didTapBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
        
}


extension CheckoutVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryDishes?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //Common Cell
        let cell = tblOutlet.dequeueReusableCell(withIdentifier: "CheckoutCommonTableCell", for: indexPath) as! CheckoutCommonTableCell
        
        let item_ = categoryDishes?[indexPath.item]
        
        
        if item_?.dishType == 1 { // 1 --> Non Vegetarian Food
            cell.imgVw_dish_Type.image = #imageLiteral(resourceName: "Non_Veg")
        } else { // 2 --> Vegetarian Food
            cell.imgVw_dish_Type.image = #imageLiteral(resourceName: "Vegetarian")
        }
        
        cell.lbl_dish_name.text = item_?.dishName
        cell.lbl_dish_currency_dish_price.text = "INR \(item_?.dishPrice ?? 0.0)" //"Rs 200"
        cell.btn_Minus.tag = indexPath.row
        cell.btn_Plus.tag = indexPath.row
        cell.btn_Minus.addTarget(self, action: #selector(didTapMinus(sender:)), for: .touchUpInside)
        cell.btn_Plus.addTarget(self, action: #selector(didTapPlus(sender:)), for: .touchUpInside)
        cell.lbl_dish_calories.text = "\(item_?.dishCalories ?? 0) calories"
        cell.lbl_dish_price.text = "INR \(item_?.dishPrice ?? 0.0)"
        cell.lbl_PurchasedFood.text = "\(item_?.numberOfItems ?? 0)"
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 165
    }
    
}



extension CheckoutVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Cell Selected")
    }
    
}


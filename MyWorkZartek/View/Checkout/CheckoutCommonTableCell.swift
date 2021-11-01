//
//  CheckoutCommonTableCell.swift
//  MyWorkZartek
//
//  Created by Yudhishta Dhayalan on 22/10/21.
//

import UIKit

class CheckoutCommonTableCell: UITableViewCell {
    
    @IBOutlet weak var imgVw_dish_Type: UIImageView!
    @IBOutlet weak var lbl_dish_name: UILabel!
    @IBOutlet weak var lbl_dish_currency_dish_price: UILabel!
    @IBOutlet weak var btn_Minus: UIButton!
    @IBOutlet weak var btn_Plus: UIButton!
    @IBOutlet weak var lbl_PurchasedFood: UILabel!
    @IBOutlet weak var lbl_dish_calories: UILabel!
    @IBOutlet weak var lbl_dish_price: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        btn_Minus.roundCorners(corners: [.topLeft, .bottomLeft], radius: 20.0)
        btn_Plus.roundCorners(corners: [.topRight, .bottomRight], radius: 20.0)
    }


    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

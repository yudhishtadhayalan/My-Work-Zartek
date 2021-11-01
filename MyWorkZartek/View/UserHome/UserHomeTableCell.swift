//
//  UserHomeTableCell.swift
//  MyWorkZartek
//
//  Created by Yudhishta Dhayalan on 22/10/21.
//

import UIKit

class UserHomeTableCell: UITableViewCell {
    
    @IBOutlet weak var imgVw_dish_image: UIImageView!
    @IBOutlet weak var imgVw_dish_Type: UIImageView!
    @IBOutlet weak var lbl_dish_name: UILabel!
    @IBOutlet weak var lbl_dish_currency_dish_price: UILabel!
    @IBOutlet weak var lbl_dish_description: UILabel!
    @IBOutlet weak var btn_Minus: UIButton!
    @IBOutlet weak var btn_Plus: UIButton!
    @IBOutlet weak var lbl_PurchasedFood: UILabel!
        
    override func awakeFromNib() {
        super.awakeFromNib()
        initialSetup()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        btn_Minus.roundCorners(corners: [.topLeft, .bottomLeft], radius: 20.0)
        btn_Plus.roundCorners(corners: [.topRight, .bottomRight], radius: 20.0)
    }
    
    func initialSetup() {
        imgVw_dish_image.layer.cornerRadius = 10
        imgVw_dish_image.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}


extension UIButton {
   func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
}

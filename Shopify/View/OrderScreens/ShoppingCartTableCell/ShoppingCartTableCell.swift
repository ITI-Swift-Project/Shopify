//
//  ShoppingCartTableCell.swift
//  Shopify
//
//  Created by Fatma on 09/03/2023.
//

import UIKit

class ShoppingCartTableCell: UITableViewCell {

    @IBOutlet weak var cartCellBackView: UIView!
    @IBOutlet weak var cartProductImage: UIImageView!
    @IBOutlet weak var cartProductName: UILabel!
    
    @IBOutlet weak var cartProductDescription: UILabel!
    
    @IBOutlet weak var cartProductPrice: UILabel!
    
    @IBOutlet weak var cartProductSuTotalPrice: UILabel!
    
    @IBOutlet weak var cartProductsCount: UILabel!
    @IBOutlet weak var deleteCartProduct: UIButton!
    @IBOutlet weak var increaseProductItemCount: UIButton!
    
    @IBOutlet weak var decreaseProductItemCount: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    @IBAction func minsButton(_ sender: UIButton) {
    }
    @IBAction func plusButton(_ sender: UIButton) {
    }
    @IBAction func deleteButton(_ sender: UIButton) {
    }
    
}

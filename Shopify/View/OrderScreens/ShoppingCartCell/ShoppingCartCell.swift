//
//  ShoppingCartCell.swift
//  Shopify
//
//  Created by Fatma on 24/02/2023.
//

import UIKit

class ShoppingCartCell: UICollectionViewCell {
    
    @IBOutlet weak var cartCellBackView: UIView!
    @IBOutlet weak var cartProductImage: UIImageView!
    @IBOutlet weak var cartProductName: UILabel!
    
    @IBOutlet weak var cartProductDescription: UILabel!
    
    @IBOutlet weak var cartProductPrice: UILabel!
    
    @IBOutlet weak var cartProductSuTotalPrice: UILabel!
    
    @IBOutlet weak var cartProductsCount: UILabel!
    
    @IBOutlet weak var trashFrame: UIView!
  
    @IBOutlet weak var deleteCartProduct: UIButton!
    
    @IBOutlet weak var increaseProductItemCount: UIButton!
    
    @IBOutlet weak var decreaseProductItemCount: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}

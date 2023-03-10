

//
//  WishCollectionViewCell.swift
//  Shopify
//
//  Created by Aya on 25/02/2023.
//

import UIKit

class WishCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var deleteBtn: UIButton!
    
    @IBOutlet weak var cartBtn: UIButton!
    
    @IBOutlet weak var wishImg: UIImageView!
    
    
    @IBOutlet weak var wishPrice: UILabel!
    @IBOutlet weak var wishName: UILabel!
    
    @IBOutlet weak var wishDescription: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}

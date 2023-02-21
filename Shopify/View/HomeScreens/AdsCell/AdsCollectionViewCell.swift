//
//  AdsCollectionViewCell.swift
//  Shopify
//
//  Created by Mahmoud on 21/02/2023.
//

import UIKit

class AdsCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var fLabel: UILabel!
    
    @IBOutlet weak var sLabel: UILabel!
    
    @IBOutlet weak var tLabel: UILabel!
    
    @IBOutlet weak var img: UIImageView!
   
    
    @IBOutlet weak var cart: UIButton!
    
    @IBOutlet weak var fav: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func configImg(name : String)->Void{
        img.image = UIImage(named: name)
    }

}

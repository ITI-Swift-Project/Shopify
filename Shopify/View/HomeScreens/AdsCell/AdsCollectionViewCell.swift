//
//  AdsCollectionViewCell.swift
//  Shopify
//
//  Created by Mahmoud on 21/02/2023.
//

import UIKit

class AdsCollectionViewCell: UICollectionViewCell {
   
    
    @IBOutlet weak var img: UIImageView!
   
  
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func configImg(name : String)->Void{
        img.image = UIImage(named: name)
    }

}

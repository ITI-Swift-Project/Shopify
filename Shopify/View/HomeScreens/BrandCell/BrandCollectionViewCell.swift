//
//  BrandCollectionViewCell.swift
//  Shopify
//
//  Created by Mahmoud on 22/02/2023.
//

import UIKit
import Kingfisher
class BrandCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var label: UILabel!
    
    @IBOutlet weak var img: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func configImg(name : URL)->Void{
        img.backgroundColor = UIColor.white
        img.kf.setImage(with: name,placeholder: UIImage(named :"tmp"))
    
    }
    func configLabel(label : String)->Void{
        self.label.backgroundColor = UIColor(named: "secondColor")
        self.label.text = label
        
    }
}

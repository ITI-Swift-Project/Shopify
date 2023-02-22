//
//  BrandCollectionViewCell.swift
//  Shopify
//
//  Created by Mahmoud on 22/02/2023.
//

import UIKit

class BrandCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var label: UILabel!
    
    @IBOutlet weak var img: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func configImg(name : String)->Void{
        img.backgroundColor = UIColor(named: "HomeCellBackground")
        img.image = UIImage(named: name)
    }
    func configLabel(label : String)->Void{
        self.label.backgroundColor = UIColor(named: "HomeLabelBackground")
        self.label.text = label
        
    }
}

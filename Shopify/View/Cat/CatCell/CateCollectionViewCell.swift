//
//  CatCollectionViewCell.swift
//  Shopify
//
//  Created by Mahmoud on 22/02/2023.
//

import UIKit
import Kingfisher
class CateCollectionViewCell: UICollectionViewCell {

    
    @IBOutlet weak var fLabel: UILabel!
    @IBOutlet weak var viewToSetColor: UIView!
    @IBOutlet weak var img: UIImageView!
    
    @IBOutlet weak var prouductName: UILabel!
    
    @IBOutlet weak var vendorLabel: UILabel!
    
    @IBOutlet weak var typeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        viewToSetColor.backgroundColor = UIColor(named: "HomeLabelBackground")
        // Initialization code
    }
    func configImg(name : URL)->Void
    {
        img.backgroundColor = UIColor(named: "HomeCellBackground")
        img.kf.setImage(with: name, placeholder: UIImage(named: "tmp"))
    }
    func configProductInfo(name : String,vendor : String,type : String)->Void
    {
        prouductName.text = name
        vendorLabel.text  = vendor
        typeLabel.text    = type
    }
    func confirstLabel(name : String)->Void
    {
        fLabel.text = name
    }
}

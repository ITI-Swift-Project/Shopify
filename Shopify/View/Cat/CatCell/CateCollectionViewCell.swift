//
//  CatCollectionViewCell.swift
//  Shopify
//
//  Created by Mahmoud on 22/02/2023.
//

import UIKit
import Kingfisher
class CateCollectionViewCell: UICollectionViewCell {

    
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var fLabel: UILabel!
    @IBOutlet weak var img: UIImageView!
    
    @IBOutlet weak var prouductName: UILabel!
    
    @IBOutlet weak var vendorLabel: UILabel!
    
    @IBOutlet weak var typeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func configImg(name : URL)->Void
    {
        img.backgroundColor = UIColor.white
        img.layer.masksToBounds = true
        img.layer.cornerRadius = 20
        img.kf.setImage(with: name, placeholder: UIImage(named: "notFound"))
    }
    func configProductInfo(name : String,vendor : String,price : String)->Void
    {
        prouductName.text = name
        vendorLabel.text  = vendor
        typeLabel.text    = price
    }

}

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
    func confirstLabel(name : String)->Void
    {
        fLabel.text = name
    }
}

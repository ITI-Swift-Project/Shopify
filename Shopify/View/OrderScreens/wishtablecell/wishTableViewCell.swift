//
//  wishTableViewCell.swift
//  Shopify
//
//  Created by Aya on 10/03/2023.
//

import UIKit

class wishTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var wishImg: UIImageView!
    
    @IBOutlet weak var wishName: UILabel!
    
    @IBOutlet weak var wishDiscription: UILabel!
    
    @IBOutlet weak var wishPrice: UILabel!
    
    @IBOutlet weak var wishCart: UIButton!
    
    @IBOutlet weak var wishDelete: UIButton!
    
    @IBOutlet weak var backView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

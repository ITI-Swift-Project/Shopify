//
//  WishTableViewCell.swift
//  Shopify
//
//  Created by Aya on 22/02/2023.
//

import UIKit

class WishTableViewCell: UITableViewCell {

    @IBOutlet weak var WishListName: UILabel!
    @IBOutlet weak var WishListImage: UIImageView!
    @IBOutlet weak var WishListPrice: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func CartBtn(_ sender: Any) {
    }
    
}

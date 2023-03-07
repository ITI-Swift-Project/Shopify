//
//  OrderDetailsCell.swift
//  Shopify
//
//  Created by Fatma on 06/03/2023.
//

import UIKit

class OrderDetailsCell: UITableViewCell {

    @IBOutlet weak var orderItemImage: UIImageView!
    @IBOutlet weak var orderItemProductName: UILabel!
    @IBOutlet weak var orderItemProductQuantity: UILabel!
    @IBOutlet weak var orderItemProductPrice: UILabel!
    @IBOutlet weak var orderItemTotalPrice: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

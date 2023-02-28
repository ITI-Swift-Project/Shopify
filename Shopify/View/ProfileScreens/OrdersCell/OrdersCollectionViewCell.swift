//
//  OrdersCollectionViewCell.swift
//  Shopify
//
//  Created by Mahmoud on 27/02/2023.
//

import UIKit

class OrdersCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var priceLabel: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
   
    @IBOutlet weak var timeLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}

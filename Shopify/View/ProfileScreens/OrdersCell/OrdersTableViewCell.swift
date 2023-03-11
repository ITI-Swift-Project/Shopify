//
//  OrdersTableViewCell.swift
//  Shopify
//
//  Created by Mahmoud on 11/03/2023.
//

import UIKit

class OrdersTableViewCell: UITableViewCell {

    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var timeLabe: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func conigData(price : String,date : String, time : String )
    {
        self.priceLabel.text = price
        self.dateLabel.text = date
        self.timeLabe.text = time
    }
    
}

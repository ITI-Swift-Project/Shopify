//
//  ProductReviewsCell.swift
//  Shopify
//
//  Created by Fatma on 20/03/2023.
//

import UIKit

class ProductReviewsCell: UITableViewCell {

    @IBOutlet weak var reviewerName: UILabel!
    @IBOutlet weak var reviewerImage: UIImageView!
    @IBOutlet weak var review: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

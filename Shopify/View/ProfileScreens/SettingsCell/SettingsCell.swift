//
//  SettingsCell.swift
//  Shopify
//
//  Created by Fatma on 25/02/2023.
//

import UIKit

class SettingsCell: UITableViewCell {

    
    
    
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var settingImage: UIImageView!
    @IBOutlet weak var settingTitle: UILabel!
    @IBOutlet weak var selectionIndicator: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.layer.cornerRadius = 30
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

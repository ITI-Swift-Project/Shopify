//
//  StyleHelper.swift
//  Shopify
//
//  Created by Fatma on 25/02/2023.
//

import Foundation
import UIKit

class StyleHelper
{
     static func cvCellStyle(cvCell : UICollectionViewCell)
     {
         cvCell.layer.masksToBounds = true
         cvCell.layer.cornerRadius = 30
     }
    
    static func tvCellStyle(tvCell : UITableViewCell)
    {
        tvCell.layer.masksToBounds = true
        tvCell.layer.cornerRadius = 30
    }
     static func bgFrameStyle(frame : UIView)
     {
        frame.layer.masksToBounds = true
        frame.layer.cornerRadius = 30
     }
    static func bigLablesStyle(label : UILabel)
    {
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 25
    }
    static func smallLablesStyle(label : UILabel)
    {
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 15
    }
}

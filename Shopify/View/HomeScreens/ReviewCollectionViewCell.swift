//
//  ReviewCollectionViewCell.swift
//  Shopify
//
//  Created by Aya on 01/03/2023.
//

import UIKit

class ReviewCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var reviewImg: UIImageView!
    
    @IBOutlet weak var reviewName: UILabel!
    
    @IBOutlet weak var reviewTxt: UITextView!
    
    func setReview (img: UIImage, name: String, txt: String)
    {
        reviewImg.image = img
        reviewName.text = name
        reviewTxt.text = txt
       // reviewImg.layer.cornerRadius = reviewImg.frame.size.height / 2
             // reviewImg.clipsToBounds = true
        
    }
}

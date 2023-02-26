//
//  RatingController.swift
//  Shopify
//
//  Created by Aya on 25/02/2023.
//

import UIKit

class RatingController: UIStackView {
    
    var starRating = 0
    var starEmpty = "star"
    var starFill = "starfill"
    
    override func draw(_ rect: CGRect) {
        let starButtons = self.subviews.filter{$0 is UIButton}
        var starTag = 1
        
        for button in starButtons
        {
            if let button = button as? UIButton
            {
                button.setImage(UIImage(named: starEmpty), for: .normal)
                button.addTarget(self, action: #selector(self.pressed(sender:)), for: .touchUpInside)
                starTag += 1
            }
           starsRating(rating: starRating)
        }
      
    }
    
    func starsRating(rating: Int)
    {
        self.starRating = rating
        let stackSubViews = self.subviews.filter{ $0 is UIButton}
        for subView in stackSubViews
        {
            if let button = subView as? UIButton
            {
                if button.tag > starRating
                {
                    button.setImage(UIImage(named: starEmpty), for: .normal)
                }
                else
                {
                    button.setImage(UIImage(named: starFill), for: .normal)
                }
            }
        }
    }

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    @objc func pressed(sender : UIButton)
    {
        starsRating(rating : sender.tag)
    }
}

//
//  CurrencyViewController.swift
//  Shopify
//
//  Created by Fatma on 25/02/2023.
//

import UIKit

class CurrencyViewController: UIViewController {
    
    var userdef = UserDefaults.standard
   // userdef.setValue(false, forKey: "firstTime")

    @IBOutlet weak var bgFrame: UIView!
    @IBOutlet weak var USD: UIButton!
    @IBOutlet weak var GBP: UIButton!
    
    @IBAction func selectUSD(_ sender: Any) {
        setCurrencyImage(currency : USD)
        userdef.setValue(1.0, forKey: "currency")
    }
    
    @IBAction func selectGBP(_ sender: Any) {
        setCurrencyImage(currency : GBP)
        userdef.setValue(30.0, forKey: "currency")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        StyleHelper.bgFrameStyle(frame: bgFrame)
        if userdef.value(forKey: "currency") as! Double == 1.0
        {
            USD.setImage(UIImage(systemName: "dot.circle.fill"), for: .normal)
        }
        else
        {
            GBP.setImage(UIImage(systemName: "dot.circle.fill"), for: .normal)
        }
    }
    
}
extension CurrencyViewController
{
    func setCurrencyImage(currency : UIButton)
    {
        GBP.setImage(UIImage(systemName: "dot.circle"), for: .normal)
        USD.setImage(UIImage(systemName: "dot.circle"), for: .normal)
        currency.setImage(UIImage(systemName: "dot.circle.fill"), for: .normal)
    }
}

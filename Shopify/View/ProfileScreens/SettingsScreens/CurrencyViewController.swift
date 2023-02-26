//
//  CurrencyViewController.swift
//  Shopify
//
//  Created by Fatma on 25/02/2023.
//

import UIKit

class CurrencyViewController: UIViewController {
    
    @IBOutlet weak var bgFrame: UIView!
    @IBOutlet weak var USD: UIButton!
    @IBOutlet weak var EUR: UIButton!
    @IBOutlet weak var GBP: UIButton!
    @IBOutlet weak var CHF: UIButton!
    @IBOutlet weak var CAD: UIButton!
    
    @IBAction func selectUSD(_ sender: Any) {
        USD.setImage(UIImage(systemName: "dot.circle.fill"), for: .normal)
        EUR.setImage(UIImage(systemName: "dot.circle"), for: .normal)
        GBP.setImage(UIImage(systemName: "dot.circle"), for: .normal)
        CHF.setImage(UIImage(systemName: "dot.circle"), for: .normal)
        CAD.setImage(UIImage(systemName: "dot.circle"), for: .normal)
    }
    
    @IBAction func selectEUR(_ sender: Any) {
        EUR.setImage(UIImage(systemName: "dot.circle.fill"), for: .normal)
        USD.setImage(UIImage(systemName: "dot.circle"), for: .normal)
        GBP.setImage(UIImage(systemName: "dot.circle"), for: .normal)
        CHF.setImage(UIImage(systemName: "dot.circle"), for: .normal)
        CAD.setImage(UIImage(systemName: "dot.circle"), for: .normal)

    }
    
    @IBAction func selectGBP(_ sender: Any) {
        GBP.setImage(UIImage(systemName: "dot.circle.fill"), for: .normal)
        USD.setImage(UIImage(systemName: "dot.circle"), for: .normal)
        EUR.setImage(UIImage(systemName: "dot.circle"), for: .normal)
        CHF.setImage(UIImage(systemName: "dot.circle"), for: .normal)
        CAD.setImage(UIImage(systemName: "dot.circle"), for: .normal)

    }
    
    @IBAction func selectCHF(_ sender: Any) {
        CHF.setImage(UIImage(systemName: "dot.circle.fill"), for: .normal)
        USD.setImage(UIImage(systemName: "dot.circle"), for: .normal)
        EUR.setImage(UIImage(systemName: "dot.circle"), for: .normal)
        GBP.setImage(UIImage(systemName: "dot.circle"), for: .normal)
        CAD.setImage(UIImage(systemName: "dot.circle"), for: .normal)
    }
    
    @IBAction func selectCAD(_ sender: Any) {
        CAD.setImage(UIImage(systemName: "dot.circle.fill"), for: .normal)
        USD.setImage(UIImage(systemName: "dot.circle"), for: .normal)
        EUR.setImage(UIImage(systemName: "dot.circle"), for: .normal)
        GBP.setImage(UIImage(systemName: "dot.circle"), for: .normal)
        CHF.setImage(UIImage(systemName: "dot.circle"), for: .normal)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        StyleHelper.bgFrameStyle(frame: bgFrame)
    }
}
   

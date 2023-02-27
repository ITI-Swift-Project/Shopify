//
//  PaymentViewController.swift
//  Shopify
//
//  Created by Mahmoud on 21/02/2023.
//

import UIKit

class PaymentViewController: UIViewController {

    @IBOutlet weak var bgFrame: UIView!
    @IBOutlet weak var applePay: UIButton!
    @IBOutlet weak var cashOnDelivery: UIButton!
    
    @IBAction func selectApplePay(_ sender: Any) {
        applePay.setImage(UIImage(systemName: "circle.fill"), for: .normal)
        cashOnDelivery.setImage(UIImage(systemName: "circle"), for: .normal)
}
    
    @IBAction func selectCashOnDelivery(_ sender: Any) {
        cashOnDelivery.setImage(UIImage(systemName: "circle.fill"), for: .normal)
        applePay.setImage(UIImage(systemName: "circle"), for: .normal)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        StyleHelper.bgFrameStyle(frame: bgFrame)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

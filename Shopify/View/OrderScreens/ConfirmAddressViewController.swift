//
//  ConfirmAddressViewController.swift
//  Shopify
//
//  Created by Fatma on 01/03/2023.
//

import UIKit

class ConfirmAddressViewController: UIViewController {

    @IBOutlet weak var bgFrame: UIView!
    @IBAction func confirmAddress(_ sender: Any) {
        let paymentVC = storyboard?.instantiateViewController(withIdentifier: "payment") as! PaymentViewController
        navigationController?.pushViewController(paymentVC, animated: true)
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

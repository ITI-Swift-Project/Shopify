//
//  OrderDetailsViewController.swift
//  Shopify
//
//  Created by Fatma on 27/02/2023.
//

import UIKit

class OrderDetailsViewController: UIViewController {

    @IBOutlet weak var orderSubTotalPrice: UILabel!
    @IBOutlet weak var shoppingFees: UILabel!
    @IBOutlet weak var discount: UILabel!
    @IBOutlet weak var orderTotalPrice: UILabel!
    
    @IBOutlet weak var enteringCopounCode: UITextField!
    @IBOutlet weak var bgFrame: UIView!
    
    @IBAction func placeOrder(_ sender: Any) {
        let confirmAddressVC = storyboard?.instantiateViewController(withIdentifier: "chooseAddress") as! ConfirmAddressViewController
        navigationController?.pushViewController(confirmAddressVC, animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        orderDetailsVCStyle()
        enteringCopounCode.layer.masksToBounds = true

        enteringCopounCode.layer.cornerRadius = 20
        enteringCopounCode.borderStyle = UITextField.BorderStyle(rawValue: 0)!

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
extension OrderDetailsViewController
{
    func orderDetailsVCStyle()
    {
        StyleHelper.bgFrameStyle(frame: bgFrame)
        StyleHelper.smallLablesStyle(label: orderSubTotalPrice)
        StyleHelper.smallLablesStyle(label: shoppingFees)
        StyleHelper.smallLablesStyle(label: discount)
        StyleHelper.bigLablesStyle(label: orderTotalPrice)
    }
}

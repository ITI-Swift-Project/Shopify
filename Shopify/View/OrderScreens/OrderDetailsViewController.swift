//
//  OrderDetailsViewController.swift
//  Shopify
//
//  Created by Fatma on 27/02/2023.
//

import UIKit

class OrderDetailsViewController: UIViewController {

    @IBOutlet weak var orderProductsTableView: UITableView!
    {
        didSet
        {
            orderProductsTableView.dataSource = self
            orderProductsTableView.delegate = self
            let nib = UINib(nibName: "OrderDetailsCell", bundle: nil)
            orderProductsTableView.register(nib, forCellReuseIdentifier: "orderDetailsCell")
        }
    }
    @IBOutlet weak var orderSubTotalPrice: UILabel!
    @IBOutlet weak var shoppingFees: UILabel!
    @IBOutlet weak var discount: UILabel!
    @IBOutlet weak var orderTotalPrice: UILabel!
    
    @IBOutlet weak var enteringCopounCode: UITextField!
    @IBOutlet weak var bgFrame: UIView!
    
    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
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

}
extension OrderDetailsViewController : UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 8
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "orderDetailsCell", for: indexPath) as! OrderDetailsCell
        return cell
    }
}
extension OrderDetailsViewController : UITableViewDelegate
{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
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


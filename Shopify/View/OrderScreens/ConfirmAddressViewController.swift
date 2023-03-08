//
//  ConfirmAddressViewController.swift
//  Shopify
//
//  Created by Fatma on 01/03/2023.
//

import UIKit

class ConfirmAddressViewController: UIViewController {

    
    
    var customerViewModel : CustomerViewModel?
    var customerAddressesList : [Address]?
    
    @IBOutlet weak var bgFrame: UIView!
    
    @IBOutlet weak var addressesTableView: UITableView!
    {
        didSet
        {
            addressesTableView.dataSource = self
            addressesTableView.delegate = self
            let nib = UINib(nibName: "AddressesAndPhoneCell", bundle: nil)
            addressesTableView.register(nib, forCellReuseIdentifier: "addressAndPhoneCell")
        }
    }
    
    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func confirmAddress(_ sender: Any) {
        let paymentVC = storyboard?.instantiateViewController(withIdentifier: "payment") as! PaymentViewController
        navigationController?.pushViewController(paymentVC, animated: true)
    }
    @IBAction func addNewAddress(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "ProfileStoryboard", bundle: nil)
        let addNewAddressVC = storyBoard.instantiateViewController(withIdentifier: "addNewAddress") as! AddNewAddressViewController
        navigationController?.pushViewController(addNewAddressVC, animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        StyleHelper.bgFrameStyle(frame: bgFrame)
        customerViewModel = CustomerViewModel()
        customerViewModel?.getCustomerAddresses(url: "https://48c475a06d64f3aec1289f7559115a55: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@ios-q2-new-capital-admin2-2022-2023.myshopify.com/admin/api/2023-01/customers/6818756165936.json")
        customerViewModel?.bindingCustomer = { () in
            DispatchQueue.main.async {
                self.customerAddressesList = self.customerViewModel?.customerAddressesResult ?? []
                self.addressesTableView.reloadData()
            }
        }
    }
}
extension ConfirmAddressViewController : UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return customerAddressesList?.count ?? 0
    }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "addressAndPhoneCell", for: indexPath) as! AddressesAndPhoneCell
        
        cell.customerAddressOrPhone.text = customerAddressesList?[0].address1?.appending(", ").appending(customerAddressesList?[0].city ?? "").appending(", ").appending(customerAddressesList?[0].country ?? "")
        return cell
    }
}
extension ConfirmAddressViewController : UITableViewDelegate
{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
      
            return "Your Addresses"
    }
}

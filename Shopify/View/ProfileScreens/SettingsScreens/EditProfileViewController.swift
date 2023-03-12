//
//  EditProfileViewController.swift
//  Shopify
//
//  Created by Fatma on 25/02/2023.
//

import UIKit

class EditProfileViewController: UIViewController{
    

    var customerViewModel : CustomerViewModel?
    var customerAddressesList : [Address]?
    
    @IBOutlet weak var customerAddressesTableView: UITableView!
    {
        didSet
        {
            customerAddressesTableView.dataSource = self
            customerAddressesTableView.delegate = self
            let nib = UINib(nibName: "AddressesAndPhoneCell", bundle: nil)
            customerAddressesTableView.register(nib, forCellReuseIdentifier: "addressAndPhoneCell")
        }
    }
    
    @IBOutlet weak var customerPhoneNumbersTableView: UITableView!
    {
        didSet
        {
            customerPhoneNumbersTableView.dataSource = self
            customerPhoneNumbersTableView.delegate = self
            let nib = UINib(nibName: "AddressesAndPhoneCell", bundle: nil)
            customerPhoneNumbersTableView.register(nib, forCellReuseIdentifier: "addressAndPhoneCell")
        }
    }
    
    @IBAction func addNewAddress(_ sender: Any) {
        print("AddNew")
        let ADVC = storyboard?.instantiateViewController(withIdentifier: "addNewAddress") as! AddNewAddressViewController
        self.present(ADVC, animated:true, completion:nil)
    }
    @IBOutlet weak var bgFrame: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        customerViewModel = CustomerViewModel()
        customerViewModel?.getCustomerAddresses(url: "https://48c475a06d64f3aec1289f7559115a55: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@ios-q2-new-capital-admin2-2022-2023.myshopify.com/admin/api/2023-01/customers/\(UserDefaults.standard.value(forKey: "userId") ?? 6832751411504).json")
        customerViewModel?.bindingCustomer = { () in
            DispatchQueue.main.async {
                self.customerAddressesList = self.customerViewModel?.customerAddressesResult ?? []
                self.customerAddressesTableView.reloadData()
            }
        }
        StyleHelper.bgFrameStyle(frame: bgFrame)
    }
    

}
extension EditProfileViewController : UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == customerAddressesTableView
        {
            return customerAddressesList?.count ?? 0
        }
        else
        {
            return 3
        }
    }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "addressAndPhoneCell", for: indexPath) as! AddressesAndPhoneCell
        if tableView == customerAddressesTableView
        {
            cell.customerAddressOrPhone.text = customerAddressesList?[indexPath.row].address1?.appending(", ").appending(customerAddressesList?[indexPath.row].city ?? "").appending(", ").appending(customerAddressesList?[indexPath.row].country ?? "")
            return cell
        }
        else
        {
            cell.customerAddressOrPhone.text = customerAddressesList?[indexPath.row].phone
            return cell
        }
        }
}
extension EditProfileViewController : UITableViewDelegate
{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.dequeueReusableCell(withIdentifier: "addressAndPhoneCell", for: indexPath) as! AddressesAndPhoneCell
        if  tableView == customerAddressesTableView {
            cell.backgroundColor = UIColor.brown
            let parameters : [String : Any] = [
                "customer":[
                    "default_address": [
                        "address1": "\(customerAddressesList?[indexPath.row].address1 ?? "")",
                        "city": "\(customerAddressesList?[indexPath.row].city ?? "" )",
                        "country": "\(customerAddressesList?[indexPath.row].country ?? "")",
                    ]
                ]
            ]
            print(parameters)
            let url = "\(NetworkService.base_url)customers/\(UserDefaults.standard.value(forKey: "userId") ?? 6832751411504).json"
            print(url)
            NetworkService.updateDate(parameter: parameters, urlEndPoint: url)
            customerAddressesTableView.deselectRow(at: indexPath, animated: true)
            let selectedBackgroundView = UIView()
              selectedBackgroundView.backgroundColor = UIColor.yellow
              cell.contentView.addSubview(selectedBackgroundView)
              selectedBackgroundView.frame = cell.contentView.bounds
              tableView.deselectRow(at: indexPath, animated: true)
            
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if tableView == customerAddressesTableView
        {
            return "Your Addresses"
        }
        else
        {
            return "Your PhoneNumbers"
        }
    }
}

//
//  AddNewAddressViewController.swift
//  Shopify
//
//  Created by Fatma on 08/03/2023.
//

import UIKit
import Alamofire

class AddNewAddressViewController: UIViewController {
    
    @IBOutlet weak var country: UITextField!
    @IBOutlet weak var city: UITextField!
    @IBOutlet weak var street: UITextField!
    @IBOutlet weak var phone : UITextField!

    var addressViewModel : AddressViewModel!
    var address : Address?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addressViewModel =  AddressViewModel()
        address = nil
        country.borderStyle = UITextField.BorderStyle(rawValue: 0)!

    }


    @IBAction func submit(_ sender: Any) {
        
        if country.text != "" && city.text != "" && street.text != "" && phone.text != ""{
            if address == nil {
                let alerts: UIAlertController = UIAlertController(title: "Add Address?", message: "Are you sure that you want to add this address!", preferredStyle: .alert)
                alerts.addAction(UIAlertAction(title: "Cancel", style: .cancel))
                alerts.addAction(UIAlertAction(title: "Add", style: .default, handler: { _ in
                    let stringUrl = "\(NetworkService.base_url)customers/\(UserDefaults.standard.value(forKey: "userId") ?? 0)/addresses.json"
                    print("Address : \(stringUrl)")
                    self.addressViewModel.postAddress(url: stringUrl, parameters:  ["address": ["city": "\(self.city.text ?? "No City")",  "country": "\(self.country.text ?? "No Country")","phone": self.phone.text ?? 0, "address1": "\(self.street.text ?? "No Address")","default": false]])
                    self.addressViewModel?.bindingAddressError = {
                        DispatchQueue.main.async {
                            print((self.addressViewModel?.addressError?.keys.formatted())!)
                            if (self.addressViewModel?.addressError?.keys.formatted())! == "customer_address⁩" {
                                let alert = UIAlertController(title: "Success", message: "Address Post Successfully", preferredStyle: UIAlertController.Style.alert)
                                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { action in
                                    self.navigationController?.popViewController(animated: true)
                                }))
                                self.present(alert, animated: true, completion: nil)
                            } else if  (self.addressViewModel?.addressError?.keys.formatted())!  == "errors" {
                                var errorMessages = ""
                                if let errors = self.addressViewModel?.addressError?["errors"] as? [String: Any] {
                                    for (field, messages) in errors {
                                        errorMessages += "\(field.capitalized): "
                                        if let messages = messages as? [String] {
                                            for message in messages {
                                                errorMessages += " \(message)\n"
                                            }
                                        }
                                    }
                                }
                                let alert = UIAlertController(title: "ERROR", message: "INVALID DATA", preferredStyle: UIAlertController.Style.alert)
                                alert.addAction(UIAlertAction(title: "Cancle", style: UIAlertAction.Style.default, handler: { action in
                                }))
                                self.present(alert, animated: true, completion: nil)
                            } else {
                                print((self.addressViewModel?.addressError?.keys.formatted())!)
                            }
                        }
                    }
                }))
            self.present(alerts, animated: true, completion: nil)
            } else {
                let alerts: UIAlertController = UIAlertController(title: "Add Address?", message: "Are you sure that you want to add this address!", preferredStyle: .alert)
                alerts.addAction(UIAlertAction(title: "Cancel", style: .cancel))
                alerts.addAction(UIAlertAction(title: "Add", style: .default, handler: { _ in
                    let url = "\(NetworkService.base_url)customers/\(UserDefaults.standard.value(forKey: "userId") ?? 0)/addresses.json"
                    print("Address : \(url)")
                    self.addressViewModel.editAddress(url: url, parameters: ["address": ["city": "\(self.city.text ?? "No City")",  "country": "\(self.country.text ?? "No Country")","phone": self.phone.text ?? 0, "address1": "\(self.street.text ?? "No Address")","default": false]])

                    self.addressViewModel?.bindingAddressError = {
                        DispatchQueue.main.async {
                            switch self.addressViewModel?.addressError?.keys.formatted() {
                            case "customer_address" :
                                let alert = UIAlertController(title: "Success", message: "Address Post Successfully", preferredStyle: UIAlertController.Style.alert)
                                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { action in
                                    self.navigationController?.popViewController(animated: true)
                                }))
                                self.present(alert, animated: true, completion: nil)
                            case "errors" :
                                var errorMessages = ""
                                if let errors = self.addressViewModel?.addressError?["errors"] as? [String: Any] {
                                    for (field, messages) in errors {
                                        errorMessages += "\(field.capitalized): "
                                        if let messages = messages as? [String] {
                                            for message in messages {
                                                errorMessages += " \(message)\n"
                                            }
                                        }
                                    }
                                }
                                let alert = UIAlertController(title: "ERROR", message: "INVALID DATA", preferredStyle: UIAlertController.Style.alert)
                                alert.addAction(UIAlertAction(title: "Cancle", style: UIAlertAction.Style.default, handler: { action in
                                }))
                                self.present(alert, animated: true, completion: nil)
                            default :
                                break
                            }
                        }
                    }
                }))
                self.present(alerts, animated: true, completion: nil)
            }
        } else {
            let alert = UIAlertController(title: "ERROR", message: "Missing Data", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { action in
            }))
            self.present(alert, animated: true, completion: nil)
        }
    }
}
    


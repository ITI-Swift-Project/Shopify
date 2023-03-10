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
    
    var NetworkVM : NetworkViewModel!
    
    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        NetworkVM =  NetworkViewModel()
    }
    
    @IBAction func submit(_ sender: Any) {
        
        let url = "\(NetworkService.base_url)customers/\(UserDefaults.standard.value(forKey: "userId") ?? "")/addresses.json"
        print("Address url is:\(url)")
        guard let newURL = URL(string: url)
        else{
            return
        }
       
        let addressData: [String: Any] = [
            "address": [
                "city": "\(country.text ?? "")",
                "country": "\(country.text ?? "")",
                "phone": 01003454355,
                "address1": "\(street.text ?? "")",
                "default": false,
            ]
        ]
        
        NetworkService.postData( urlEndPoint: newURL,parameter: addressData){_ in
            
        }

        }
   
    }
    


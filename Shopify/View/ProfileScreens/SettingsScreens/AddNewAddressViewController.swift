//
//  AddNewAddressViewController.swift
//  Shopify
//
//  Created by Fatma on 08/03/2023.
//

import UIKit

class AddNewAddressViewController: UIViewController {
    
    @IBOutlet weak var country: UITextField!
    
    @IBOutlet weak var city: UITextField!
    
    @IBOutlet weak var street: UITextField!
    
    @IBAction func submit(_ sender: Any) {
        let shopifyAddressEndpoint = "https://48c475a06d64f3aec1289f7559115a55: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@ios-q2-new-capital-admin2-2022-2023.myshopify.com/admin/api/2023-01/customers/6818756165936/addresses.json"
                let newAddressData: [String: Any] = ["address": [
                    "city": city.text ?? "",
                    "country": "fatoma",
                    "phone": 01003454355,
                    "address1": street.text ?? "",
                    "default": false,
                ],
                ]
                guard let addressEndpointUrl = URL(string: shopifyAddressEndpoint) else {
                    return
                }
                let jsonEncoder = JSONEncoder()
        //        guard let jsonData = try? jsonEncoder.encode(newAddressData) else {
        //            return
        //        }
                var addressRequest = URLRequest(url: addressEndpointUrl)
                addressRequest.httpShouldHandleCookies = false
                addressRequest.httpMethod = "POST"
                addressRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
                addressRequest.addValue("application/json", forHTTPHeaderField: "Accept")
                do {
                    addressRequest.httpBody = try JSONSerialization.data(withJSONObject: newAddressData , options: .prettyPrinted)
                    
                } catch let error {
                    print(error.localizedDescription)
                }
                let session = URLSession.shared
                let task = session.dataTask(with: addressRequest) { (data, response, error) in
                    // Handle the response from the Shopify API
                    if let error = error {
                        print("Error: \(error.localizedDescription)")
                    }
                    if let response = response as? HTTPURLResponse {
                        print("Response status code: \(response.statusCode)")
                    }
                    if let data = data {
                        // Parse the JSON response from the Shopify API if necessary
                    }
                }
                task.resume()
                
            }
    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    

}

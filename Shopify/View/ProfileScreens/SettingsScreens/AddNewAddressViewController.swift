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
        guard let url = URL(string: "https://48c475a06d64f3aec1289f7559115a55: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@ios-q2-new-capital-admin2-2022-2023.myshopify.com/admin/api/2023-01/customers/6818756165936/addresses.json") else{
                return
            }
            var request = URLRequest(url :url)
            request.httpMethod = "POST"
            
            request.httpShouldHandleCookies = false
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            let body : [String : Any] = [
                "address": [
                    "city": "zaineb",
                    "country": "salma",
                    "phone": "55555555",
                    "address1": "fatma",
                    "default": false,
                ],
                
            ]
            request.httpBody = try? JSONSerialization.data(withJSONObject: body,options: .fragmentsAllowed)
            
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                guard let data = data else{
                    return
                }
                do{
                    print("success\(response)")
                }
                catch{
                }
            }
            task.resume()
    }
    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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

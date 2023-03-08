//
//  CurrencyViewController.swift
//  Shopify
//
//  Created by Fatma on 25/02/2023.
//

import UIKit

class CurrencyViewController: UIViewController {
    
    @IBOutlet weak var bgFrame: UIView!
    @IBOutlet weak var USD: UIButton!
    @IBOutlet weak var EUR: UIButton!
    @IBOutlet weak var GBP: UIButton!
    
    @IBAction func selectUSD(_ sender: Any) {
        setCurrencyImage(currency : USD)
        
    }
    
    @IBAction func selectEUR(_ sender: Any) {
        setCurrencyImage(currency : EUR)
    }
    
    @IBAction func selectGBP(_ sender: Any) {
        setCurrencyImage(currency : GBP)
      putCurrency(currency: "f")
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        StyleHelper.bgFrameStyle(frame: bgFrame)
    }
    
}
extension CurrencyViewController
{
    func setCurrencyImage(currency : UIButton)
    {
        GBP.setImage(UIImage(systemName: "dot.circle"), for: .normal)
        USD.setImage(UIImage(systemName: "dot.circle"), for: .normal)
        EUR.setImage(UIImage(systemName: "dot.circle"), for: .normal)
        currency.setImage(UIImage(systemName: "dot.circle.fill"), for: .normal)
    }
    func putCurrency(currency : String){
        guard let url = URL(string: "https://48c475a06d64f3aec1289f7559115a55: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@ios-q2-new-capital-admin2-2022-2023.myshopify.com/admin/api/2023-01/customers/6818756165936.json") else{
                return
            }
            var request = URLRequest(url :url)
            request.httpMethod = "PUT"
            
            request.httpShouldHandleCookies = false
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            let body : [String : Any] = [
                "customer": [
                    "id" : 6818756165936,
                    "currency": "Fatma"
                        
                ]
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
 
}

//
//  PaymentViewController.swift
//  Shopify
//
//  Created by Mahmoud on 21/02/2023.
//

import UIKit
import Braintree


class PaymentViewController: UIViewController {

    @IBOutlet weak var bgFrame: UIView!
    @IBOutlet weak var applePay: UIButton!
    @IBOutlet weak var cashOnDelivery: UIButton!
    var currencyType : String = ""
    var selectedMethod : String?
    var totalAmount : Float?
    var braintreeClient: BTAPIClient?
    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func selectApplePay(_ sender: Any) {
        applePay.setImage(UIImage(systemName: "circle.fill"), for: .normal)
        cashOnDelivery.setImage(UIImage(systemName: "circle"), for: .normal)
        selectedMethod = "paypal"
}
    
    @IBAction func selectCashOnDelivery(_ sender: Any) {
        cashOnDelivery.setImage(UIImage(systemName: "circle.fill"), for: .normal)
        applePay.setImage(UIImage(systemName: "circle"), for: .normal)
        selectedMethod = "cash"
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        totalAmount = (totalAmount ?? 0) + 30.0
        self.braintreeClient = BTAPIClient(authorization: "sandbox_ndwyq572_czqszfjbwjdnvj3h")!
        StyleHelper.bgFrameStyle(frame: bgFrame)
    }
    
    @IBAction func paymentAction(_ sender: Any) {
        
        switch selectedMethod {
        case "paypal":
            
            if( UserDefaults.standard.value(forKey: "currency") as! Float == 30.0){
                currencyType = "EGP"
                totalAmount = (totalAmount ?? 0) / 30
            }
            else if( UserDefaults.standard.value(forKey: "currency")as! Float == 1.0)
            {
                currencyType = "USD"
                
            }
           payUsingPaypal()
        case "cash":
            print("when delevier")
            if(totalAmount ?? 0 >= 2000.0 && UserDefaults.standard.value(forKey: "currency") as! Float == 30.0){
                makeAlertWith(title: "exceed the maximum range", message: "please edit order")
            }
            else if(totalAmount ?? 0 >= 2000.0 && UserDefaults.standard.value(forKey: "currency")as! Float == 1.0)
            {
                makeAlertWith(title: "exceed the maximum range", message: "please edit order")
            }
            else
            {
                postOrder()
            }
        default:
            let alert = UIAlertController(title: "Missing data", message: "check payment method please", preferredStyle: .alert)
            let ok = UIAlertAction(title: "ok", style: .default)
            alert.addAction(ok)
            self.present(alert, animated: true)
        }
    }
    func makeAlertWith(title : String,message : String)
    {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okAction)
        present(alert, animated: true)
    }
    func payUsingPaypal(){
        let payPalDriver = BTPayPalDriver(apiClient: braintreeClient!)
                payPalDriver.viewControllerPresentingDelegate = self
                payPalDriver.appSwitchDelegate = self
                
                // Specify the transaction amount here. "2.32" is used in this example.
        
        let request = BTPayPalRequest(amount: "\(totalAmount ?? 0.5)")
                request.currencyCode = "USD"
            // Optional; see BTPayPalRequest.h for more options

                payPalDriver.requestOneTimePayment(request) { (tokenizedPayPalAccount, error) in
                    if let tokenizedPayPalAccount = tokenizedPayPalAccount {
                        print("Got a nonce: \(tokenizedPayPalAccount.nonce)")
                        self.postOrder()
                        // Access additional information
                        let email = tokenizedPayPalAccount.email
                        let firstName = tokenizedPayPalAccount.firstName
                        let lastName = tokenizedPayPalAccount.lastName
                        let phone = tokenizedPayPalAccount.phone

                        // See BTPostalAddress.h for details
                        let billingAddress = tokenizedPayPalAccount.billingAddress
                        let shippingAddress = tokenizedPayPalAccount.shippingAddress
                    } else if let error = error {
                        print(error)
                        // Handle error here...
                    } else {
                        // Buyer canceled payment approval
                    }
                }
    }
    func postOrder(){
        let orderEndPoint = APIEndpoint.orders
        let url = orderEndPoint.url(forShopName: NetworkService.baseUrl)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let currentDate = dateFormatter.string(from: Date())
        print(orderEndPoint)
        let orderData: [String: Any] = [
           "order": [
            "confirmed" : true,
            "contact_email" : "@test",
            "email" : "\(UserDefaults.standard.value(forKey: "email") ?? "" as? String)",
            "currency" : currencyType,
            "created_at" : currentDate,
            "number" : 2,
            "order_status_url" : "",
            "current_subtotal_price" : "\(totalAmount)",
            "current_total_price" : "0.2",
            
            
            "line_items": [
                   [
                       "fullfillabel_quantity" : 9,
                       "name" : "egypt",
                       "price" : "0.3",
                       "quantity" : 3,
                       "sku" : "testValue",
                       "title" : "shooes"
                        
                        
                   ]
               ]
           ]
        ]
        
        let jsonEncoder = JSONEncoder()
//        guard let jsonData = try? jsonEncoder.encode(newAddressData) else {
//            return
//        }
        print(url)
        var addressRequest = URLRequest(url: url)
        addressRequest.httpShouldHandleCookies = false
        addressRequest.httpMethod = "POST"
        addressRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        addressRequest.addValue("application/json", forHTTPHeaderField: "Accept")
        do {
            
            addressRequest.httpBody = try JSONSerialization.data(withJSONObject: orderData , options: .prettyPrinted)
            
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
            if data != nil {
                // Parse the JSON response from the Shopify API if necessary
            }
        }
        task.resume()
        
    }
}


extension PaymentViewController : BTViewControllerPresentingDelegate{
    func paymentDriver(_ driver: Any, requestsPresentationOf viewController: UIViewController) {
     
    }

    func paymentDriver(_ driver: Any, requestsDismissalOf viewController: UIViewController) {
      
    }
}
extension PaymentViewController : BTAppSwitchDelegate{
    func appSwitcherWillPerformAppSwitch(_ appSwitcher: Any) {
            

    }
    
    func appSwitcher(_ appSwitcher: Any, didPerformSwitchTo target: BTAppSwitchTarget) {
        
    }
    
    func appSwitcherWillProcessPaymentInfo(_ appSwitcher: Any) {
        
    }
    
    
}

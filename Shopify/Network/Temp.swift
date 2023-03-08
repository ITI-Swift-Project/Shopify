//
//  Temp.swift
//  Shopify
//
//  Created by Fatma on 07/03/2023.
//

import Foundation
import Alamofire

protocol CustomerAddressesData
{
    static func getCustomerAddresses(url: String, handeler: @escaping (Customer?) -> Void)
}

class Temp
{
    static func getCustomerAddresses(url: String, handeler: @escaping (Customer?) -> Void)
    {
        let request = AF.request(url)
        request.responseDecodable (of: Customer.self) {(olddata) in
            guard let data = olddata.value
            else{
                handeler(nil)
                return
            }
            handeler(data)
        }
    }
}
class CustomerViewModel
{
    var bindingCustomer : (() -> ()) = {}
    var customerAddressesResult : [Address]!    {
        didSet {
            bindingCustomer()
        }
    }
    
    func getCustomerAddresses(url : String) {
        Temp.getCustomerAddresses(url:  url) { result in
                if let result = result {
                    self.customerAddressesResult = result.customer?.addresses
                    print("fatma\(self.customerAddressesResult.count)")
                }
            }
        }
}

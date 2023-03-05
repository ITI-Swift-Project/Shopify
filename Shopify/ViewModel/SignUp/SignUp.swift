//
//  SignUp.swift
//  Shopify
//
//  Created by Aya on 05/03/2023.
//

import Foundation
class SignupVM
{
    func postCustomer (url : String,  data : [String : Any])
    {
        NetworkService.makePostRequest(url: url, newData: data)
    }
}

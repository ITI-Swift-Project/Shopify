//
//  Customers.swift
//  Shopify
//
//  Created by Aya on 04/03/2023.
//

import Foundation
struct allCustomers : Codable
{
    var id : Int
    var email : String?
    var first_name : String?
    var last_name : String?
    var  tags : String?
    var addresses : [Address]?
}
struct Customers : Codable
{
    let customers : [allCustomers]?
}
struct Customer : Codable , Equatable
{
    static func == (lhs: Customer, rhs: Customer) -> Bool {
        return lhs.customer?.id == rhs.customer?.id
    }
    
    var customer : allCustomers?
}



/*
func saveUserLocally(_ user : customers)
{
    let encoder  = JSONEncoder()
    do{
        let data = try encoder.encode(user)
        UserDefaults.standard.set(data, forKey: "currentUser")
        
    }catch{
        print(error.localizedDescription)
    }
}
*/

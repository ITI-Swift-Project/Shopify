//
//  Customers.swift
//  Shopify
//
//  Created by Aya on 04/03/2023.
//

import Foundation
struct Customer : Codable
{
        let email : String?
        let first_name : String?
       let  tags : String?
     //  let addresses : [[String : String]]
}
struct customers : Codable
{
    let customers : [Customer]?
}

//
//  Orders.swift
//  Shopify
//
//  Created by Mahmoud on 06/03/2023.
//

import Foundation
struct Orders : Codable{
    var orders : [Order]?
}
struct Order : Codable{
    var id : Int
    var contact_email :String?
    var currency : String?
    var created_at : String?
    var current_subtotal_price : String?
    var current_total_discounts : String?
    var current_total_price : String?
    var current_total_tax : String?
    var total_discounts : String?
    var total_tax : String?
    var billing_address : BillingAdddress?
    var customer : allCustomers?
    var line_items : [Product]?
}
struct BillingAdddress : Codable{
    var first_name : String?
    var address1 : String?
    var phone : String?
    var zip : String?
    var country : String?
    var last_namr :String?
}

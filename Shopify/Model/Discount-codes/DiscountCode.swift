//
//  DiscountCode.swift
//  Shopify
//
//  Created by Fatma on 28/02/2023.
//

import Foundation

class DiscountCode : Decodable
{
    var id : Int?
    var price_rule_id : Int?
    var code : String?
    var usage_count : Int?
    var created_at : String?
    var updated_at : String?
}

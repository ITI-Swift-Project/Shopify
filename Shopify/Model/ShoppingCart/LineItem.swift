//
//  LineItem.swift
//  Shopify
//
//  Created by Fatma on 05/03/2023.
//

import Foundation

class LineItem : Decodable
{
    var id : Int?
    var title : String?
    var requires_shipping : Bool?
    var taxable : Bool?
    var gift_card : Bool?
    var fulfillment_service : String?
    var price : String?
    var quantity : Int?
    var variant_title : String?
    var sku : String?
    var vendor : String?
    var variant_id : String?
    
}

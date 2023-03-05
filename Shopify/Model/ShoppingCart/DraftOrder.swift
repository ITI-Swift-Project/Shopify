//
//  DraftOrder.swift
//  Shopify
//
//  Created by Fatma on 05/03/2023.
//

import Foundation

class DraftOrder : Decodable
{
    var id : Int?
    var email : String?
    var taxes_included : Bool?
    var currency : String?
    var created_at : String?
    var updated_at : String?
    var status : String?
    var line_items : [LineItem]?
    var customer : Customer?
}

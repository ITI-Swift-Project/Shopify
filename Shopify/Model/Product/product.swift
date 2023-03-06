//
//  product.swift
//  Shopify
//
//  Created by Mahmoud on 26/02/2023.
//

import Foundation
struct Product : Codable {
    var id : Int?
    var title : String?
    var vendor : String?
    var product_type : String?
//    var sort_order : String?
   // var handle : String?
    var variants : [Variants]?
    var images : [Image]?
    var image : Image?
    var options: [Options]?
    var product_id : Int?
    var body_html : String?
}
struct Options : Codable
{
    var position : Int?
    var values : [String]?
}

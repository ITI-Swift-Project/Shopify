//
//  Brands.swift
//  Shopify
//
//  Created by Mahmoud on 25/02/2023.
//

import Foundation
struct Brands : Codable{
    var smart_collections : [Brand]?
}
struct Brand : Codable{
    var id : Int?
    var handle : String?
    var title : String?
    var image : Image?
}
struct Image : Codable{
    var src : String?
}

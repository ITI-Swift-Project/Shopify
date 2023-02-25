//
//  BrandsProtocol.swift
//  Shopify
//
//  Created by Mahmoud on 25/02/2023.
//

import Foundation
protocol BrandsData {
    var bindingBrands : (()->()){get set}
    var brandData : [Brand] {get set}
    static func getAllBrands(url :String,completion : @escaping ()->Void)
}

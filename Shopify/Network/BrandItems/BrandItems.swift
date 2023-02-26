//
//  BrandItems.swift
//  Shopify
//
//  Created by Mahmoud on 26/02/2023.
//

import Foundation
protocol BrandItemsData {
//    static var bindingBrands : (()->()){get set}
//    static var brandData : [Brand] {get set}
    static func getAllBrandItems(url :URL,brandId : Int,completion : @escaping (Products?)->Void)
}

//
//  BrandsProtocol.swift
//  Shopify
//
//  Created by Mahmoud on 25/02/2023.
//

import Foundation
protocol BrandsData {
    //    static var bindingBrands : (()->()){get set}
    //    static var brandData : [Brand] {get set}
    //static func getAllBrands(url :URL,completion : @escaping (Brands?)->Void)
    //MARK: Generic Method To Fetch Data
    static func fetch<T : Decodable>(url : URL?,compiletionHandler : @escaping(T?) -> Void)
}

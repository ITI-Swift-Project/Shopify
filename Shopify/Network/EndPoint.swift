//
//  EndPoint.swift
//  Shopify
//
//  Created by Mahmoud on 25/02/2023.
//

import Foundation

enum APIEndpoint {
    case products
    case orders
    case brands
    case brandItems
    
    var path: String {
        switch self {
        case .products:
            return "/admin/api/2023-01/products.json"
        case .orders:
            return "/admin/api/2023-01/orders.json"
        case .brands:
            return "/admin/api/2023-01/smart_collections.json"
        case .brandItems:
            return "/admin/products.json?collection_id="
        }
    }
    func urlForBrandItems(forShopName shopName: String,brandId : Int) -> URL {
           let urlString = "https://\(shopName).myshopify.com\(self.path)\(brandId)"
           return URL(string: urlString)!
       }
    func url(forShopName shopName: String) -> URL {
           let urlString = "https://\(shopName).myshopify.com\(self.path)"
           return URL(string: urlString)!
       }
}

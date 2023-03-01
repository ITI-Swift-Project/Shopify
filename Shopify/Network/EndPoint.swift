//
//  EndPoint.swift
//  Shopify
//
//  Created by Mahmoud on 25/02/2023.
//

import Foundation
// /admin/api/2032-01/custom_collections.json --> this retreive all cat such as(MEN,WOMEN,....etc)
// homePageId  --> 437625225520
// MenPageId   --> 437626929456
// KidsPageId  --> 437626994992
// WomenPageId --> 437626962224
// SalePageId  --> 437627027760
// /admin/api/2023-01/smart_collections.json  --> this retreive all brands
enum APIEndpoint {
    case products
    case orders
    case brands
    case brandItems
    case men
    case wowen
    case kids
    case sale
    case home
    case discountCodes
//    case accessories
//    case T_shirt
//    case shoes
    case filteration
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
        case .men:
            return "/admin/products.json?collection_id=437626929456"
        case .wowen:
            return "/admin/products.json?collection_id=437626962224"
        case .kids:
            return "/admin/products.json?collection_id=437626994992"
        case .sale:
            return "/admin/products.json?collection_id=437627027760"
        case .home:
            return "/admin/products.json?collection_id=437625225520"
        case .discountCodes:
            return "/admin/api/2023-01/price_rules/1382520553776/discount_codes.json"
        case .filteration:
          return  "/admin/api/2023-01/products.json?collection_id="
            
        }
    }
    func urlTofiltrtionCategory(forShopName shopName: String,product_type : String) -> URL {
        let urlString = "https://\(shopName).myshopify.com\(self.path)&product_type=\(product_type)"
        return URL(string:urlString)!
    }
    func urlTofiltrtion(forShopName shopName: String,product_type : String) -> URL {
        
            let urlString = "https://\(shopName).myshopify.com\(self.path)?product_type=\(product_type)"
        
        return URL(string: urlString)!
    }
    func urlWithId(forShopName shopName: String,brandId : Int) -> URL {
        
        let urlString = "https://\(shopName).myshopify.com\(self.path)\(brandId)"
           return URL(string: urlString)!
       }
    func url(forShopName shopName: String) -> URL {
           let urlString = "https://\(shopName).myshopify.com\(self.path)"
           return URL(string: urlString)!
       }
}

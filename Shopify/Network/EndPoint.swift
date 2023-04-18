//
//  EndPoint.swift
//  Shopify
//
//  Created by Mahmoud on 25/02/2023.
//

import Foundation
// /admin/api/2032-01/custom_collections.json --> this retreive all cat such as(MEN,WOMEN,....etc)
// homePageId  --> 436748681494
// MenPageId   --> 436751270166
// KidsPageId  --> 436751368470
// WomenPageId --> 436751335702
// SalePageId  --> 436751401238
// /admin/api/2023-01/smart_collections.json  --> this retreive all brands
enum APIEndpoint {
    case customers
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
    case customer
    case customerSearch
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
            return "/admin/products.json?collection_id=436751270166"
        case .wowen:
            return "/admin/products.json?collection_id=436751335702"
        case .kids:
            return "/admin/products.json?collection_id=436751368470"
        case .sale:
            return "/admin/products.json?collection_id=436751401238"
        case .home:
            return "/admin/products.json?collection_id=436748681494"
        case .discountCodes:
            return "/admin/api/2023-01/price_rules/1382520553776/discount_codes.json"
        case .filteration:
          return  "/admin/api/2023-01/products.json?collection_id="
        case.customer:
            return "/admin/api/2023-01/customers.json"
        case.customerSearch:
            return "/admin/api/2023-01/customers/search.json"
        case .customers :
            return "https://29f36923749f191f42aa83c96e5786c5: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@ios-q2-new-capital-admin-2022-2023.myshopify.com/admin/api/2023-01/customers.json"
        }
    }
    func urlToAddAddress(forShopName shopName:String,customerId : String) ->URL
    {
        ///admin/api/2023-01/customers/6818756165936/addresses.json
        let urlString = "https://\(shopName).myshopify.com/admin/api/2023-01/customers/\(customerId)/addresses.json"
        return URL(string: urlString)!
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


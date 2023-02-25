//
//  HomeViewModel.swift
//  Shopify
//
//  Created by Mahmoud on 25/02/2023.
//

import Foundation
class HomeViewModel{
    
    var bindingBrands : (()->()) = {}
    var brandsResult : [Brand] = [] {
        didSet{
            bindingBrands()
        }
    }
    func getBrands() {
        let brandEndPoint = APIEndpoint.brands
        let barndUrl = brandEndPoint.url(forShopName: "48c475a06d64f3aec1289f7559115a55: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@ios-q2-new-capital-admin2-2022-2023")
        NetworkService.getAllBrands(url: barndUrl) { result in
            if let result = result {
                self.brandsResult = result.smart_collections ?? []
            }
        }
    }
}


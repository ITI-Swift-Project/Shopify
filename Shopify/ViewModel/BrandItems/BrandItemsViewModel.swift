//
//  BrandItemsViewModel.swift
//  Shopify
//
//  Created by Mahmoud on 26/02/2023.
//

import Foundation
class BrandItemsViewModel{
    var brandId : Int?
    var bindingBrandItems : (()->()) = {}
    var brandItemsResult : [Product] = [] {
        didSet{
            bindingBrandItems()
        }
    }
    func getItems() {
        let brandEndPoint = APIEndpoint.brandItems
        let barndUrl = brandEndPoint.urlForBrandItems(forShopName: "48c475a06d64f3aec1289f7559115a55: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@ios-q2-new-capital-admin2-2022-2023", brandId: brandId!)
        NetworkService.getAllBrandItems(url: barndUrl,brandId: brandId!) { result in
            if let result = result {
                self.brandItemsResult = result.products ?? []
            }
        }
    }
}

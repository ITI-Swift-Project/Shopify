//
//  HomeViewModel.swift
//  Shopify
//
//  Created by Mahmoud on 25/02/2023.
//

import Foundation
class NetworkViewModel{
    
    var bindingBrands : (()->()) = {}
    var brandsResult : Brands!{
        didSet{
            bindingBrands()
        }
    }
    
    var bindingProducts: (() -> ()) = {}
    var productsResult: Products!{
        didSet{
            bindingProducts()
        }
    }
    
    var bindingAds : (() -> ()) = {}
    var adsResult : DiscountCodes!    {
        didSet {
            bindingAds()
        }
    }
    
    var bindingCartProducts : (() -> ()) = {}
    var ShoppingCartProductsResult: [DraftOrder] = []{
        didSet{
            bindingCartProducts()
        }
    }
    var bindingBrandItems : (()->()) = {}
    var brandItemsResult : Products!{
        didSet{
            bindingBrandItems()
        }
    }
    
    var bindingOrdersItems : (()->()) = {}
    var ordersResult : Orders!{
        didSet{
            bindingOrdersItems()
        }
    }
    
    func getItems(brandId : Int?) {
        let brandEndPoint = APIEndpoint.brandItems
        let barndUrl = brandEndPoint.urlWithId(forShopName: "48c475a06d64f3aec1289f7559115a55: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@ios-q2-new-capital-admin2-2022-2023", brandId: brandId!)
        NetworkService.fetch(url: barndUrl) { result in
                self.brandItemsResult = result
        }
    }
    
    func getBrands() {
        let brandEndPoint = APIEndpoint.brands
        let barndUrl = brandEndPoint.url(forShopName: NetworkService.baseUrl)
            NetworkService.fetch(url: barndUrl) { result in
                self.brandsResult = result
            }
        }
    func getProductsAt(url : URL) {
        NetworkService.fetch(url: url) { result in
                self.productsResult = result
     
        }
    }
    func getOrders(){
        let endPoint = APIEndpoint.orders
        let url = endPoint.url(forShopName: NetworkService.baseUrl)
        NetworkService.fetch(url: url) { result in
            self.ordersResult = result
        }
    }
}



extension NetworkViewModel
{
    func getAds() {
        NetworkService.getDiscountCodes(url:  "https://48c475a06d64f3aec1289f7559115a55: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@ios-q2-new-capital-admin2-2022-2023.myshopify.com/admin/api/2023-01/price_rules/1382520553776/discount_codes.json") { result in
                if let result = result {
                    self.adsResult = result
                }
            }
        }
}
extension NetworkViewModel
{
    func getCartProducts() {
        NetworkService.getShoppingCartProducts(url: "https://48c475a06d64f3aec1289f7559115a55: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@ios-q2-new-capital-admin2-2022-2023.myshopify.com/admin/api/2023-01/draft_orders.json") { result in
            if let result = result {
                self.ShoppingCartProductsResult = result.draft_orders ?? []
            }
        }
    }

}

//
//  HomeViewModel.swift
//  Shopify
//
//  Created by Mahmoud on 25/02/2023.
//

import Foundation
class BrandsViewModel{
    
    var bindingBrands : (()->()) = {}
    var brandsResult : Brands!{
        didSet{
            bindingBrands()
        }
    }
    func getBrands() {
        let brandEndPoint = APIEndpoint.brands
        let barndUrl = brandEndPoint.url(forShopName: NetworkService.baseUrl)
            NetworkService.fetch(url: barndUrl) { result in
                self.brandsResult = result
            }
        }
 
    
    //MARK: post methods
    func postCustomer (url : URL,  data : [String : Any],complition :  @escaping (Result<Data, Error>) -> Void)
    {
        NetworkService.postData(urlEndPoint : url , parameter: data,complition : complition)
    }
    
    
}
class BrandItemsViewModel{
    var bindingBrandItems : (()->()) = {}
    var brandItemsResult : Products!{
        didSet{
            bindingBrandItems()
        }
    }
    func getItems(brandId : Int?) {
        let brandEndPoint = APIEndpoint.brandItems
        let barndUrl = brandEndPoint.urlWithId(forShopName: "48c475a06d64f3aec1289f7559115a55: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@ios-q2-new-capital-admin2-2022-2023", brandId: brandId!)
        NetworkService.fetch(url: barndUrl) { result in
                self.brandItemsResult = result
        }
    }
}


class CustomersViewModel{
    var bindingCustomer : (()->()) = {}
    var customerResult : Customers!{
        didSet{
            bindingCustomer()
        }
    }
    func getcustomerBY(email : String){
        let endPoint = APIEndpoint.customerSearch
        let url = endPoint.url(forShopName: NetworkService.baseUrl)
        let urlString = url.absoluteString
        let urlEndPoint = URL(string: urlString.appending("?query=email:\(email)"))
       
        print(urlEndPoint)
        NetworkService.fetch(url: urlEndPoint) { result in
            self.customerResult = result
        }
    }
}

class ProductsViewModel{
    var bindingProducts: (() -> ()) = {}
    var productsResult: Products!{
        didSet{
            bindingProducts()
        }
    }
    func getProductsAt(url : URL) {
        NetworkService.fetch(url: url) { result in
                self.productsResult = result
     
        }
    }
}

class ADsViewModel{
    var bindingAds : (() -> ()) = {}
    var adsResult : DiscountCodes!    {
        didSet {
            bindingAds()
        }
    }
    func getAds() {
        NetworkService.getDiscountCodes(url:  "https://48c475a06d64f3aec1289f7559115a55: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@ios-q2-new-capital-admin2-2022-2023.myshopify.com/admin/api/2023-01/price_rules/1383402504496/discount_codes.json") { result in
                if let result = result {
                    self.adsResult = result
                }
            }
        }
}

class ShoppingCartProductsViewModel
{
    
    var bindingCartProducts : (() -> ()) = {}
    var ShoppingCartProductsResult: [LineItem] = []{
        didSet{
            bindingCartProducts()
        }
    }
    func getCartProducts(url : String) {
        NetworkService.getShoppingCartProducts(url: url) { result in
            if let result = result {
                self.ShoppingCartProductsResult = result.draft_order?.line_items ?? []
            }
        }
    }

}

class ProductViewModel
{
    var bindingProduct : (() -> ()) = {}
    var productResult: Product = Product(){
        didSet{
            bindingProduct()
        }
    }
    
    func getSingleProduct(url:String) {
        NetworkService.getProduct( url:  url) { result in
                if let result = result {
                    self.productResult = result.product ?? Product()
                }
            }
        }
    var bindingArrOfProducts : (() -> ()) = {}
    var arrOfProductsResult: [Product] = []{
        didSet{
            bindingArrOfProducts()
        }
    }
    
    
    func getArrayOfProducts(url:String) {
        NetworkService.getArrOfProduct(url:  url)   { result in
                if let result = result {
                    self.arrOfProductsResult = result.products! 
                }
            }
        }
}

class OrderViewModel{
    var bindingOrdersItems : (()->()) = {}
    var ordersResult : Orders!{
        didSet{
            bindingOrdersItems()
        }
    }
 
    
    
    
   
    func getOrders(){
//        let endPoint = APIEndpoint.customer
//
//        let url = endPoint.url(forShopName: NetworkService.baseUrl)
        var url : String = NetworkService.base_url
        url = url.appending("customers/\(UserDefaults.standard.value(forKey: "userId") ?? 0)/orders.json")
        print(url)
        NetworkService.fetch(url:URL(string:  url) ) { result in
            self.ordersResult = result
        }
    }
}

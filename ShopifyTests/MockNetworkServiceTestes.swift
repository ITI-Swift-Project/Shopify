//
//  MockNetworkServiceTestes.swift
//  ShopifyTests
//
//  Created by Ahmad Ayman Mansour on 13/03/2023.
//

import XCTest
@testable import Shopify

final class MockNetworkServiceTestes: XCTestCase {
    var brands : Brands!
    override func setUpWithError() throws {
        brands = Brands()
    }

    override func tearDownWithError() throws {
       brands = nil
    }
    
    
    
    func testGetDiscountCodes(){
        let url = "\(NetworkService.base_url)price_rules/1383730250032/discount_codes.json"
        MockNetworkServiceData.getDiscountCodes(url: url) { result in
            guard let result = result else {
                XCTFail()
                return
            }
            XCTAssertNotEqual(result.discount_codes?.count, 0, "API Failed")
        }
    }
    
//    func  testGetProduct(){
//        let url = "\(NetworkService.base_url)products/8162372452656.json"
//        MockNetworkServiceData.getProduct(url: url) { result in
//            guard let result = result else {
//                XCTFail()
//                return
//            }
//            XCTAssertNotEqual(result.product?.id, 0, "API Failed")
//        }
//    }
    
    func  testGetProductsData(){
        guard let url = URL(string: "\(NetworkService.base_url)products.json") else{return}
        MockNetworkServiceData.getProductsData(url: url) { result in
            guard let result = result else {
                XCTFail()
                return
            }
            XCTAssertNotEqual(result.products?.count, 0, "API Failed")
        }
    }
    
//    func  testGetShoppingCartProducts(){
//        let url = "\(NetworkService.base_url)draft_orders.json"
//        MockNetworkServiceData.getShoppingCartProducts(url: url) { result in
//            guard let result = result else {
//                XCTFail()
//                return
//            }
//            XCTAssertNotEqual(result.draft_order?.line_items?.count, 0, "API Failed")
//        }
//    }
    func  testGetArrOfProduct(){
        let url = "\(NetworkService.base_url)products.json"
        MockNetworkServiceData.getArrOfProduct(url: url) { result in
            guard let result = result else {
                XCTFail()
                return
            }
            XCTAssertNotEqual(result.products?.count, 0, "API Failed")
        }
    }


}


//func testFetch() {
//    let expectaion = expectation(description: "Waiting for the API to get Data")
//
//    let url = URL(string: "\(NetworkService.base_url)custom_collections.json")
//    NetworkService.fetch(url: url) { result in
//        self.brands = result
//        XCTAssertNotEqual(self.brands.smart_collections?.count, 0, "API Failed")
//        expectaion.fulfill()
//    }
//    waitForExpectations(timeout: 5 , handler: nil)
//}

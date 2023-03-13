//
//  NetworkServicesTestes.swift
//  ShopifyTests
//
//  Created by Ahmad Ayman Mansour on 13/03/2023.
//

import XCTest
@testable import Shopify

final class NetworkServicesTestes: XCTestCase {
    var brands : Brands!
    override func setUpWithError() throws {
        brands = Brands()
    }

    override func tearDownWithError() throws {
        brands = nil
    }
    
    
    //MARK: - Test Fetching Methods
    
    
//    func testFetch() {
//        let expectaion = expectation(description: "Waiting for the API to get Data")
//        
//        let url = URL(string: "\(NetworkService.base_url)custom_collections.json")
//        NetworkService.fetch(url: url) { result in
//            self.brands = result
//            XCTAssertNotEqual(self.brands.smart_collections?.count, 0, "API Failed")
//            expectaion.fulfill()
//        }
//        waitForExpectations(timeout: 5 , handler: nil)
//    }
    
    
    func testGetDiscountCodes() {
        let expectaion = expectation(description: "Waiting for the API to get discount codes")
        let url = "\(NetworkService.base_url)price_rules/1383730250032/discount_codes.json"
        NetworkService.getDiscountCodes(url: url) { products in
            guard let result = products else {
                XCTFail()
                expectaion.fulfill()
                return
            }
            XCTAssertNotEqual(result.discount_codes?.count, 0, "API Failed")
            expectaion.fulfill()
        }
        waitForExpectations(timeout: 5 , handler: nil)
    }

    
    func testGetProduct() {
        let expectaion = expectation(description: "Waiting for the API to get Single product")
        let url = "\(NetworkService.base_url)products/8162372452656.json"
        NetworkService.getProduct(url: url) { product in
            guard let _ = product else {
                XCTFail()
                expectaion.fulfill()
                return
            }
            expectaion.fulfill()
        }
        waitForExpectations(timeout: 5 , handler: nil)
    }
    
    
    func testGetProductsData() {
        let expectaion = expectation(description: "Waiting for the API to get Products")
        guard let url = URL(string: "\(NetworkService.base_url)products.json") else{return}
        NetworkService.getProductsData(url: url) { products in
            guard let result = products else {
                XCTFail()
                expectaion.fulfill()
                return
            }
            XCTAssertNotEqual(result.products?.count, 0, "API Failed")
            expectaion.fulfill()
        }
        waitForExpectations(timeout: 5 , handler: nil)
    }
    
    

    
    func testGetShoppingCartProducts() {
        let expectaion = expectation(description: "Waiting for the API to get draft orders")
        let url = "\(NetworkService.base_url)draft_orders.json"
        NetworkService.getShoppingCartProducts(url: url) { draftOrders in
            guard let result = draftOrders else {
                XCTFail()
                expectaion.fulfill()
                return
            }
            XCTAssertNotEqual(result.draft_order?.line_items?.count, 0, "API Failed")
            expectaion.fulfill()
        }
        waitForExpectations(timeout: 5 , handler: nil)
    }

    
    func testGetArrOfProduct() {
        let expectaion = expectation(description: "Waiting for the API to Products")
        let url = "\(NetworkService.base_url)products.json"
        NetworkService.getArrOfProduct(url: url) { products in
            guard let result = products else {
                XCTFail()
                expectaion.fulfill()
                return
            }
            XCTAssertNotEqual(result.products?.count, 0, "API Failed")
            expectaion.fulfill()
        }
        waitForExpectations(timeout: 5 , handler: nil)
    }
    
    
    //MARK: - Test POST Methods
}

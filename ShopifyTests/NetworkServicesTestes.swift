//
//  NetworkServicesTestes.swift
//  ShopifyTests
//
//  Created by Ahmad Ayman Mansour on 13/03/2023.
//

import XCTest
import OHHTTPStubs
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
    
    func testFetch() {
        let expectation = XCTestExpectation(description: "Fetch request completed")
        
        let url = URL(string: "\(NetworkService.base_url)custom_collections.json")!
        
        NetworkService.fetch(url: url) { (result: Brands?) in
            XCTAssertNotNil(result, "Result should not be nil")
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 10.0)
    }
    
    
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
    
    func testGetCustomerAddresses() {
            let stubbedResponse = Customer()
            let url = "https://example.com/api"
            stub(condition: isAbsoluteURLString(url)) { _ in
                let data = try! JSONEncoder().encode(stubbedResponse)
                return HTTPStubsResponse(data: data, statusCode: 200, headers: nil)
            }
            
            let expectation = self.expectation(description: "Completion handler invoked")
        Temp.getCustomerAddresses(url: url) { result in
               
                expectation.fulfill()
            }
            
            waitForExpectations(timeout: 5, handler: nil)
            
            HTTPStubs.removeAllStubs()
        }
    
    //MARK: - Test POST Methods
    func testPostData() {
        let expectation = XCTestExpectation(description: "POST request completed")
        
        let url = URL(string: "\(NetworkService.base_url)products.json")!
        let parameters = ["key": "value"]
        
        NetworkService.postData(urlEndPoint: url, parameter: parameters) { result in
            switch result {
            case .success(let data):
                XCTAssertNotNil(data, "Data should not be nil")
                expectation.fulfill()
            case .failure(let error):
                XCTFail("POST request failed with error: \(error.localizedDescription)")
            }
        }
        
        wait(for: [expectation], timeout: 10.0)
    }
    
    
    func testPostWithError() {
            let stubbedResponse = ["key": "value"]
            let url = "\(NetworkService.base_url)products.json"
            stub(condition: isAbsoluteURLString(url)) { _ in
                let data = try! JSONSerialization.data(withJSONObject: stubbedResponse, options: .prettyPrinted)
                return HTTPStubsResponse(data: data, statusCode: 200, headers: nil)
            }
            
            let parameters = ["foo": "bar"]
            let expectation = self.expectation(description: "Completion handler invoked")
            NetworkService.postWithError(url: url, parameters: parameters) { result in
                XCTAssertEqual(result as! [String : String], stubbedResponse)
                expectation.fulfill()
            }
            waitForExpectations(timeout: 5, handler: nil)
            HTTPStubs.removeAllStubs()
        }

        //MARK: - PUT Methods
    func testPutWithError() {
            let stubbedResponse = ["key": "value"]
            let url = "\(NetworkService.base_url)products/8162372452656.json"
            stub(condition: isAbsoluteURLString(url)) { _ in
                let data = try! JSONSerialization.data(withJSONObject: stubbedResponse, options: .prettyPrinted)
                return HTTPStubsResponse(data: data, statusCode: 200, headers: nil)
            }
            let parameters = ["foo": "bar"]
            let expectation = self.expectation(description: "Completion handler invoked")
            NetworkService.putWithError(url: url, parameters: parameters) { result in
                XCTAssertEqual(result as! [String : String], stubbedResponse)
                expectation.fulfill()
            }
            waitForExpectations(timeout: 5, handler: nil)
            HTTPStubs.removeAllStubs()
        }

    
}

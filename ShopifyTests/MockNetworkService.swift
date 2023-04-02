//
//  MockNetworkService.swift
//  ShopifyTests
//
//  Created by Ahmad Ayman Mansour on 13/03/2023.
//

import XCTest
@testable import Shopify

    class MockNetworkServiceData{
        static let mockBrandsJSONReaonse : String = "{\"custom_collections\":[{\"title\":\"Home Page\"},{\"sort_order\":\"best-selling\"}]}"
        static let mockProductsJSONReaonse : String = "{\"products\":[{\"title\":\"name\"},{\"vendor\":\"vendor\"}]}"
        static let mockProductJSONReaonse : String = "{\"product\":{\"title\":\"name\"},{\"vendor\":\"vendor\"}}"
        static let mockDiscountsJSONReaonse : String = "{\"discount_codes\":[{\"code\":\"code\"},{\"created_at\":\"03-2023\"}]}"
        static let mockDraftOrderJSONReaonse : String = "{\"draft_order\":{\"name\":\"name\"},{\"currency\":\"EGP\"}}"
        
        
        
        static func fetch<T : Decodable>(url : URL?,compiletionHandler : @escaping(T?) -> Void){
            let data = Data(MockNetworkServiceData.mockBrandsJSONReaonse.utf8)
            do {
                let response = try JSONDecoder().decode(T.self, from: data)
                compiletionHandler(response)
            } catch {
                compiletionHandler(nil)
            }
            
        }
        
        static func getProductsData(url: URL, completion: @escaping (Products?) -> Void) {
            let data = Data(MockNetworkServiceData.mockProductsJSONReaonse.utf8)
            do {
                let response = try JSONDecoder().decode(Products.self, from: data)
                completion(response)
            } catch {
                completion(nil)
            }
        }
        
        static func getDiscountCodes(url: String, handeler: @escaping (DiscountCodes?) -> Void)
        {
            let data = Data(MockNetworkServiceData.mockDiscountsJSONReaonse.utf8)
            do {
                let response = try JSONDecoder().decode(DiscountCodes.self, from: data)
                handeler(response)
            } catch {
                handeler(nil)
            }
        }
        
        static func getShoppingCartProducts(url: String, handeler: @escaping (SingleDraftOrder?) -> Void)
        {
            let data = Data(MockNetworkServiceData.mockDraftOrderJSONReaonse.utf8)
            do {
                let response = try JSONDecoder().decode(SingleDraftOrder.self, from: data)
                handeler(response)
            } catch {
                handeler(nil)
            }
        }
        
        static func getProduct( url: String, handeler: @escaping (SingleProduct?) -> Void)
        {
            let data = Data(MockNetworkServiceData.mockProductJSONReaonse.utf8)
            do {
                let response = try JSONDecoder().decode(SingleProduct.self, from: data)
                handeler(response)
            } catch {
                handeler(nil)
            }
        }
        
        static func getArrOfProduct( url: String, handeler: @escaping (Products?) -> Void)
        {
            let data = Data(MockNetworkServiceData.mockProductsJSONReaonse.utf8)
            do {
                let response = try JSONDecoder().decode(Products.self, from: data)
                handeler(response)
            } catch {
                handeler(nil)
            }
        }
    }



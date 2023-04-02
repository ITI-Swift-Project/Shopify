//
//  CoreDataManagerTestes.swift
//  ShopifyTests
//
//  Created by Ahmad Ayman Mansour on 14/03/2023.
//

import XCTest
import CoreData
@testable import Shopify


final class CoreDataManagerTestes: XCTestCase {

        
        var cart: CartCoreDataManager!
        var wishList : WishListCoreDataManager!
        
        override func setUp() {
            super.setUp()
            
            cart = CartCoreDataManager.getCartInstance()
            wishList = WishListCoreDataManager.getWishListInstance()
        }
        
        override func tearDown() {
            cart = nil
            wishList = nil
            super.tearDown()
        }
    
    //MARK: - Cart
        
        func testSaveToCart() {
            cart.saveToCart(id: 1, title: "Product 1", price: "10.99", quantity: 1, image: "product1.jpg", vendor: "Vendor 1", inventory: 10)
            
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Cart")
            let predicate = NSPredicate(format: "id == %@", "1")
            fetchRequest.predicate = predicate
            
            let context = cart.managedContext
            
            var fetchedResults: [NSManagedObject]? = nil
            do {
                fetchedResults = try context?.fetch(fetchRequest) as? [NSManagedObject]
            } catch {
                XCTFail("Fetch error: \(error.localizedDescription)")
            }
            
            XCTAssertEqual(fetchedResults?.count, 1)
            
            let fetchedProduct = fetchedResults?.first
            XCTAssertEqual(fetchedProduct?.value(forKey: "id") as? Int, 1)
            XCTAssertEqual(fetchedProduct?.value(forKey: "title") as? String, "Product 1")
            XCTAssertEqual(fetchedProduct?.value(forKey: "price") as? String, "10.99")
            XCTAssertEqual(fetchedProduct?.value(forKey: "quantity") as? Int, 1)
            XCTAssertEqual(fetchedProduct?.value(forKey: "image") as? String, "product1.jpg")
            XCTAssertEqual(fetchedProduct?.value(forKey: "vendor") as? String, "Vendor 1")
            XCTAssertEqual(fetchedProduct?.value(forKey: "inventory") as? Int, 10)
        }
        
        func testFetchFromCart() {
            let fetchResults = cart.fetchFromCart()
            XCTAssertNotNil(fetchResults)
        }
        
        func testDeleteFromCart() {
            cart.saveToCart(id: 2, title: "Product 2", price: "19.99", quantity: 1, image: "product2.jpg", vendor: "Vendor 2", inventory: 5)
            
            var fetchResults = cart.fetchFromCart()
            XCTAssertNotNil(fetchResults)
            XCTAssertEqual(fetchResults?.count, 1)
            
            cart.deleteFromCart(id: 2)
            
            fetchResults = cart.fetchFromCart()
            XCTAssertEqual(fetchResults?.count, 0)
        }
        
        func testUpdateQuantity() {
            cart.saveToCart(id: 3, title: "product", price: "7", quantity: 1, image: "src", vendor: "Vendor", inventory: 20)
            
            var fetchResults = cart.fetchFromCart()
            XCTAssertNotNil(fetchResults)
            XCTAssertEqual(fetchResults?.count, 1)
            
            cart.updataQuantity(quantity: 2, id: 3)
            
            fetchResults = cart.fetchFromCart()
            XCTAssertEqual(fetchResults?.count, 1)
            
            let fetchedProduct = fetchResults?.first
            XCTAssertEqual(fetchedProduct?.value(forKey: "quantity") as? Int, 2)
        }

    //MARK: - Wish List
    func testSaveToWishList() {
        wishList.saveToWishList(id: 1, title: "product", price: "10", quantity: 12, image: "src", vendor: "vendor")
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Cart")
        let predicate = NSPredicate(format: "id == %@", "1")
        fetchRequest.predicate = predicate
        
        let context = wishList.managedContext
        
        var fetchedResults: [NSManagedObject]? = nil
        do {
            fetchedResults = try context?.fetch(fetchRequest) as? [NSManagedObject]
        } catch {
            XCTFail("Fetch error: \(error.localizedDescription)")
        }
        
        XCTAssertEqual(fetchedResults?.count, 1)
        
        let fetchedProduct = fetchedResults?.first
        XCTAssertEqual(fetchedProduct?.value(forKey: "id") as? Int, 1)
        XCTAssertEqual(fetchedProduct?.value(forKey: "title") as? String, "Product 1")
        XCTAssertEqual(fetchedProduct?.value(forKey: "price") as? String, "10.99")
        XCTAssertEqual(fetchedProduct?.value(forKey: "quantity") as? Int, 1)
        XCTAssertEqual(fetchedProduct?.value(forKey: "image") as? String, "product1.jpg")
        XCTAssertEqual(fetchedProduct?.value(forKey: "vendor") as? String, "Vendor 1")
    }
    
    func testFetchFromWishList() {
        let fetchResults = wishList.fetchFromWishList()
        XCTAssertNotNil(fetchResults)
    }
    
    func testDeleteFromWishList() {
        wishList.saveToWishList(id: 2, title: "product" , price: "10", quantity: 12, image: "src", vendor: "vendor")
        
        var fetchResults = wishList.fetchFromWishList()
        XCTAssertNotNil(fetchResults)
        XCTAssertEqual(fetchResults?.count, 1)
        
        wishList.deleteFromWishList(id: 2)
        
        fetchResults = wishList.fetchFromWishList()
        XCTAssertEqual(fetchResults?.count, 0)
    }

}

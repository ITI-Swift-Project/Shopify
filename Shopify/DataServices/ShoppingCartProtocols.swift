//
//  ShoppingCartProtocols.swift
//  Shopify
//
//  Created by Fatma on 05/03/2023.
//

import Foundation
import CoreData
protocol ShoppingCartProtocol{
    
    func saveProductInShoppingCart(product : DraftOrder, appDelegate : AppDelegate) -> Void
    func fetchShoppingCartProducts(appDelegate : AppDelegate) -> [NSManagedObject]?
    func deleteShoppingCartProduct(appDelegate: AppDelegate, product_id : Int)
    
}

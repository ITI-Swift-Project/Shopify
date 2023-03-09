//
//  CoreDataViewModel.swift
//  Shopify
//
//  Created by Fatma on 09/03/2023.
//

import Foundation
import CoreData

class CoreDataViewModel {
    
    var database = DataManager.getInstance()
    
    
    func saveProductToCoreData(productTypt: Int, draftproduct : Product)
    {
        database.save(productTypt: productTypt, draftproduct: draftproduct)
    }
    func fetchProductsFromCoreData(productType:Int) -> [NSManagedObject]?
    {
        database.fetch(productType: productType)
    }
    func deleteProductFromCoreData(deletedProductType: Int, productId: Int)
    {
        database.delete(deletedProductType: deletedProductType, productId: productId)
    }
    func deleteAllProductsFromCoreData()
    {
        database.deleteAll()
    }
    func isProductAddedToCartCoreData(productId: Int) ->Bool
    {
        database.isAddedToCart(productId: productId)
    }
    func isProductAddedToWishListCoreData(productId: Int) ->Bool
    {
        database.isAddedToWishList(productId: productId)
    }
}

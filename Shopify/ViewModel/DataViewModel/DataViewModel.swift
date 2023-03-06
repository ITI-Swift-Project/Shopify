//
//  DataViewModel.swift
//  Shopify
//
//  Created by Fatma on 05/03/2023.
//

import Foundation
import CoreData
class DataViewModel {
    
    var bindingData: (([DraftOrder]?,Error?) -> Void) = {_, _ in }
    
    var savedProductsArray:[DraftOrder]? {
        didSet {
            bindingData(savedProductsArray,nil)
        }
    }
    
    let dataCaching: ShoppingCartProtocol
    init(dataCaching : ShoppingCartProtocol = DataManager()) {
        self.dataCaching = dataCaching
    }
    func saveCartProduct(appDelegate: AppDelegate , proItem: Product)
    {
        dataCaching.saveProductInShoppingCart(product: proItem, appDelegate: appDelegate)
    }
    
    func fetchSavedCartProducts (appDelegate : AppDelegate)->[NSManagedObject]{
        dataCaching.fetchFormCoreData(appDelegate: appDelegate)!
    }
    
  
/*    func deleteLeagueItemFromFavourites(appDeleget : AppDelegate , prod_id: Int)
    {
        dataCaching.deleteShoppingCartProduct(appDelegate: appDeleget, product_id: prod_id)
    }*/
 
  /*  func isFavourite(appDelegate : AppDelegate , leagueKey : Int) -> Bool
    {
       return dataCaching.isFavourite(leagueKey: leagueKey, appDelegate: appDelegate)
    }*/
    
}

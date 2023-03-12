//
//  DataManager.swift
//  Shopify
//
//  Created by Fatma on 05/03/2023.
//

import Foundation
import UIKit
import CoreData

class DataManager //: ShoppingCartProtocol
{
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    let managedContext : NSManagedObjectContext!
    let entity : NSEntityDescription!
    
    private static var dataBaseInstance : DataManager?
    
    public static func getInstance() -> DataManager{
        if let instance = dataBaseInstance {
            return instance
        }else{
            dataBaseInstance = DataManager()
            return dataBaseInstance!
        }
    }
    
    private init (){
        managedContext = appDelegate.persistentContainer.viewContext
        entity = NSEntityDescription.entity(forEntityName: "ShoppingCartProduct", in: managedContext)
    }
    
     func save(productTypt: Int, draftproduct : Product) -> Void
    {
        let product = NSManagedObject(entity: entity!, insertInto: managedContext)
        product.setValue(draftproduct.id ?? 0, forKey: "product_id")
        product.setValue(draftproduct.title, forKey: "product_title")
        product.setValue(draftproduct.variants?[0].price, forKey: "product_price")
        product.setValue("1", forKey: "product_quantity")
        product.setValue(productTypt, forKey: "product_type")
        product.setValue(true, forKey: "product_state")
        product.setValue(draftproduct.image?.src, forKey: "product_image")
        product.setValue(draftproduct.vendor, forKey: "product_vendor")
        do{
            try managedContext.save()
            print("Saved!")
        }catch let error{
            print(error.localizedDescription)
        }
    }
    
    
     func fetch(productType:Int) -> [NSManagedObject]?{
         let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "ShoppingCartProduct")
        let pred = NSPredicate(format: "product_type == %i", productType as CVarArg )
        fetchRequest.predicate = pred
        var fetchedProductsList : [NSManagedObject] = []
        do{
            fetchedProductsList = try managedContext.fetch(fetchRequest)
        }catch let error{
            print(error.localizedDescription)
        }
        return fetchedProductsList
    }
    
     func isAddedToCart (productId: Int) -> Bool
    {
        var state : Bool = false
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "ShoppingCartProduct")
        let pred = NSPredicate(format: "product_type == %i", 1)
        fetchRequest.predicate = pred
        do{
            let fetchedLeagueArray = try managedContext.fetch(fetchRequest)
            for item in (fetchedLeagueArray)
            {
                if item.value(forKey: "product_id") as! Int == productId
                {
                    state = true
                }
            }
        }catch let error{
            print(error.localizedDescription)
        }
        
        if state == true
        {
            return true
        }
        else
        {
            return false
        }
    }
    
     func isAddedToWishList (productId: Int) -> Bool
    {
        var state : Bool = false
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "ShoppingCartProduct")
       // let fpred = NSPredicate(format: "product_type == %i", 2)
        let pred = NSPredicate(format: "product_id == %i", productId)
        var count : Int?
        fetchRequest.predicate = pred
        do{
             count = try managedContext.fetch(fetchRequest).count
        }catch let error{
            print(error.localizedDescription)
        }
        if count == 0
        {
            state = false
        }
        else
        {
            state = true
        }
       return state
    }

    
     func delete(deletedProductType: Int, productId: Int)
    {
        if let arr = fetch(productType: deletedProductType) {
            for item in arr {
                if item.value(forKey:"product_id") as! Int == productId
                {
                    managedContext.delete(item)
                    print("UnSaved!")
                    try?managedContext.save()
                }
            }
        }
    }
    
     func deleteAll()
    {
        if let arr = fetch(productType: 1) {
            for item in arr {
                managedContext.delete(item)
                try?managedContext.save()
            }
        }
        if let arr2 = fetch(productType: 2) {
            for item in arr2 {
                managedContext.delete(item)
                try?managedContext.save()
            }
        }
    }
}

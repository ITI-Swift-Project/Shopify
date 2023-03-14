//
//  CoreDataManager.swift
//  Shopify
//
//  Created by Ahmad Ayman Mansour on 14/03/2023.
//

import UIKit
import CoreData


class CartCoreDataManager : CartCD {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    let managedContext : NSManagedObjectContext!
    let entity : NSEntityDescription!
    
    private static var cartInstance : CartCoreDataManager?
    
    public static func getCartInstance() -> CartCoreDataManager {
        if let instance = cartInstance {
            return instance
        }else{
            cartInstance = CartCoreDataManager()
            return cartInstance!
        }
    }
    
    private init () {
        managedContext = appDelegate.persistentContainer.viewContext
        entity = NSEntityDescription.entity(forEntityName: "Cart", in: managedContext)
    }
    
    func saveToCart(id: Int, title: String, price: String, quantity: Int, image: String, vendor: String) {
        let cartProduct = NSEntityDescription.insertNewObject(forEntityName: "Cart", into: managedContext)
        cartProduct.setValue(id, forKey: "id")
        cartProduct.setValue(title, forKey: "title")
        cartProduct.setValue(price, forKey: "price")
        cartProduct.setValue(quantity, forKey: "quantity")
        cartProduct.setValue(image, forKey: "image")
        cartProduct.setValue(vendor, forKey: "vendor")
        try?self.managedContext.save()
    }
    
    func fetchFromCart() -> [NSManagedObject]? {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Cart")
        
        if let arr = try? managedContext.fetch(fetchRequest) {
            if arr.count > 0 {
                return arr
            }
            return nil
        }else{
            return nil
        }
    }
    
    func deleteFromCart(id : Int) {
        if let arr = fetchFromCart() {
            for obj in arr {
                if obj.value(forKey:"id") as! Int == id {
                    managedContext.delete(obj)
                    try?managedContext.save()
                }
            }
        }
    }
    
}


    
class WishListCoreDataManager : WishListCD {

    let appDelegate = UIApplication.shared.delegate as! AppDelegate

    let managedContext : NSManagedObjectContext!
    let entity : NSEntityDescription!

    private static var WishListInstance : WishListCoreDataManager?

    public static func getWishListInstance() -> WishListCoreDataManager{
        if let instance = WishListInstance {
            return instance
        }else{
            WishListInstance = WishListCoreDataManager()
            return WishListInstance!
        }
    }

    private init () {
        managedContext = appDelegate.persistentContainer.viewContext
        entity = NSEntityDescription.entity(forEntityName: "Wish", in: managedContext)
    }



    
    func saveToWishList(id: Int, title: String, price: String, quantity: Int, image: String, vendor: String) {
        let cartProduct = NSEntityDescription.insertNewObject(forEntityName: "Wish", into: managedContext)
        cartProduct.setValue(id, forKey: "id")
        cartProduct.setValue(title, forKey: "title")
        cartProduct.setValue(price, forKey: "price")
        cartProduct.setValue(quantity, forKey: "quantity")
        cartProduct.setValue(image, forKey: "image")
        cartProduct.setValue(vendor, forKey: "vendor")
        try?self.managedContext.save()
    }
    
    func fetchFromWishList() -> [NSManagedObject]? {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Wish")

        if let arr = try? managedContext.fetch(fetchRequest) {
            if arr.count > 0 {
                return arr
            }
            return nil
        }else{
            return nil
        }
    }
    
    func deleteFromWishList(id: Int) {
        if let arr = fetchFromWishList() {
            for obj in arr {
                if obj.value(forKey:"id") as! Int == id {
                    managedContext.delete(obj)
                    try?managedContext.save()
                }
            }
        }
    }
    
    
    
    
}




//
//  DataServices.swift
//  Shopify
//
//  Created by Fatma on 05/03/2023.
//

import Foundation
import CoreData

class DataServices  {
  //  static let sharedInstance = DataServices()

  static func save(draftproduct : DraftOrder, appDelegate : AppDelegate) -> Void
    {
        let managedContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "ShoppingCartProduct", in: managedContext)
        let product = NSManagedObject(entity: entity!, insertInto: managedContext)
        product.setValue(draftproduct.id ?? 0, forKey: "product_id")
        product.setValue(draftproduct.line_items?[0].title, forKey: "product_title")
        product.setValue(draftproduct.line_items?[0].price, forKey: "product_price")
        product.setValue(String((draftproduct.line_items?[0].quantity)!), forKey: "product_quantity")

        do{
            try managedContext.save()
            print("Saved!")
        }catch let error{
            print(error.localizedDescription)
        }
    }
    
    
    static func fetch(appDelegate : AppDelegate) -> [NSManagedObject]?{
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "ShoppingCartProduct")
        var cartProductsList : [NSManagedObject]?
            do{
                 cartProductsList = try managedContext.fetch(fetchRequest)
            }catch let error{
                print(error.localizedDescription)
            }
        return cartProductsList
    }
    
 /*   func delete(index : Int)
    {
            let managedContext = self.appDelegate.persistentContainer.viewContext
            managedContext.delete((self.cartProductsList?[index])! )
            self.cartProductsList?.remove(at: index)
            do{
                try managedContext.save()
            }
            catch _{
            }
    }*/
    
}


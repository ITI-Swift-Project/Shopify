//
//  CoreDataProtocols.swift
//  Shopify
//
//  Created by Ahmad Ayman Mansour on 14/03/2023.
//

import Foundation
import CoreData

protocol CartCD {
    func saveToCart(id: Int, title: String, price: String, quantity: Int , image: String , vendor : String , inventory : Int)
    func fetchFromCart()-> [NSManagedObject]?
    func deleteFromCart(id : Int)
}

protocol WishListCD {
    func saveToWishList(id: Int, title: String, price: String, quantity: Int , image: String , vendor : String)
    func fetchFromWishList()-> [NSManagedObject]?
    func deleteFromWishList(id : Int)
}

//
//  CoreDataViewModel.swift
//  Shopify
//
//  Created by Ahmad Ayman Mansour on 14/03/2023.
//

import Foundation

class CoreDataViewModelClass {
    
    
    //MARK: - Cart
    var cartDataBase = CartCoreDataManager.getCartInstance()

    var bindingCartState : (()->()) = {}
    
    var cartState:Bool!{
        didSet{
            self.bindingCartState()
        }
    }
    
    func checkCartState(id:Int) -> Bool  {
        if let validState = cartDataBase.fetchFromCart() {
            for item in validState {
                if item.value(forKey: "id") as! Int == id {
                    cartState = true
                    return true
                }
            }
            cartState = false
            return false
        }else{
            cartState = false
            return false
        }
    }
    
    func deleteFromCart(id:Int){
        cartDataBase.deleteFromCart(id: id)
        cartState = false
    }
    
    func addToCart(id: Int, title: String, price: String, quantity: Int, image: String, vendor: String)  {
    cartDataBase.saveToCart(id: id, title: title, price: price, quantity:quantity, image: image, vendor: vendor)
        cartState = true
    }
    
    //MARK: - WishList
    var wishListDataBase = WishListCoreDataManager.getWishListInstance()

    var bindingWishListState : (()->()) = {}
    
    var wishListState:Bool!{
        didSet{
            self.bindingWishListState()
        }
    }
    
    func checkWishListState(id:Int) -> Bool  {
        if let validState = wishListDataBase.fetchFromWishList(){
            for item in validState {
                if item.value(forKey: "id") as! Int == id {
                    wishListState = true
                    return true
                }
            }
            wishListState = false
            return false
        }else{
            wishListState = false
            return false
        }
    }
    
    func deleteFromWishList(id:Int){
        wishListDataBase.deleteFromWishList(id: id)
        wishListState = false
    }
    
    func addToWishList(id: Int, title: String, price: String, quantity: Int, image: String, vendor: String)  {
        wishListDataBase.saveToWishList(id: id, title: title, price: price, quantity:quantity, image: image, vendor: vendor)
        wishListState = true
    }
    
}


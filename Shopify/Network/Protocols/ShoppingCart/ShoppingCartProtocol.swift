//
//  ShoppingCartProtocol.swift
//  Shopify
//
//  Created by Fatma on 05/03/2023.
//

import Foundation
protocol ShoppingCartData
{
    static func getShoppingCartProducts(url: String, handeler: @escaping (DraftOrders?) -> Void)
}

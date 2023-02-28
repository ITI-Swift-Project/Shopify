//
//  ProductDataProtocol.swift
//  Shopify
//
//  Created by Mahmoud on 28/02/2023.
//

import Foundation
protocol ProductsDataProtocol {
    static func getProductsData(url :URL,completion : @escaping (Products?)->Void)
}

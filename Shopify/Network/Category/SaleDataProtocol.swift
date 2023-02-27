//
//  SaleDataProtocol.swift
//  Shopify
//
//  Created by Mahmoud on 27/02/2023.
//

import Foundation
protocol SaleDataProtocol {
    static func getSaleData(url :URL,completion : @escaping (Products?)->Void)
}

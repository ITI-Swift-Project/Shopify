//
//  WomenDataProtocol.swift
//  Shopify
//
//  Created by Mahmoud on 27/02/2023.
//

import Foundation
protocol WomenDataProtocol {
    static func getWomenData(url :URL,completion : @escaping (Products?)->Void)
}

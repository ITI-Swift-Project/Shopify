//
//  HomeDataProtocol.swift
//  Shopify
//
//  Created by Mahmoud on 27/02/2023.
//

import Foundation
protocol HomeDataProtocol {
    static func getHomeData(url :URL,completion : @escaping (Products?)->Void)
}

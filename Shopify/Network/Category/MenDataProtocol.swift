//
//  MenDataProtocol.swift
//  Shopify
//
//  Created by Mahmoud on 27/02/2023.
//

import Foundation
protocol MenDataProtocol {
    static func getMenData(url :URL,completion : @escaping (Products?)->Void)
}

//
//  DiscountCodesProtocol.swift
//  Shopify
//
//  Created by Fatma on 28/02/2023.
//

import Foundation
protocol DiscountsData
{
    static func getDiscountCodes(url : String, handeler: @escaping (DiscountCodes?)->Void)
}

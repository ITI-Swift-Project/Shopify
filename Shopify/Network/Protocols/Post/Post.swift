//
//  Post.swift
//  Shopify
//
//  Created by Aya on 05/03/2023.
//

import Foundation
protocol PostApi
{
    static func makePostRequest(url: String, newData: [String : Any],complition : @escaping ((Result<Data, Error>) -> Void))
}

//
//  CRUDProroco.swift
//  Shopify
//
//  Created by Mahmoud on 06/03/2023.
//

import Foundation
protocol GenericCRUDProtocol {
    static func postData( urlEndPoint : URL,parameter : [String : Any],complition :  @escaping (Result<Data, Error>) -> Void)
    static  func updateDate(parameter : [String : Any], urlEndPoint : String,complition :  @escaping (Result<Data, Error>) -> Void)
    static func deleteData(urlEndPoint : String)
}

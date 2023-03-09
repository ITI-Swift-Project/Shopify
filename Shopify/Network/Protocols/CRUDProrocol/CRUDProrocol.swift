//
//  CRUDProroco.swift
//  Shopify
//
//  Created by Mahmoud on 06/03/2023.
//

import Foundation
protocol GenericCRUDProtocol {
    static func postData(parameter : [String : Any], urlEndPoint : String)
    static  func updateDate(parameter : [String : Any], urlEndPoint : String)
    static func deleteData(urlEndPoint : String)
}

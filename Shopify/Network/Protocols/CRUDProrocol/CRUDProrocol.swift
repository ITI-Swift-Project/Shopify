//
//  CRUDProroco.swift
//  Shopify
//
//  Created by Mahmoud on 06/03/2023.
//

import Foundation
protocol GenericCRUDProtocol {
    func postData(parameter : [String : Any], urlEndPoint : String)
    func updateDate(parameter : [String : Any], urlEndPoint : String)
    func deleteData(urlEndPoint : String)
}

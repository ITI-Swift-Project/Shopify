//
//  NetworkService.swift
//  Shopify
//
//  Created by Mahmoud on 25/02/2023.
//

import Foundation
import Alamofire
class NetworkService : BrandsData{
    //    static var bindingBrands: (() -> ()) = {}
    //    static var brandData: [Brand] = []
    
    static func getAllBrands(url :URL ,completion : @escaping (Brands?)->Void){
        let request = AF.request(url)
        request.responseDecodable(of: Brands.self) { (data) in
            guard let newdata = data.value else{
                completion(nil)
                return
            }
            
            completion(newdata)
        }
    }
    
}


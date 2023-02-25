//
//  NetworkService.swift
//  Shopify
//
//  Created by Mahmoud on 25/02/2023.
//

import Foundation
import Alamofire
class NetworkService : BrandsData{
    var bindingBrands: (() -> ()) = {}
    var brandData: [Brand] = []
    
    static func getAllBrands(url :String ,completion : @escaping ()->Void){
        
        
    }
  
}

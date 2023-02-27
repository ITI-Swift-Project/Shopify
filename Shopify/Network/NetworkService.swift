//
//  NetworkService.swift
//  Shopify
//
//  Created by Mahmoud on 25/02/2023.
//

import Foundation
import Alamofire
class NetworkService : BrandsData{
    static var baseUrl = "48c475a06d64f3aec1289f7559115a55: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@ios-q2-new-capital-admin2-2022-2023"
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
extension NetworkService : BrandItemsData{
    static func getAllBrandItems(url: URL, brandId: Int, completion: @escaping (Products?) -> Void) {
        let request = AF.request(url)
        request.responseDecodable(of: Products.self) { (data) in
            guard let newdata = data.value else{
                completion(nil)
                return
            }
            
            completion(newdata)
        }
    }
}

extension NetworkService : HomeDataProtocol{
    static func getHomeData(url: URL, completion: @escaping (Products?) -> Void) {
        let request = AF.request(url)
        request.responseDecodable(of: Products.self) { (data) in
            print("we are in HomeDataMethod")
            print(data.data?.count)
            print(data)
            guard let newdata = data.value else{
                completion(nil)
                return
            }
            
            completion(newdata)
        }
    }
}

extension NetworkService : MenDataProtocol{
    static func getMenData(url: URL, completion: @escaping (Products?) -> Void) {
        let request = AF.request(url)
        request.responseDecodable(of: Products.self) { (data) in
            guard let newdata = data.value else{
                completion(nil)
                return
            }
            
            completion(newdata)
        }
    }
}

extension NetworkService : WomenDataProtocol{
    static func getWomenData(url: URL, completion: @escaping (Products?) -> Void) {
        let request = AF.request(url)
        request.responseDecodable(of: Products.self) { (data) in
            guard let newdata = data.value else{
                completion(nil)
                return
            }
            
            completion(newdata)
        }
    }
}

extension NetworkService : KidsDataProtocol{
    static func getKidsData(url: URL, completion: @escaping (Products?) -> Void) {
        let request = AF.request(url)
        request.responseDecodable(of: Products.self) { (data) in
            guard let newdata = data.value else{
                completion(nil)
                return
            }
            
            completion(newdata)
        }
    }
}

extension NetworkService : SaleDataProtocol{
    static func getSaleData(url: URL, completion: @escaping (Products?) -> Void) {
        let request = AF.request(url)
        request.responseDecodable(of: Products.self) { (data) in
            guard let newdata = data.value else{
                completion(nil)
                return
            }
            
            completion(newdata)
        }
    }
    
    
}

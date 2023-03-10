//
//  NetworkService.swift
//  Shopify
//
//  Created by Mahmoud on 25/02/2023.
//

import Foundation
import Alamofire
class NetworkService : BrandsData{
    static var base_url = "https://48c475a06d64f3aec1289f7559115a55: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@ios-q2-new-capital-admin2-2022-2023.myshopify.com/admin/api/2023-01/"
    static var baseUrl = "48c475a06d64f3aec1289f7559115a55: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@ios-q2-new-capital-admin2-2022-2023"
    //    static var bindingBrands: (() -> ()) = {}
    //    static var brandData: [Brand] = []
    static func fetch<T : Decodable>(url : URL?,compiletionHandler : @escaping(T?) -> Void){
        AF.request(url!).validate().responseDecodable(of: T.self){
            data in
            //print("pirnt here data to test")
            //print(data.value )
            guard let data = data.value else{
                compiletionHandler(nil)
                return
                
            }
            compiletionHandler(data)
        }
        
    }
  
}


extension NetworkService : ProductsDataProtocol{
    static func getProductsData(url: URL, completion: @escaping (Products?) -> Void) {
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
extension NetworkService : DiscountsData
 {
    static func getDiscountCodes(url: String, handeler: @escaping (DiscountCodes?) -> Void)
    {
        let request = AF.request(url)
        request.responseDecodable (of: DiscountCodes.self) {(olddata) in
            guard let data = olddata.value
            else{
                handeler(nil)
                return
            }
            handeler(data)
        }
    }
}
extension NetworkService : ShoppingCartData
{
    static func getShoppingCartProducts(url: String, handeler: @escaping (DraftOrders?) -> Void)
    {
        let request = AF.request(url)
        request.responseDecodable (of: DraftOrders.self) {(olddata) in
            guard let data = olddata.value
            else{
                handeler(nil)
                return
            }
            handeler(data)
        }
    }
}
extension NetworkService
{
    static func postShoppingCartProduct(cartProduct :Product){
        guard let url = URL(string: "https://48c475a06d64f3aec1289f7559115a55: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@ios-q2-new-capital-admin2-2022-2023.myshopify.com/admin/api/2023-01/draft_orders.json") else{
                return
            }
            var request = URLRequest(url :url)
            request.httpMethod = "POST"
            
            request.httpShouldHandleCookies = false
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            let body : [String : Any] = [
                "draft_order": [
                    "line_items": [
                            [
                            "title": cartProduct.title ?? "",
                            "price": cartProduct.variants?[0].price ?? "",
                            "quantity": 1,
                            "product_id" : cartProduct.id ?? 0
                            ]
                        ],
                        "applied_discount" : [
                        "description": "Custom discount",
                        "value_type": "fixed_amount",
                        "value": "10.0",
                        "amount": "10.00",
                        "title": "Custom"
                        ],
                    "customer": [
                        "id": 6817112686896
                        ],
                    "use_customer_default_address": true
                ]
            ]
            request.httpBody = try? JSONSerialization.data(withJSONObject: body,options: .fragmentsAllowed)
            
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                guard let data = data else{
                    return
                }
                do{
                    print("success\(response)")
                }
                catch{
                }
            }
            task.resume()
        }
    }


//extension NetworkService : PostApi
//{
//    static func makePostRequest(url: URL, newData: [String : Any],complition: @escaping (Result<Data, Error>) -> Void) {
//        guard let url = URL(string: url) else{
//            return
//        }
//        print("Making api call")
//        
//        var request = URLRequest(url: url)
//        request.httpMethod = "POST"
//        request.httpShouldHandleCookies = false
//        request.addValue("application/json",forHTTPHeaderField: "Content-Type")
//        request.addValue("application/json",forHTTPHeaderField: "Authorization")
//        request.addValue("application/json",forHTTPHeaderField: "Accept")
//     
//       
//        request.httpBody = try? JSONSerialization.data(withJSONObject: newData, options: .prettyPrinted)
//        
//        let task = URLSession.shared.dataTask(with: request) { data, _, error in
//            guard let data = data, error ==  nil else{
//                
//                return
//            }
//            
//            do{
//                let response =  try JSONSerialization.jsonObject(with: data , options:  .allowFragments)
//                print("SUCCSESS\(response)")
//                complition(.success(data))
//               
//                
//            }catch{
//                complition(.failure(error))
//                
//                print(error)
//            }
//            
//            
//        }
//        task.resume()
//    }
//    
//    }
//    



extension NetworkService : GenericCRUDProtocol{
  static  func updateDate(parameter: [String : Any], urlEndPoint: String) {

      guard let url = URL(string: urlEndPoint ) else {return}
      print(url)
      var request = URLRequest(url:url)
      request.httpMethod = "POST"
      request.httpShouldHandleCookies = false
      let session = URLSession.shared

      do {
          
          request.httpBody = try JSONSerialization.data(withJSONObject: parameter , options: .prettyPrinted)
          
      } catch let error {
          print(error.localizedDescription)
      }
      
      request.addValue("application/json", forHTTPHeaderField: "Content-Type")
      request.addValue("application/json", forHTTPHeaderField: "Accept")
      
      session.dataTask(with: request) {(data, response, error)in
          if let response = response as? HTTPURLResponse {
              print(response.statusCode)
          }
          if error != nil {
              print(error!)
          } else {
             
              if let data = data {
                  print (data)
                  print(response!)
              }
              
          }
      }.resume()
    }
    
 static func deleteData(urlEndPoint: String) {
        
    }
    
  static func postData( urlEndPoint: URL,parameter: [String : Any],complition :  @escaping (Result<Data, Error>) -> Void) {
//        guard let url = URL(string: urlEndPoint) else{
//            return
//        }
        var request = URLRequest(url: urlEndPoint)
        request.httpMethod = "POST"
        request.httpShouldHandleCookies = false
        let session = URLSession.shared
        do{
            request.httpBody = try? JSONSerialization.data(withJSONObject: parameter,options: .prettyPrinted)
            
        }catch let error {
            print(error.localizedDescription)
        }
      request.addValue("application/json",forHTTPHeaderField: "Content-Type")
      request.addValue("application/json",forHTTPHeaderField: "Authorization")
      request.addValue("application/json",forHTTPHeaderField: "Accept")
   
        session.dataTask(with: request) { data,response, error in
            guard let data = data, error ==  nil else{
                
                return
            }
            do{
                let response =  try JSONSerialization.jsonObject(with: data , options:  .allowFragments)
                print("SUCCSESS\(response)")
                complition(.success(data))
               
                
            }catch{
                complition(.failure(error))
                
                print(error)
            }
                
        }.resume()
    }
    
    
}

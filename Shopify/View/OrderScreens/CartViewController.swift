//
//  CartViewController.swift
//  Shopify
//
//  Created by Mahmoud on 21/02/2023.
//

import UIKit
import CoreData
import Reachability

class CartViewController: UIViewController {
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var cartViewModel : NetworkViewModel?
    var tempCartItemsList : [DraftOrder]?
    var shoppingCartItemsList : [DraftOrder]?
    var shoppingCartItemsListCoreData : [NSManagedObject]?
    var total : Float = 0.0
    var cartItemSubTotal : Float = 0.0
    var flag : Bool = false
    @IBOutlet weak var shoppingCartFrame: UIView!
    @IBOutlet weak var subTotal: UILabel!
    @IBOutlet weak var shoppingCartCollectionView: UICollectionView!
    {
        didSet
        {
            shoppingCartCollectionView.dataSource = self
            shoppingCartCollectionView.delegate = self
            let nib = UINib(nibName: "ShoppingCartCell", bundle: nil)
            shoppingCartCollectionView.register(nib, forCellWithReuseIdentifier: "shoppingCartCell")
        }
    }
    @IBOutlet weak var checkout: UIButton!
    @IBAction func proceedToCheckout(_ sender: Any) {
        let orderDetailsVC = storyboard?.instantiateViewController(withIdentifier: "orderDetails") as! OrderDetailsViewController
        navigationController?.pushViewController(orderDetailsVC, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let isConn = Reachability.forInternetConnection()
        if ((isConn?.isReachableViaWiFi()) != nil)
        {
            flag = true
        }
        else
        {
            flag = false
        }
        
      //  Swift.print(TabBarViewController.loggedCustomer!.id)
        cartVCStyle()
        cartViewModel = NetworkViewModel()
        cartViewModel?.getCartProducts()
        cartViewModel?.bindingCartProducts = {
            DispatchQueue.main.async { [self] in
                self.shoppingCartItemsList = self.cartViewModel?.ShoppingCartProductsResult ?? []
                self.tempCartItemsList = self.cartViewModel?.ShoppingCartProductsResult ?? []
                // self.shoppingCartItemsList = self.tempCartItemsList?.filter { ($0.customer?.id) == TabBarViewController.loggedCustomer!.id }
                for item in tempCartItemsList!{
                    if item.customer!.id == TabBarViewController.loggedCustomer?.id{
                        shoppingCartItemsList?.append(item)
                    }
                }
                for i in 0..<shoppingCartItemsList!.count{
                 total += (Float((shoppingCartItemsList![i].line_items![0].price)!)! * Float((shoppingCartItemsList![i].line_items![0].quantity)!))
                 }
                 self.subTotal.text = String(total).appending(shoppingCartItemsList?[0].currency ?? "")
                self.shoppingCartCollectionView.reloadData()
                
                if    flag == true
                {
                    for i in 0..<(self.shoppingCartItemsList?.count ?? 0)
                    {
                        DataServices.save(draftproduct: shoppingCartItemsList![i], appDelegate: appDelegate)
                    }
                }
                else
                {
                    shoppingCartItemsListCoreData = DataServices.fetch(appDelegate: appDelegate)
                }
            }
        }
    }

    
    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
extension CartViewController : UICollectionViewDataSource,UICollectionViewDelegate
{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if flag == true
        {
            return shoppingCartItemsList?.count ?? 0
        }
        else
        {
            return shoppingCartItemsListCoreData?.count ?? 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "shoppingCartCell", for: indexPath) as! ShoppingCartCell
       // StyleHelper.cvCellStyle(cvCell: cell)
        
        if flag == true
        {
            cell.layer.masksToBounds = true
            cell.layer.cornerRadius = 30
            cell.cartProductImage.image = UIImage(named: "product")
            cell.cartProductName.text = shoppingCartItemsList?[indexPath.row].line_items?[0].title
            cell.cartProductDescription.text = shoppingCartItemsList?[indexPath.row].line_items?[0].vendor
            cell.cartProductPrice.text = (shoppingCartItemsList?[indexPath.row].line_items?[0].price)?.appending(" ").appending(shoppingCartItemsList?[indexPath.row].currency ?? "")
            cell.cartProductsCount.text = String((shoppingCartItemsList?[indexPath.row].line_items?[0].quantity)!)
            let quantity = Float(shoppingCartItemsList?[indexPath.row].line_items?[0].quantity ?? 0)
            let price = Float(shoppingCartItemsList?[indexPath.row].line_items?[0].price ?? "")
            cell.cartProductSuTotalPrice.text = String(quantity * price!).appending(" ").appending(shoppingCartItemsList?[indexPath.row].currency ?? "")
            cell.cartProductsCount.layer.masksToBounds = true
            cell.cartProductsCount.layer.cornerRadius = 12
            cell.deleteCartProduct.tag = indexPath.row
            cell.increaseProductItemCount.tag = indexPath.row
            cell.decreaseProductItemCount.tag = indexPath.row
            cell.increaseProductItemCount.addTarget(self, action: #selector(increaseProductsCount(sender:)), for: .touchUpInside)
            cell.decreaseProductItemCount.addTarget(self, action: #selector(decreaseProductsCount(sender:)), for: .touchUpInside)
            cell.deleteCartProduct.addTarget(self, action: #selector(print(sender: )), for: .touchUpInside)
            cell.cartCellBackView.layer.cornerRadius = 20
            cell.cartCellBackView.backgroundColor = .white
            cell.cartCellBackView.layer.shadowRadius = 3
            cell.cartCellBackView.layer.shadowOpacity = 0.5
            cell.cartCellBackView.layer.shadowOffset = CGSize(width: 5, height: 5)
        }
        else
        {
            cell.layer.masksToBounds = true
            cell.layer.cornerRadius = 30
            cell.cartProductImage.image = UIImage(named: "product")
            cell.cartProductName.text = shoppingCartItemsListCoreData?[indexPath.row].value(forKey: "product_title") as? String
      //      cell.cartProductDescription.text = shoppingCartItemsList?[indexPath.row].line_items?[0].vendor
         //   cell.cartProductPrice.text = (shoppingCartItemsListCoreData?[indexPath.row].value(forKey: "product_price")).appending(" ").appending(shoppingCartItemsListCoreData?[indexPath.row].value(forKey: "product_currency") ?? "")
            cell.cartProductsCount.text = (shoppingCartItemsListCoreData?[indexPath.row].value(forKey: "product_quantity"))! as? String
          //  let quantity = Float(shoppingCartItemsList?[indexPath.row].line_items?[0].quantity ?? 0)
           // let price = Float(shoppingCartItemsList?[indexPath.row].line_items?[0].price ?? "")
          //  cell.cartProductSuTotalPrice.text = String(quantity * price!).appending(" ").appending(shoppingCartItemsList?[indexPath.row].currency ?? "")
            
            cell.cartProductsCount.layer.masksToBounds = true
            cell.cartProductsCount.layer.cornerRadius = 12
            cell.cartCellBackView.layer.cornerRadius = 20
            cell.cartCellBackView.backgroundColor = .white
            cell.cartCellBackView.layer.shadowRadius = 3
            cell.cartCellBackView.layer.shadowOpacity = 0.5
            cell.cartCellBackView.layer.shadowOffset = CGSize(width: 5, height: 5)
        }
        return cell
        
        
    }
}

extension CartViewController : UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: shoppingCartCollectionView.layer.bounds.size.width-5,height: (shoppingCartCollectionView.layer.bounds.size.height/2.2)-30)
    }
}
extension CartViewController
{
    @objc func print(sender : UIButton)
    {
        let idd = shoppingCartItemsList?[sender.tag].id ?? 0
        
            let deleteAlert : UIAlertController  = UIAlertController(title:"Delete this product?", message:"Are you sure you want to delete this product?", preferredStyle: .actionSheet)
            deleteAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler:{ action in
                self.delete(id: idd)
               // total -= Float(shoppingCartItemsList?[sender.tag].line_items?[0].price ?? "" ) ?? 0.0 * Float(shoppingCartItemsList?[sender.tag].line_items?[0].quantity ?? 0) ?? 0.0
                   //   subTotal.text = String(total)
                      self.shoppingCartItemsList?.remove(at: sender.tag)
                      self.shoppingCartCollectionView.reloadData()
            }))
            deleteAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            self.present(deleteAlert, animated:true, completion:nil )
    }
}

extension CartViewController
{
    @objc func increaseProductsCount(sender : UIButton)
    {
        if  (shoppingCartItemsList?[sender.tag].line_items?[0].quantity)! < 20
        {
            let idd = (shoppingCartItemsList?[sender.tag].id)!
            guard let url = URL(string: "https://48c475a06d64f3aec1289f7559115a55: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@ios-q2-new-capital-admin2-2022-2023.myshopify.com/admin/api/2023-01/draft_orders/\(idd).json") else{
                return
            }
            var request = URLRequest(url :url)
            request.httpMethod = "PUT"
            request.httpShouldHandleCookies = false
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            let body : [String : Any] = [
                "draft_order": [
                    "line_items": [
                            [
                                "title": shoppingCartItemsList?[sender.tag].line_items?[0].title ?? "",
                            "price": shoppingCartItemsList?[sender.tag].line_items?[0].price ?? "",
                            "quantity": ((shoppingCartItemsList?[sender.tag].line_items?[0].quantity)! + 1)
                            ]
                        ],
                    "applied_discount": [
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
                    Swift.print("success\(response)")
                }
                catch{
                }
            }
            task.resume()
        }
        else
         {
         shoppingCartItemsList?[sender.tag].line_items?[0].quantity = 20
         }
        total += Float(shoppingCartItemsList?[sender.tag].line_items?[0].price ?? "") ?? 0.0
        
        cartItemSubTotal = Float((shoppingCartItemsList?[sender.tag].line_items?[0].quantity)!) * Float((shoppingCartItemsList?[sender.tag].line_items?[0].price)!)!
         subTotal.text = String(total )
         self.shoppingCartCollectionView.reloadData()
         }
         
         @objc func decreaseProductsCount(sender : UIButton)
         {
         if (shoppingCartItemsList?[sender.tag].line_items?[0].quantity)! > 1
         {
             let idd = (shoppingCartItemsList?[sender.tag].id)!
             guard let url = URL(string: "https://48c475a06d64f3aec1289f7559115a55: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@ios-q2-new-capital-admin2-2022-2023.myshopify.com/admin/api/2023-01/draft_orders/\(idd).json") else{
                 return
             }
             var request = URLRequest(url :url)
             request.httpMethod = "PUT"
             request.httpShouldHandleCookies = false
             request.addValue("application/json", forHTTPHeaderField: "Content-Type")
             let body : [String : Any] = [
                 "draft_order": [
                     "line_items": [
                             [
                             "title": "EDITED",
                             "price": "90.00",
                             "quantity": ((shoppingCartItemsList?[sender.tag].line_items?[0].quantity)! - 1)
                             //"vendor" : "Adidas"
                             ]
                         ],
                     "applied_discount": [
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
                     Swift.print("success\(response)")
                 }
                 catch{
                 }
             }
             task.resume()         }
         else
         {
             delete(id: sender.tag)
         }
        total -= Float(shoppingCartItemsList?[sender.tag].line_items?[0].price ?? "") ?? 0.0
             cartItemSubTotal = Float((shoppingCartItemsList?[sender.tag].line_items?[0].quantity)!) * Float((shoppingCartItemsList?[sender.tag].line_items?[0].price)!)!
              subTotal.text = String(total)
              self.shoppingCartCollectionView.reloadData()
       //       self.shoppingCartCollectionView.deleteItems(at: [IndexPath(row: 0, section: 0)])
         }
}

extension CartViewController
{
    func cartVCStyle()
    {
        StyleHelper.bgFrameStyle(frame: shoppingCartFrame)
        self.shoppingCartCollectionView.backgroundColor = UIColor(named: "thirdColor")
        self.subTotal.layer.masksToBounds = true
        self.subTotal.layer.cornerRadius = 20
        self.subTotal.bringSubviewToFront(checkout)
        self.subTotal.layer.shadowRadius = 6.0
        self.subTotal.layer.shadowOpacity = 1.0
        self.subTotal.layer.shadowColor = UIColor.red.cgColor
        self.subTotal.layer.shadowOffset = CGSize(width: 4.0, height: 4.0)
    }
}
extension CartViewController
{
    func delete(id : Int)
    {
        guard let url = URL(string: "https://48c475a06d64f3aec1289f7559115a55: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@ios-q2-new-capital-admin2-2022-2023.myshopify.com/admin/api/2023-01/draft_orders/\(id).json") else{
            return
        }
        var request = URLRequest(url :url)
        request.httpMethod = "DELETE"
        request.httpShouldHandleCookies = false
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else{
                return
            }
            do{
                Swift.print("success\(response)")
            }
            catch{
            }
        }
        task.resume()
        Swift.print("fatma\(id)")
    }
}

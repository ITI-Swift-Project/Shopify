//
//  CartViewController.swift
//  Shopify
//
//  Created by Mahmoud on 21/02/2023.
//

import UIKit
import CoreData
import Reachability
import Kingfisher

class CartViewController: UIViewController {
    var dataViewModel : CoreDataViewModel?
    var cartViewModel : NetworkViewModel?
    var tempCartItemsList : [DraftOrder]?
    var shoppingCartItemsList : [DraftOrder]?
    var shoppingCartItemsListCoreData : [NSManagedObject]?
    var total : Float = 0.0
    var cartItemSubTotal : Float = 0.0
    var flag : Bool = false
    var reachability : Reachability?
    @IBOutlet weak var shoppingCartFrame: UIView!
    @IBOutlet weak var subTotal: UILabel!
    
    
    @IBOutlet weak var shoppingCartTableView: UITableView!{
        
            didSet
        {
            shoppingCartTableView.dataSource = self
            shoppingCartTableView.delegate = self
            let nib = UINib(nibName: "ShoppingCartTableCell", bundle: nil)
            shoppingCartTableView.register(nib, forCellReuseIdentifier: "shoppingCartCell")
        }
    }
    
    @IBOutlet weak var checkout: UIButton!
    @IBAction func proceedToCheckout(_ sender: Any) {
        let orderDetailsVC = storyboard?.instantiateViewController(withIdentifier: "orderDetails") as! OrderDetailsViewController
        orderDetailsVC.orderProductsList = shoppingCartItemsList
        orderDetailsVC.orderSubTotal = total
        navigationController?.pushViewController(orderDetailsVC, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cartVCStyle()
        dataViewModel = CoreDataViewModel()
        cartViewModel = NetworkViewModel()
        cartViewModel?.getCartProducts()
        cartViewModel?.bindingCartProducts = {
            DispatchQueue.main.async { [self] in
                self.shoppingCartItemsList = self.cartViewModel?.ShoppingCartProductsResult ?? []
                self.tempCartItemsList = self.cartViewModel?.ShoppingCartProductsResult ?? []
                // self.shoppingCartItemsList = self.tempCartItemsList?.filter { ($0.customer?.id) == TabBarViewController.loggedCustomer!.id }
       /*         for item in tempCartItemsList!{
                    if item.customer!.id == TabBarViewController.loggedCustomer?.id{
                        shoppingCartItemsList?.append(item)
                    }
                }*/
                for i in 0..<shoppingCartItemsList!.count{
                 total += (Float((shoppingCartItemsList![i].line_items![0].price)!)! * Float((shoppingCartItemsList![i].line_items![0].quantity)!))
                 }
                 self.subTotal.text = String(total).appending(shoppingCartItemsList?[0].currency ?? "")
                self.shoppingCartTableView.reloadData()
                
            }
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        reachability = Reachability.forInternetConnection()
        if ((reachability!.isReachable()) )
        {
            flag = true
        }
        else
        {
            flag = false
            shoppingCartItemsListCoreData = dataViewModel?.fetchProductsFromCoreData(productType: 1)
        }
        self.shoppingCartTableView.reloadData()
    }
    
    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
extension CartViewController : UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if flag == true
        {
            return shoppingCartItemsList?.count ?? 0
        }
        else
        {
            return shoppingCartItemsListCoreData?.count ?? 0
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "shoppingCartCell", for: indexPath) as! ShoppingCartTableCell
        
        if flag == true
        {
            cell.layer.masksToBounds = true
            cell.layer.cornerRadius = 30
            cell.cartProductImage.image = UIImage(named: "product")
            cell.cartProductName.text = shoppingCartItemsList?[indexPath.row].line_items?[0].title
            cell.cartProductDescription.text = shoppingCartItemsList?[indexPath.row].line_items?[0].vendor
            cell.cartProductPrice.text = (shoppingCartItemsList?[indexPath.row].line_items?[0].price)?.appending(" ").appending(shoppingCartItemsList?[indexPath.row].currency ?? "")
            cell.cartProductsCount.text = String((shoppingCartItemsList?[indexPath.row].line_items?[0].quantity ?? 0))
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
        else if flag == false
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
extension CartViewController : UITableViewDelegate
{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 190
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if  editingStyle == .delete
        {
            let idd = shoppingCartItemsList?[indexPath.row].id ?? 0
                let deleteAlert : UIAlertController  = UIAlertController(title:"Delete this product?", message:"Are you sure you want to delete this product?", preferredStyle: .actionSheet)
                deleteAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler:{ action in
                    self.delete(id: idd)
                    self.total -= Float(self.shoppingCartItemsList?[indexPath.row].line_items?[0].price ?? "" ) ?? 0.0 * Float(self.shoppingCartItemsList?[indexPath.row].line_items?[0].quantity ?? 0) ?? 0.0
                    self.subTotal.text = String(self.total).appending(self.shoppingCartItemsList?[indexPath.row].currency ?? "")
                          self.shoppingCartItemsList?.remove(at: indexPath.row)
                          self.shoppingCartTableView.reloadData()
                }))
                deleteAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
                self.present(deleteAlert, animated:true, completion:nil )
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
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
                self.total -= Float(self.shoppingCartItemsList?[sender.tag].line_items?[0].price ?? "" ) ?? 0.0 * Float(self.shoppingCartItemsList?[sender.tag].line_items?[0].quantity ?? 0) ?? 0.0
                self.subTotal.text = String(self.total).appending(self.shoppingCartItemsList?[sender.tag].currency ?? "")
                      self.shoppingCartItemsList?.remove(at: sender.tag)
                      self.shoppingCartTableView.reloadData()
               // dataViewModel?.deleteProductFromCoreData(deletedProductType: 2, productId: <#T##Int#>)
              
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
            self.shoppingCartItemsList?[sender.tag].line_items?[0].quantity =             (self.shoppingCartItemsList?[sender.tag].line_items?[0].quantity)! + 1
            
           total += Float(shoppingCartItemsList?[sender.tag].line_items?[0].price ?? "") ?? 0.0
           cartItemSubTotal = Float((shoppingCartItemsList?[sender.tag].line_items?[0].quantity)!) * Float((shoppingCartItemsList?[sender.tag].line_items?[0].price)!)!
            
            self.shoppingCartTableView.reloadData()

        }
        else
         {
         shoppingCartItemsList?[sender.tag].line_items?[0].quantity = 20
         }
         subTotal.text = String(total ).appending(shoppingCartItemsList?[sender.tag].currency ?? "")
         self.shoppingCartTableView.reloadData()
         }
         
    
         @objc func decreaseProductsCount(sender : UIButton)
         {
             let idd = (shoppingCartItemsList?[sender.tag].id)!

         if (shoppingCartItemsList?[sender.tag].line_items?[0].quantity)! > 1
         {
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
                             "quantity": ((shoppingCartItemsList?[sender.tag].line_items?[0].quantity)! - 1)
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
             self.shoppingCartItemsList?[sender.tag].line_items?[0].quantity =             (self.shoppingCartItemsList?[sender.tag].line_items?[0].quantity)! - 1
             
             total -= Float(shoppingCartItemsList?[sender.tag].line_items?[0].price ?? "") ?? 0.0
                  cartItemSubTotal = Float((shoppingCartItemsList?[sender.tag].line_items?[0].quantity)!) * Float((shoppingCartItemsList?[sender.tag].line_items?[0].price)!)!
             self.shoppingCartTableView.reloadData()
         }
         else
         {
        }
              subTotal.text = String(total).appending(shoppingCartItemsList?[sender.tag].currency ?? "")
              self.shoppingCartTableView.reloadData()
         }
}

extension CartViewController
{
    func cartVCStyle()
    {
        StyleHelper.bgFrameStyle(frame: shoppingCartFrame)
        self.shoppingCartTableView.backgroundColor = UIColor(named: "thirdColor")
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

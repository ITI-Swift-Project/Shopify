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
    
    let group = DispatchGroup()
    let semaphore = DispatchSemaphore(value: 0)
    var dataViewModel : CoreDataViewModel?
    var networkViewModel : ShoppingCartProductsViewModel?
    var productViewModel : ProductViewModel?
    var arrayOfDec : [[String : Any]] = []
    var shoppingCartItemsList : [LineItem] = []
    var shoppingCartItemsListCoreData : [NSManagedObject]?
    var total : Float = 0.0
    var cartItemSubTotal : Float = 0.0
    var flag : Bool = false
    var reachability : Reachability?
    var product : Product = Product()
    var productsArr : [Product] = []
    
    var productId : Int = 0
    var productsImages : [Image] = []
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
        orderDetailsVC.orderImages = productsImages
        navigationController?.pushViewController(orderDetailsVC, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cartVCStyle()
            self.dataViewModel = CoreDataViewModel()
            self.productViewModel = ProductViewModel()
            self.networkViewModel = ShoppingCartProductsViewModel()
            self.workingWithDispatchGroup()
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
            return shoppingCartItemsList.count
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
            for item in productsArr
            {
                if shoppingCartItemsList[indexPath.row].product_id == item.id
                {
                    cell.cartProductImage.kf.setImage(with: URL(string: item.image?.src ?? ""),placeholder: UIImage(named: " "))
                    productsImages.append(item.image!)
                }
            }
            cell.cartProductName.text = shoppingCartItemsList[indexPath.row].title
            cell.cartProductDescription.text = shoppingCartItemsList[indexPath.row].title
            cell.cartProductPrice.text = (shoppingCartItemsList[indexPath.row].price)?.appending(" ")//.appending(shoppingCartItemsList?[indexPath.row].currency ?? "")
            cell.cartProductsCount.text = String((shoppingCartItemsList[indexPath.row].quantity ?? 0))
            let quantity = Float(shoppingCartItemsList[indexPath.row].quantity ?? 0)
            let price = Float(shoppingCartItemsList[indexPath.row].price ?? "")
            cell.cartProductSuTotalPrice.text = String(quantity * price!).appending(" ")//.appending(shoppingCartItemsList?[indexPath.row].currency ?? "")
            cell.deleteCartProduct.tag = indexPath.row
            cell.increaseProductItemCount.tag = indexPath.row
            cell.decreaseProductItemCount.tag = indexPath.row
            cell.increaseProductItemCount.addTarget(self, action: #selector(increaseProductsCount(sender:)), for: .touchUpInside)
            cell.decreaseProductItemCount.addTarget(self, action: #selector(decreaseProductsCount(sender:)), for: .touchUpInside)
            cell.deleteCartProduct.addTarget(self, action: #selector(deleteCartProduct(sender: )), for: .touchUpInside)
        }
        else if flag == false
        {
            cell.layer.masksToBounds = true
            cell.layer.cornerRadius = 30
            cell.cartProductImage.image = UIImage(named: "product")
            cell.cartProductName.text = shoppingCartItemsListCoreData?[indexPath.row].value(forKey: "product_title") as? String
            //   cell.cartProductPrice.text = (shoppingCartItemsListCoreData?[indexPath.row].value(forKey: "product_price")).appending(" ").appending(shoppingCartItemsListCoreData?[indexPath.row].value(forKey: "product_currency") ?? "")
            cell.cartProductsCount.text = (shoppingCartItemsListCoreData?[indexPath.row].value(forKey: "product_quantity"))! as? String
            //  let quantity = Float(shoppingCartItemsList?[indexPath.row].line_items?[0].quantity ?? 0)
            // let price = Float(shoppingCartItemsList?[indexPath.row].line_items?[0].price ?? "")
            //  cell.cartProductSuTotalPrice.text = String(quantity * price!).appending(" ").appending(shoppingCartItemsList?[indexPath.row].currency ?? "")
        }
        cell.cartProductsCount.layer.masksToBounds = true
        cell.cartProductsCount.layer.cornerRadius = 12
        cell.cartCellBackView.layer.cornerRadius = 20
        cell.cartCellBackView.backgroundColor = .white
        cell.cartCellBackView.layer.shadowRadius = 3
        cell.cartCellBackView.layer.shadowOpacity = 0.5
        cell.cartCellBackView.layer.shadowOffset = CGSize(width: 5, height: 5)
        
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
                let deleteAlert : UIAlertController  = UIAlertController(title:"Delete this product?", message:"Are you sure you want to delete this product?", preferredStyle: .actionSheet)
                deleteAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler:{ action in

              
                    //self.delete(index: indexPath.row)
                 //   self.total -= Float(self.shoppingCartItemsList[indexPath.row].price ?? "" ) ?? 0.0 * Float(self.shoppingCartItemsList[indexPath.row].quantity ?? 0)
                 //   self.subTotal.text = String(self.total)//.appending(self.shoppingCartItemsList?[indexPath.row].currency ?? "")
                         // self.shoppingCartItemsList.remove(at: indexPath.row)
                          self.shoppingCartTableView.reloadData()
                }))
                deleteAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
                self.present(deleteAlert, animated:true, completion:nil )
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "HomeStoryboard", bundle: nil)
        let productDetailsVC = storyBoard.instantiateViewController(withIdentifier: "productDetails") as? ProductDetailsViewController
        for item in productsArr
        {
            if shoppingCartItemsList[indexPath.row].product_id == item.id
            {
                productDetailsVC?.product = item
            }
        }
        
        navigationController?.pushViewController(productDetailsVC!, animated: true)
    }
}
extension CartViewController
{
    @objc func deleteCartProduct(sender : UIButton)
    {
        
            let deleteAlert : UIAlertController  = UIAlertController(title:"Delete this product?", message:"Are you sure you want to delete this product?", preferredStyle: .actionSheet)
            deleteAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler:{ action in
                self.delete(index: sender.tag)
              //  self.total -= Float(self.shoppingCartItemsList[sender.tag].price ?? "" ) ?? 0.0 * Float(self.shoppingCartItemsList[sender.tag].quantity ?? 0)
              //  self.subTotal.text = String(self.total) //.appending(self.shoppingCartItemsList?[sender.tag].currency ?? "")
                   //   self.shoppingCartItemsList.remove(at: sender.tag)
                self.shoppingCartTableView.reloadData()
              //  self.dataViewModel?.deleteProductFromCoreData(deletedProductType: 2, productId: <#T##Int#>)
              
            }))
            deleteAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            self.present(deleteAlert, animated:true, completion:nil )
    }
}


extension CartViewController
{
    @objc func increaseProductsCount(sender : UIButton)
    {
        print("mahmoud\(shoppingCartItemsList.count)")
        shoppingCartItemsList[sender.tag].quantity! += 1

        /* var maxQuantity : Int = 0
         for item in productsArr
         {
            if  shoppingCartItemsList[sender.tag].product_id == item.id
             {
                maxQuantity = item.variants?[0].inventory_quantity ?? 0
                maxQuantity = Int(Float(maxQuantity) * 0.5)
            }
         }
         if  (shoppingCartItemsList[sender.tag].quantity)! <= Int(maxQuantity)
         {*/
             for item in shoppingCartItemsList
             {
                var temp : [String : Any] = ["title": item.title, "price":item.price, "quantity": item.quantity,"product_id": item.product_id, "variant_id": item.variant_id]
                arrayOfDec.append(temp)
                 }
        guard let url = URL(string: "https://48c475a06d64f3aec1289f7559115a55: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@ios-q2-new-capital-admin2-2022-2023.myshopify.com/admin/api/2023-01/draft_orders/1113759416624.json") else{
            return
        }
        var request = URLRequest(url :url)
        request.httpMethod = "PUT"
        request.httpShouldHandleCookies = false
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let body : [String : Any] = [
            "draft_order": [
                "line_items": arrayOfDec
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
        request.httpBody = try? JSONSerialization.data(withJSONObject: body,options: .fragmentsAllowed)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else{
                return
            }
            do{
                print("success\(response)")
            }
            catch let error{
                print(error.localizedDescription)
            }
        }
        task.resume()
             print("zaienb\(shoppingCartItemsList.count)")

      //  self.shoppingCartItemsList[sender.tag].quantity =             (self.shoppingCartItemsList[sender.tag].quantity)! + 1
        
       // total += Float(shoppingCartItemsList[sender.tag].price ?? "") ?? 0.0
       // cartItemSubTotal = Float((shoppingCartItemsList[sender.tag].quantity)!) * Float((shoppingCartItemsList[sender.tag].price)!)!
        
        // self.shoppingCartTableView.reloadData()
        
       /*   }
         else
         {
        // shoppingCartItemsList[sender.tag].quantity = Int(maxQuantity)
         }*/
      //   subTotal.text = String(total )//.appending(shoppingCartItemsList?[sender.tag].currency ?? "")
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
    func delete(index : Int)
    {
        shoppingCartItemsList.remove(at: index)
        for item in shoppingCartItemsList
        {
            var temp : [String : Any] = ["title": item.title, "price":item.price, "quantity": 1,"product_id": item.product_id, "variant_id": item.variant_id]
            arrayOfDec.append(temp)
        }
        guard let url = URL(string: "https://48c475a06d64f3aec1289f7559115a55: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@ios-q2-new-capital-admin2-2022-2023.myshopify.com/admin/api/2023-01/draft_orders/1113759416624.json") else{
            return
        }
        var request = URLRequest(url :url)
        request.httpMethod = "PUT"
        request.httpShouldHandleCookies = false
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let body : [String : Any] = [
            "draft_order": [
                "line_items": arrayOfDec
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
        request.httpBody = try? JSONSerialization.data(withJSONObject: body,options: .fragmentsAllowed)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else{
                return
            }
            do{
                print("success\(response)")
            }
            catch let error{
                print(error.localizedDescription)
            }
        }
        task.resume()
    }
}
extension CartViewController
{
    func workingWithDispatchGroup()
    {
        group.enter()
        self.networkViewModel?.getCartProducts(url:  "https://48c475a06d64f3aec1289f7559115a55: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@ios-q2-new-capital-admin2-2022-2023.myshopify.com/admin/api/2023-01/draft_orders/1113759416624.json")
        self.networkViewModel?.bindingCartProducts = { () in
            self.shoppingCartItemsList = self.networkViewModel?.ShoppingCartProductsResult ?? []
            Swift.print("salma\(self.shoppingCartItemsList.count)")
        }
        self.group.leave()
        
        group.enter()

        self.productViewModel?.getArrayOfProducts(url: "https://48c475a06d64f3aec1289f7559115a55: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@ios-q2-new-capital-admin2-2022-2023.myshopify.com/admin/api/2023-01/products.json")
        self.productViewModel?.bindingArrOfProducts = { () in
            self.productsArr = self.productViewModel?.arrOfProductsResult ?? []
          //  Swift.print("fatma\(self.productsArr.count)")

            self.group.leave()
            self.group.notify(queue: .main)
            {
                self.shoppingCartTableView.reloadData()
            }
        }
    }
}



















extension CartViewController
{
    @objc func decreaseProductsCount(sender : UIButton)
    {
        let idd = (shoppingCartItemsList[sender.tag].id)!
        
        if (shoppingCartItemsList[sender.tag].quantity)! > 1
        {
            guard let url = URL(string: "https://48c475a06d64f3aec1289f7559115a55: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@ios-q2-new-capital-admin2-2022-2023.myshopify.com/admin/api/2023-01/draft_orders/1113607700784.json") else{
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
                            "title": shoppingCartItemsList[sender.tag].title ?? "",
                            "price": shoppingCartItemsList[sender.tag].price ?? "",
                            "quantity": (shoppingCartItemsList[sender.tag].quantity ?? 0) - 1
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
            self.shoppingCartItemsList[sender.tag].quantity =             (self.shoppingCartItemsList[sender.tag].quantity)! - 1
            
            total -= Float(shoppingCartItemsList[sender.tag].price ?? "") ?? 0.0
            cartItemSubTotal = Float((shoppingCartItemsList[sender.tag].quantity)!) * Float((shoppingCartItemsList[sender.tag].price)!)!
            self.shoppingCartTableView.reloadData()
        }
        else
        {
        }
        subTotal.text = String(total)//.appending(shoppingCartItemsList?[sender.tag].currency ?? "")
        self.shoppingCartTableView.reloadData()
    }
}

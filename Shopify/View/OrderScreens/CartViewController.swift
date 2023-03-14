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
    var total : Float?
    var cartItemSubTotal : Float?
    var flag : Bool = false
    var reachability : Reachability?
    var product : Product = Product()
    var productsArr : [Product] = []
    var productId : Int = 0
  //  var productsImages : [Image] = []
    var userdef = UserDefaults.standard
    var currencyConverter : Float = 1
    var currency : String?
    var cartCoreDate : [NSManagedObject]?
    var coreDateViewModel : CoreDataViewModelClass!
    let refreshControl = UIRefreshControl()
    
 
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
       // orderDetailsVC.orderImages = productsImages
        orderDetailsVC.products = productsArr
        navigationController?.pushViewController(orderDetailsVC, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        shoppingCartTableView.refreshControl = refreshControl
           refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
         coreDateViewModel = CoreDataViewModelClass()
        cartCoreDate = coreDateViewModel.cartDataBase.fetchFromCart()
        cartVCStyle()
            self.dataViewModel = CoreDataViewModel()
            self.productViewModel = ProductViewModel()
            self.networkViewModel = ShoppingCartProductsViewModel()

        currencyConverter = userdef.value(forKey: "currency") as! Float
          if userdef.value(forKey: "currency") as! Double == 1.0
          {
              currency = "$"
          }
          else
          {
              currency = "£"
          }
        total = 0.0
        self.setTotalPrice()

    }
    
        @objc func refreshData(){
            shoppingCartTableView.reloadData()
            refreshControl.endRefreshing()
        }
    
    func setTotalPrice(){
        for item in cartCoreDate ?? [] {
            total = ((total ?? 0.0 ) + (item.value(forKey: "price") as? Float ?? 0) * (item.value(forKey: "quantity") as? Float ?? 0))
        }
        subTotal.text = String(total ?? 0.0)
       // subTotal.text = String((total ?? 0) * currencyConverter).appending(currency ?? "")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.shoppingCartTableView.reloadData()
       // self.setTotalPrice()
//        reachability = Reachability.forInternetConnection()
//        if ((reachability!.isReachable()) )
//        {
//            flag = true
//        }
//        else
//        {
//            flag = false
//            shoppingCartItemsListCoreData = dataViewModel?.fetchProductsFromCoreData(productType: 1)
//        }
       // self.shoppingCartTableView.reloadData()
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
        return cartCoreDate?.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "shoppingCartCell", for: indexPath) as! ShoppingCartTableCell
        
        cell.cartProductName.text = cartCoreDate?[indexPath.row].value(forKey: "title") as? String ?? ""
        cell.cartProductDescription.text = ""
        cell.cartProductsCount.text = String(cartCoreDate?[indexPath.row].value(forKey: "quantity") as? Int ?? 0)
        let quantity = Float(cartCoreDate?[indexPath.row].value(forKey: "quantity") as? Int ?? 0)
        let price = (Float(cartCoreDate?[indexPath.row].value(forKey: "price") as? String ?? "") ?? 0.0) * currencyConverter
        cell.cartProductPrice.text = cartCoreDate?[indexPath.row].value(forKey: "price") as? String ?? ""
        cell.cartProductSuTotalPrice.text = String(quantity * price).appending(" ").appending(currency ?? "")
        cell.cartProductImage.kf.setImage(with: URL(string: cartCoreDate?[indexPath.row].value(forKey: "image") as? String ?? ""),placeholder: UIImage(systemName: "photo.fill"))
        cell.deleteCartProduct.tag = indexPath.row
        cell.increaseProductItemCount.tag = indexPath.row
        cell.decreaseProductItemCount.tag = indexPath.row
        cell.increaseProductItemCount.addTarget(self, action: #selector(plusButton(_:)), for: .touchUpInside)
        cell.decreaseProductItemCount.addTarget(self, action:  #selector(minsButton(_:)), for: .touchUpInside)
        cell.deleteCartProduct.addTarget(self, action:  #selector(deleteButton(_:)), for: .touchUpInside)
        
        
        return cell
    }
    
    
    @objc func minsButton(_ sender: UIButton) {
        if cartCoreDate?[sender.tag].value(forKey: "quantity") as? Int == 1 {
            let deleteAlert : UIAlertController  = UIAlertController(title:"Delete this product?", message:"Are you sure you want to delete this product from cart ?", preferredStyle: .actionSheet)
            deleteAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler:{ action in
                self.coreDateViewModel.cartDataBase.deleteFromCart(id: self.cartCoreDate?[sender.tag].value(forKey: "id") as? Int ?? 0)
                self.cartCoreDate?.remove(at: sender.tag)
                      self.shoppingCartTableView.reloadData()
            }))
            deleteAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            self.present(deleteAlert, animated:true, completion:nil )
        }else{
            let count = (self.cartCoreDate?[sender.tag].value(forKey: "quantity") as? Int ?? 0) - 1
          
            coreDateViewModel.cartDataBase.updataQuantity(quantity: count, id: cartCoreDate?[sender.tag].value(forKey: "id") as? Int ?? 0 )
            cartCoreDate = coreDateViewModel.cartDataBase.fetchFromCart()
            total = (total ?? 0.0) - (cartCoreDate?[sender.tag].value(forKey: "price") as? Float ?? 0)
            self.shoppingCartTableView.reloadData()
        }
    }
    
    
    @objc func plusButton(_ sender: UIButton) {
        
        if (cartCoreDate?[sender.tag].value(forKey: "quantity") as? Int ?? 0) >= 2 && (cartCoreDate?[sender.tag].value(forKey: "inventory") as? Int ?? 0) - (cartCoreDate?[sender.tag].value(forKey: "quantity") as? Int ?? 0) < 2 {
            let alert : UIAlertController  = UIAlertController(title:"MaX", message:"This is the max quantity you can buy of this product", preferredStyle: .actionSheet)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self.present(alert, animated:true, completion:nil )
        }else{
            let count = (self.cartCoreDate?[sender.tag].value(forKey: "quantity") as? Int ?? 0) + 1
            coreDateViewModel.cartDataBase.updataQuantity(quantity: count, id: cartCoreDate?[sender.tag].value(forKey: "id") as? Int ?? 0 )
            cartCoreDate = coreDateViewModel.cartDataBase.fetchFromCart()
            total = (total ?? 0.0) + (cartCoreDate?[sender.tag].value(forKey: "price") as? Float ?? 0)
            self.shoppingCartTableView.reloadData()
        }
    }
    @objc func deleteButton(_ sender: UIButton) {
        let deleteAlert : UIAlertController  = UIAlertController(title:"Delete this product?", message:"Are you sure you want to delete this product from cart ?", preferredStyle: .actionSheet)
        deleteAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler:{ action in
            self.coreDateViewModel.cartDataBase.deleteFromCart(id: self.cartCoreDate?[sender.tag].value(forKey: "id") as? Int ?? 0)
            self.cartCoreDate?.remove(at: sender.tag)
                  self.shoppingCartTableView.reloadData()
        }))
        deleteAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(deleteAlert, animated:true, completion:nil )
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

                    self.coreDateViewModel.cartDataBase.deleteFromCart(id: self.cartCoreDate?[indexPath.row].value(forKey: "id") as? Int ?? 0)
                    self.cartCoreDate?.remove(at: indexPath.row)
                          self.shoppingCartTableView.reloadData()
                }))
                deleteAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
                self.present(deleteAlert, animated:true, completion:nil )
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "HomeStoryboard", bundle: nil)
        let productDetailsVC = storyBoard.instantiateViewController(withIdentifier: "productDetails") as? ProductDetailsViewController
      //  productDetailsVC?.product = cartCoreDate?[indexPath.row]
        productDetailsVC?.product.title = cartCoreDate?[indexPath.row].value(forKey: "title") as? String ?? ""
        productDetailsVC?.product.image?.src = cartCoreDate?[indexPath.row].value(forKey: "image") as? String ?? ""
        productDetailsVC?.product.vendor = cartCoreDate?[indexPath.row].value(forKey: "vendor") as? String ?? ""
        productDetailsVC?.product.variants?[0].price = cartCoreDate?[indexPath.row].value(forKey: "price") as? String ?? ""
        navigationController?.pushViewController(productDetailsVC!, animated: true)
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





//extension CartViewController
//{
//    @objc func deleteCartProduct(sender : UIButton)
//    {
//
//            let deleteAlert : UIAlertController  = UIAlertController(title:"Delete this product?", message:"Are you sure you want to delete this product?", preferredStyle: .actionSheet)
//            deleteAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler:{ action in
//                self.delete(index: sender.tag)
//              //  self.total -= Float(self.shoppingCartItemsList[sender.tag].price ?? "" ) ?? 0.0 * Float(self.shoppingCartItemsList[sender.tag].quantity ?? 0)
//              //  self.subTotal.text = String(self.total) //.appending(self.shoppingCartItemsList?[sender.tag].currency ?? "")
//                   //   self.shoppingCartItemsList.remove(at: sender.tag)
//                self.shoppingCartTableView.reloadData()
//            }))
//            deleteAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
//            self.present(deleteAlert, animated:true, completion:nil )
//    }
//}

//extension CartViewController
//{
//    func delete(index : Int)
//    {
//        shoppingCartItemsList.remove(at: index)
//        for item in shoppingCartItemsList
//        {
//            var temp : [String : Any] = ["title": item.title, "price":item.price, "quantity": item.quantity,"product_id": item.product_id, "variant_id": item.variant_id]
//            arrayOfDec.append(temp)
//        }
//        guard let url = URL(string: "https://48c475a06d64f3aec1289f7559115a55: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@ios-q2-new-capital-admin2-2022-2023.myshopify.com/admin/api/2023-01/draft_orders/1113759416624.json") else{
//            return
//        }
//        var request = URLRequest(url :url)
//        request.httpMethod = "PUT"
//        request.httpShouldHandleCookies = false
//        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
//        let body : [String : Any] = [
//            "draft_order": [
//                "line_items": arrayOfDec
//            ],
//            "applied_discount": [
//                "description": "Custom discount",
//                "value_type": "fixed_amount",
//                "value": "10.0",
//                "amount": "10.00",
//                "title": "Custom"
//            ],
//            "customer": [
//                "id": 6817112686896
//            ],
//            "use_customer_default_address": true
//        ]
//        request.httpBody = try? JSONSerialization.data(withJSONObject: body,options: .fragmentsAllowed)
//
//        let task = URLSession.shared.dataTask(with: request) { data, response, error in
//            guard let data = data else{
//                return
//            }
//            do{
//                print("success\(response)")
//            }
//            catch let error{
//                print(error.localizedDescription)
//            }
//        }
//        task.resume()
//    }
//}
//extension CartViewController
//{
//    func workingWithDispatchGroup()
//    {
//        group.enter()
//        self.networkViewModel?.getCartProducts(url:  "https://48c475a06d64f3aec1289f7559115a55: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@ios-q2-new-capital-admin2-2022-2023.myshopify.com/admin/api/2023-01/draft_orders/1113759416624.json")
//        self.networkViewModel?.bindingCartProducts = { () in
//            self.shoppingCartItemsList = self.networkViewModel?.ShoppingCartProductsResult ?? []
//            Swift.print("salma\(self.shoppingCartItemsList.count)")
//            for item in self.shoppingCartItemsList
//            {
//                self.total += Float(item.price ?? "") ?? 0.0 * Float(item.quantity ?? 0)
//            }
//            self.subTotal.text = String(self.total * self.currencyConverter).appending(self.currency ?? "")
//        }
//        self.group.leave()
//
//        group.enter()
//
//        self.productViewModel?.getArrayOfProducts(url: "https://48c475a06d64f3aec1289f7559115a55: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@ios-q2-new-capital-admin2-2022-2023.myshopify.com/admin/api/2023-01/products.json")
//        self.productViewModel?.bindingArrOfProducts = { () in
//            self.productsArr = self.productViewModel?.arrOfProductsResult ?? []
//
//            self.group.leave()
//            self.group.notify(queue: .main)
//            {
//                self.shoppingCartTableView.reloadData()
//            }
//        }
//    }
//}
//
//
//extension CartViewController
//{
//    @objc func decreaseProductsCount(sender : UIButton)
//    {
//        print("mahmoud\(shoppingCartItemsList.count)")
//        shoppingCartItemsList[sender.tag].quantity! -= 1
//
//         if  (shoppingCartItemsList[sender.tag].quantity)! > 1
//         {
//             for item in shoppingCartItemsList
//             {
//                var temp : [String : Any] = ["title": item.title, "price":item.price, "quantity": item.quantity,"product_id": item.product_id, "variant_id": item.variant_id]
//                arrayOfDec.append(temp)
//                 }
//        guard let url = URL(string: "https://48c475a06d64f3aec1289f7559115a55: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@ios-q2-new-capital-admin2-2022-2023.myshopify.com/admin/api/2023-01/draft_orders/1113759416624.json") else{
//            return
//        }
//        var request = URLRequest(url :url)
//        request.httpMethod = "PUT"
//        request.httpShouldHandleCookies = false
//        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
//        let body : [String : Any] = [
//            "draft_order": [
//                "line_items": arrayOfDec
//            ],
//            "applied_discount": [
//                "description": "Custom discount",
//                "value_type": "fixed_amount",
//                "value": "10.0",
//                "amount": "10.00",
//                "title": "Custom"
//            ],
//            "customer": [
//                "id": 6817112686896
//            ],
//            "use_customer_default_address": true
//
//        ]
//        request.httpBody = try? JSONSerialization.data(withJSONObject: body,options: .fragmentsAllowed)
//
//        let task = URLSession.shared.dataTask(with: request) { data, response, error in
//            guard let data = data else{
//                return
//            }
//            do{
//                print("success\(response)")
//            }
//            catch let error{
//                print(error.localizedDescription)
//            }
//        }
//        task.resume()
//             print("zaienb\(shoppingCartItemsList.count)")
//
//        cartItemSubTotal = Float((shoppingCartItemsList[sender.tag].quantity)!) * Float((shoppingCartItemsList[sender.tag].price)!)! * currencyConverter
//             total -= Float(shoppingCartItemsList[sender.tag].price ?? "") ?? 0.0 * currencyConverter
//             subTotal.text = String(total).appending(currency ?? "")
//         }
//        else {
//            shoppingCartItemsList[sender.tag].quantity! = 1
//        }
//         self.shoppingCartTableView.reloadData()
//    }
//}

//extension CartViewController
//{
//    @objc func increaseProductsCount(sender : UIButton)
//    {
//        print("mahmoud\(shoppingCartItemsList.count)")
//        shoppingCartItemsList[sender.tag].quantity! += 1
//
//        var maxQuantity : Int = 2
//        /* for item in productsArr
//         {
//         if  shoppingCartItemsList[sender.tag].product_id == item.id
//         {
//         maxQuantity = item.variants?[0].inventory_quantity ?? 0
//         maxQuantity = Int(Float(maxQuantity) * 0.5)
//         }
//         }*/
//        if  (shoppingCartItemsList[sender.tag].quantity)! <= Int(maxQuantity)
//        {
//            for item in shoppingCartItemsList
//            {
//                var temp : [String : Any] = ["title": item.title, "price":item.price, "quantity": item.quantity,"product_id": item.product_id, "variant_id": item.variant_id]
//                arrayOfDec.append(temp)
//            }
//            guard let url = URL(string: "https://48c475a06d64f3aec1289f7559115a55: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@ios-q2-new-capital-admin2-2022-2023.myshopify.com/admin/api/2023-01/draft_orders/1113759416624.json") else{
//                return
//            }
//            var request = URLRequest(url :url)
//            request.httpMethod = "PUT"
//            request.httpShouldHandleCookies = false
//            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
//            let body : [String : Any] = [
//                "draft_order": [
//                    "line_items": arrayOfDec
//                ],
//                "applied_discount": [
//                    "description": "Custom discount",
//                    "value_type": "fixed_amount",
//                    "value": "10.0",
//                    "amount": "10.00",
//                    "title": "Custom"
//                ],
//                "customer": [
//                    "id": 6817112686896
//                ],
//                "use_customer_default_address": true
//
//            ]
//            request.httpBody = try? JSONSerialization.data(withJSONObject: body,options: .fragmentsAllowed)
//
//            let task = URLSession.shared.dataTask(with: request) { data, response, error in
//                guard let data = data else{
//                    return
//                }
//                do{
//                    print("success\(response)")
//                }
//                catch let error{
//                    print(error.localizedDescription)
//                }
//            }
//            task.resume()
//            print("zaienb\(shoppingCartItemsList.count)")
//
//            total += Float(shoppingCartItemsList[sender.tag].price ?? "") ?? 0.0 * currencyConverter
//
//            cartItemSubTotal = Float((shoppingCartItemsList[sender.tag].quantity)!) * Float((shoppingCartItemsList[sender.tag].price)!)! * currencyConverter
//
//            /*   }
//             else
//             {
//             // shoppingCartItemsList[sender.tag].quantity = Int(maxQuantity)
//             }*/
//            subTotal.text = String(total).appending(currency ?? "")
//            self.shoppingCartTableView.reloadData()
//        }
//    }
//}

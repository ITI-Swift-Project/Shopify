//
//  WishViewController.swift
//  Shopify
//
//  Created by Mahmoud on 21/02/2023.
//

import UIKit
import CoreData

class WishViewController: UIViewController {
    var catNames  = ["dgsdg", "dgsdgsd", "dgadgadg"]
    //var networkViewModel : BrandsViewModel?
    var wishlistLineItems : [LineItem] = []
    var managedContext : NSManagedObjectContext!
    var savedLeagues : [NSManagedObject] = []
    var deleteLeague : NSManagedObject?
    
    var product : Product = Product()
    let semaphore = DispatchSemaphore(value: 0)
    var productViewModel : ProductViewModel?
    var shoppingCartItemsList : [LineItem] = []
    let group = DispatchGroup()
    var networkViewModel : ShoppingCartProductsViewModel?
    var productsArr : [Product] = []
    var dataVM : CoreDataViewModel?
    var wishListSavedProducts : [NSManagedObject] = []
 
    
    
    @IBOutlet weak var wishV: UIView!
    
    
    @IBOutlet weak var wishTV: UITableView!
    
    
    
    var  tempWishListItems : [DraftOrder]?
    var  wishListItems : DraftOrders?
    var wishVM : BrandsViewModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataVM = CoreDataViewModel()
       // self.workingWithDispatchGroup()
        
       // getData(from: "https://48c475a06d64f3aec1289f7559115a55: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@ios-q2-new-capital-admin2-2022-2023.myshopify.com/admin/api/2023-01/draft_orders.json")
        
    /*
        NetworkService.getShoppingCartProducts(url: "https://48c475a06d64f3aec1289f7559115a55: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@ios-q2-new-capital-admin2-2022-2023.myshopify.com/admin/api/2023-01/draft_orders.json") { DraftOrders in
            self.wishListItems?.draft_orders = DraftOrders
            //self.wishlistLineItems = DraftOrders
     
            self.wishTV.reloadData()
        }
    
        */
        //1
     /*   let appDelegate  = UIApplication.shared.delegate as! AppDelegate
        //2
        let context = appDelegate.persistentContainer.viewContext
        //3
        let entity = NSEntityDescription.entity(forEntityName: "ShoppingCartProduct", in: context)
        //4
        let wishlist = NSManagedObject(entity: entity!, insertInto: context)*/
        
        wishTV.delegate = self
        wishTV.dataSource = self
        let nibb = UINib(nibName: "wishTableViewCell", bundle: nil)
        wishTV.register(nibb, forCellReuseIdentifier: "list")
        self.wishV.layer.masksToBounds = true
        self.wishV.layer.cornerRadius = 25.0
        self.wishTV.backgroundColor = UIColor(named: "thirdColor")
        
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        wishListSavedProducts = dataVM?.fetchProductsFromCoreData(productType: 2) ?? []
        wishTV.reloadData()
    }
    
    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    /*
    private func getData(from url : String) -> DraftOrders
    {
       
        let task = URLSession.shared.dataTask(with: URL(string: url)!, completionHandler: { data, response, error in
            guard let data = data , error == nil else{
                Swift.print("Somthing Went Wrong")
                return
            }
            
            
            var result : DraftOrders?
            do {
                result = try JSONDecoder().decode(DraftOrders.self, from: data)
            }catch{
                Swift.print("failed to convert \(error.localizedDescription)")
            }
            guard let json = result else{
                return
            }
          //  print(json.first_name)
          //  print(json.email)
            Swift.print("doneeee")
            Swift.print(data.count)
        //  var  wishListItems = result
           // print(json.addresses)
          
        }
                                              return result
        )
        task.resume()
        
    }*/
    
    private func getData(from url : String)
    {
        guard let nurl = URL (string: url)
        else {return}
        let request = URLRequest(url : nurl)
        let task = URLSession.shared.dataTask(with: request)  { data, response, error in
            guard let data = data , error == nil else{
                Swift.print("Somthing Went Wrong")
                return
            }
            //have data
            
            do {
                self.wishListItems = try JSONDecoder().decode(DraftOrders.self, from: data)
                Swift.print(self.wishListItems)
                self.semaphore.signal()
            }catch{
                Swift.print("failed to convert \(error.localizedDescription)")
            }
            guard let json = self.wishListItems else{
                return
            }
          //  print(json.first_name)
          //  print(json.email)
            Swift.print("doneeee")
           // print(data.count)
           // print(json.addresses)
            
        }
        task.resume()
        semaphore.wait()
    }
    
}
    
    


extension WishViewController : UITableViewDelegate
{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 123
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete
        {
            dataVM?.deleteProductFromCoreData(deletedProductType: 2, productId: wishListSavedProducts[indexPath.row].value(forKey: "product_id") as? Int ?? 0 )
            wishListSavedProducts.remove(at: indexPath.row)
            wishTV.reloadData()
        }
        
    }
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    /*
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var productId = wishlistLineItems[indexPath.row].product_id ?? 0
        networkViewModel?.getSingleProduct(url: "https://48c475a06d64f3aec1289f7559115a55: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@ios-q2-new-capital-admin2-2022-2023.myshopify.com/admin/api/2023-01/products/\(productId).json")
        networkViewModel?.bindingProduct = {
            DispatchQueue.main.async { () in
                self.product = (self.networkViewModel?.productResult)!
                self.wishTV.reloadData()
                
            }
        }
        
    }
    */
}


extension WishViewController : UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        Swift.print("\(wishListItems?.draft_orders?.count ?? 0)")
        return wishListSavedProducts.count
        //wishListItems?.draft_orders?.count ?? 0
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "list", for: indexPath) as! wishTableViewCell
        cell.layer.masksToBounds = true
      //  cell.layer.cornerRadius = 25.0
        cell.layer.cornerRadius = cell.frame.size.height / 2
        
      /*  cell.wishImg.image = UIImage(named: "product")
        cell.wishName.adjustsFontSizeToFitWidth = true
        cell.wishName.text = wishListItems?.draft_orders?[indexPath.row].line_items?[0].title
        cell.wishDiscription.text = wishListItems?.draft_orders?[indexPath.row].line_items?[0].vendor
        cell.wishPrice.text = wishListItems?.draft_orders?[indexPath.row].line_items?[0].price
        */
        cell.layer.masksToBounds = true
        cell.layer.cornerRadius = 30
        cell.wishImg.kf.setImage(with: URL(string: wishListSavedProducts[indexPath.row].value(forKey: "product_image") as? String ?? ""),placeholder: UIImage(named: " "))

       //cell.wishName.adjustsFontSizeToFitWidth = true
        cell.wishName.text = wishListSavedProducts[indexPath.row].value(forKey: "product_title") as? String ?? ""
        cell.wishDiscription.text = wishListSavedProducts[indexPath.row].value(forKey: "product_vendor") as? String ?? ""
        cell.wishPrice.text = wishListSavedProducts[indexPath.row].value(forKey: "product_price") as? String ?? ""
        return cell
    }
    
    /*func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .normal, title: "delete") { action, view, completionHandeler in
            
            self.catNames.remove(at: indexPath.row)
            // self.tableView.deleteRows(at: [indexPath], with: .automatic)
            tableView.beginUpdates()
            tableView.deleteRows(at: [indexPath], with: .automatic)
            tableView.endUpdates()
            completionHandeler(true)
        }
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }*/
}/*
extension WishViewController {
    func tableView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        
            
        return CGSize(width: self.view.frame.width - 50, height: self.view.frame.height * 0.17)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets
    {
        
        
            return UIEdgeInsets(top: 0 , left: 25, bottom: 0, right: 25)
       
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat
    {
        return CGFloat(15)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat
    {
        return CGFloat(25)
    }
    
    
}
*/

extension WishViewController
{
    @objc func print()
    {
        Swift.print("Aya")
    }
}
//extension WishViewController : flowlay
struct test
{
    var img :  UIImage
    var name : String
    var price :  String
    var discrip :String
    
}
/*
extension WishViewController
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
            Swift.print("fatma\(self.productsArr.count)")

            self.group.leave()
            self.group.notify(queue: .main)
            {
                self.wishTV.reloadData()
            }
        }
    }
}*/


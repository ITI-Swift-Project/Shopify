//
//  ProfileViewController.swift
//  Shopify
//
//  Created by Mahmoud on 21/02/2023.
//

import UIKit
import CoreData
class ProfileViewController: UIViewController{
    var result : Customers?
    var customerr : allCustomers?
    var filteredOrders : [Order] = []
    var allOrders : [Order] = []
    var wishListSavedProducts : [NSManagedObject] = []
    var namee :  String?
    var dataVM : CoreDataViewModel?
    var  wishListItems : DraftOrders?
    var wishVM : BrandsViewModel?
    var coreDateViewModel : CoreDataViewModelClass!
    var viewModel : OrderViewModel?
    var wishListCoreDate : [NSManagedObject]?
    let semaphore = DispatchSemaphore(value: 0)
    
    @IBOutlet weak var wlcomeLbl: UILabel!
 
    @IBOutlet weak var ordersTableView: UITableView!{
        didSet{
            ordersTableView.delegate = self
            ordersTableView.dataSource = self
            let nib = UINib(nibName: "OrdersTableViewCell", bundle: nil)
            ordersTableView.register(nib, forCellReuseIdentifier: "orderTableCell")
        }
    }
    @IBOutlet weak var wishListTableView: UITableView!
    {
        didSet{
            wishListTableView.delegate = self
            wishListTableView.dataSource = self
            let nib = UINib(nibName: "wishTableViewCell", bundle: nil)
            wishListTableView.register(nib, forCellReuseIdentifier: "list")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
    }
    override func viewWillAppear(_ animated: Bool) {
        
    
        if !(UserDefaults.standard.value(forKey: "loginState") as? Bool ?? false)
        {
            performSegue(withIdentifier: "welcome", sender: self)
        }
        else{
            wlcomeLbl.text = "welcome \(UserDefaults.standard.string(forKey: "namee") ?? "")"
            getOrdersData()
        }
       
        
    }
    func getOrdersData(){
        
            viewModel = OrderViewModel()
            viewModel?.getOrders()
            viewModel?.bindingOrdersItems = {
                self.allOrders = self.viewModel?.ordersResult.orders ?? []
                self.coreDateViewModel = CoreDataViewModelClass()
                self.wishListCoreDate = self.coreDateViewModel.wishListDataBase.fetchFromWishList()
                if (self.allOrders.count <= 2)
                {
                    self.filteredOrders = self.allOrders
                    
                }
                else {
                    self.filteredOrders = Array(self.allOrders.prefix(2))

                }
                if(self.wishListCoreDate?.count ?? 0 > 2)
                {
                    self.wishListCoreDate = Array(self.wishListCoreDate?.prefix(2) ?? [])
                }
                self.ordersTableView.reloadData()
                self.wishListTableView.reloadData()
            }
    }
    

  
    @IBAction func openSettings(_ sender: Any) {
        let settingsVC = storyboard?.instantiateViewController(withIdentifier: "settings") as! SettingViewController
        navigationController?.pushViewController(settingsVC, animated: true)
    }
    
    @IBAction func cartAction(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "OrderStoryboard", bundle: nil)
        let cartViewController = storyBoard.instantiateViewController(withIdentifier: "shoppingCart") as! CartViewController
       
        self.navigationController?.pushViewController(cartViewController, animated: true)
    }
    
    @IBAction func ordersScreen(_ sender: Any) {
        
        let ordersVC = storyboard?.instantiateViewController(withIdentifier: "orders") as! OrdersViewController
        navigationController?.pushViewController(ordersVC, animated: true)
    }
    
    
    @IBAction func wishlistScreen(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "OrderStoryboard", bundle: nil)
        let wishlistVC = storyBoard.instantiateViewController(withIdentifier: "wishList") as! WishViewController
       
        self.navigationController?.pushViewController(wishlistVC, animated: true)
    }
    
}
extension ProfileViewController : UITableViewDelegate{
    func tableView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        return CGSize(width: self.view.frame.width - 50, height: self.view.frame.height * 0.17)
    }
  
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
}
extension ProfileViewController : UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch (tableView){
        case wishListTableView :
            return wishListCoreDate?.count ?? 0
        case ordersTableView :
            return filteredOrders.count
        default:
            return 0
            
        }
    
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell ()
        switch (tableView){
        case wishListTableView :
             let cell = tableView.dequeueReusableCell(withIdentifier: "list", for: indexPath) as! wishTableViewCell
            cell.wishImg.kf.setImage(with: URL(string: wishListCoreDate?[indexPath.row].value(forKey: "image") as? String ?? ""),placeholder: UIImage(named: " "))

           
            cell.wishName.text = wishListCoreDate?[indexPath.row].value(forKey: "title") as? String ?? ""
            cell.wishDiscription.text = wishListCoreDate?[indexPath.row].value(forKey: "vendor") as? String ?? ""
            cell.wishPrice.text = wishListCoreDate?[indexPath.row].value(forKey: "price") as? String ?? ""
            cell.layer.masksToBounds = true
            cell.layer.cornerRadius = 30
            cell.backView.layer.cornerRadius = 20
            cell.backView.backgroundColor = .white
            cell.backView.layer.shadowRadius = 3
            cell.backView.layer.shadowOpacity = 0.5
            cell.backView.layer.shadowOffset = CGSize(width: 5, height: 5)
            return cell
        case ordersTableView :
            let  cell = tableView.dequeueReusableCell(withIdentifier: "orderTableCell", for: indexPath) as! OrdersTableViewCell
            let tmpString = filteredOrders[indexPath.row].created_at?.components(separatedBy: "T")
            cell.conigData(price: filteredOrders[indexPath.row].current_total_price ?? "", date: tmpString?[0] ?? "", time: tmpString?[1] ?? "")
            cell.layer.cornerRadius = 30
            return cell
       
            
        default:
            print("wrog Tabwlw")
        }
        
        return cell
    }
    
    
}

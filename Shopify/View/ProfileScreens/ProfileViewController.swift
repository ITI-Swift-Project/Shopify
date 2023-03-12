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
    var wishListSavedProducts : [NSManagedObject] = []
    var namee :  String?
    var dataVM : CoreDataViewModel?
    var  wishListItems : DraftOrders?
    let semaphore = DispatchSemaphore(value: 0)
    @IBOutlet weak var wlcomeLbl: UILabel!
    
    
    @IBOutlet weak var orderTableView: UITableView!
    {
        didSet{
            orderTableView.delegate = self
            orderTableView.dataSource = self
            let nibb = UINib(nibName: "OrdersTableViewCell", bundle: nil)
            orderTableView.register(nibb, forCellReuseIdentifier: "orderTableCell")
        }
    }
    
    
    @IBOutlet weak var wishlistTableView: UITableView!
    {
        didSet{
           wishlistTableView.delegate = self
           wishlistTableView.dataSource = self
            let nib = UINib(nibName: "wishTableViewCell", bundle: nil)
            wishlistTableView.register(nib, forCellReuseIdentifier: "list")
        }
    }
    
    
    
    
    @IBOutlet weak var welcomelbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
   
    }
    override func viewWillAppear(_ animated: Bool) {
        
        wishListSavedProducts = dataVM?.fetchProductsFromCoreData(productType: 2) ?? []
        wishlistTableView.reloadData()
        
        namee = UserDefaults.standard.value(forKey: "namee") as? String ?? ""
        welcomelbl.text = "Welcome \(namee ?? "")"
        print(namee)
        if !(UserDefaults.standard.value(forKey: "loginState") as? Bool ?? false)
        {
            performSegue(withIdentifier: "welcome", sender: self)
        }
        else{
            //self.dismiss(animated: true, completion: nil)
        }
    }
    
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
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension ProfileViewController  : UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 123
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete
        {
            tableView.beginUpdates()
           // arrofanything.deleteRows(at: <#T##[IndexPath]#>)
           // tableView.deleteRows(at: [IndexPath], with: .fade)
            tableView.endUpdates()
        }
        
    }
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
}
extension ProfileViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return wishListSavedProducts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == orderTableView
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "orderTableCell", for: indexPath) as! OrdersTableViewCell
            cell.layer.borderColor     = UIColor.systemGray.cgColor
            cell.layer.cornerRadius    = 25.0
          /*
            let tmpString = filteredOrders[indexPath.row].created_at?.components(separatedBy: "T")
            cell.conigData(price: filteredOrders[indexPath.row].current_total_price ?? "", date: tmpString?[0] ?? "", time: tmpString?[1] ?? "")
            cell.layer.cornerRadius = 30*/
            return cell
        }
       let cell = tableView.dequeueReusableCell(withIdentifier: "list", for: indexPath) as! wishTableViewCell
        cell.layer.masksToBounds = true
        cell.layer.cornerRadius = 30
        cell.wishImg.kf.setImage(with: URL(string: wishListSavedProducts[indexPath.row].value(forKey: "product_image") as? String ?? ""),placeholder: UIImage(named: " "))

       //cell.wishName.adjustsFontSizeToFitWidth = true
        cell.wishName.text = wishListSavedProducts[indexPath.row].value(forKey: "product_title") as? String ?? ""
        cell.wishDiscription.text = wishListSavedProducts[indexPath.row].value(forKey: "product_vendor") as? String ?? ""
        cell.wishPrice.text = wishListSavedProducts[indexPath.row].value(forKey: "product_price") as? String ?? ""
        
        
       /*
        cell.layer.borderColor     = UIColor.systemGray.cgColor
        cell.layer.cornerRadius    = 25.0
        cell.wishImg.image = UIImage(named: "product")
       //cell.wishName.adjustsFontSizeToFitWidth = true
        cell.wishName.text = "aaaaaaaaaaaaaaaaaaaaaaaaaasfasmbfadk.nd.nsd,.nsdlnlsdnsd/ln"
        cell.wishDiscription.text = "sdeadfweddkghad;kghsd;kghsd;kgsd;khg"
        cell.wishPrice.text = "450" */
        return cell
        
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 150
    }
   
}


extension ProfileViewController : UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        return CGSize(width: self.view.frame.width - 50, height: self.view.frame.height * 0.17)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets
    {
            return UIEdgeInsets(top: 0 , left: 1, bottom: 0, right: 1)
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


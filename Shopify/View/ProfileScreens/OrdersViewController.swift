//
//  OrdersViewController.swift
//  Shopify
//
//  Created by Mahmoud on 21/02/2023.
//

import UIKit

class OrdersViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UIView!
    {
        didSet{
            collectionView.layer.cornerRadius = 20
            
        }
    }
    @IBOutlet weak var ordersTableView: UITableView!{
        didSet{
            ordersTableView.delegate = self
            ordersTableView.dataSource = self
            let nib = UINib(nibName: "OrdersTableViewCell", bundle: nil)
            ordersTableView.register(nib, forCellReuseIdentifier: "orderTableCell")
        }
    }

    var viewModel : OrderViewModel?
    var ordersResult : [Order] = []
    var filteredOrders : [Order] = []
    
    let cellSpacingHeight: CGFloat = 50
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = OrderViewModel()
        
        viewModel?.getOrders()
        viewModel?.bindingOrdersItems = {
            self.ordersResult = self.viewModel?.ordersResult.orders ?? []
            self.filterAccordingToCustomer()
         
            self.ordersTableView.reloadData()
//            self.ordersCollection.reloadData()
        }
       
    }
    func filterAccordingToCustomer(){
        print(UserDefaults.standard.value(forKey: "userId"))
        
        let id = UserDefaults.standard.value(forKey: "userId") as! Int
        self.filteredOrders = self.ordersResult.filter{$0.customer?.id == id}
    }
    
    //test push to solve conflect
    
    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}



extension OrdersViewController : UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
   
//    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//
//    }
}
extension OrdersViewController : UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredOrders.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "orderTableCell", for: indexPath) as! OrdersTableViewCell
        let tmpString = filteredOrders[indexPath.row].created_at?.components(separatedBy: "T")
        cell.conigData(price: filteredOrders[indexPath.row].current_total_price ?? "", date: tmpString?[0] ?? "", time: tmpString?[1] ?? "")
        cell.layer.cornerRadius = 30
        return cell
    }
    
    
}



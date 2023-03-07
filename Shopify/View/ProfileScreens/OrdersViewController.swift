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
    @IBOutlet weak var ordersCollection: UICollectionView!{
        didSet{
            ordersCollection.delegate = self
            ordersCollection.dataSource = self
            let nib = UINib(nibName: "OrdersCollectionViewCell", bundle: nil)
            ordersCollection.register(nib, forCellWithReuseIdentifier: "orderCell")
            
        }
    }
    var viewModel : NetworkViewModel?
    var ordersResult : [Order] = []
    var filteredOrders : [Order] = []
 
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = NetworkViewModel()
        viewModel?.getOrders()
        viewModel?.bindingOrdersItems = {
            self.ordersResult = self.viewModel?.ordersResult.orders ?? []
            self.filterAccordingToCustomer()
         
            self.ordersCollection.reloadData()
//            self.ordersCollection.reloadData()
        }
       
    }
    func filterAccordingToCustomer(){
        print(TabBarViewController.loggedCustomer?.id ?? 0)
        let id = TabBarViewController.loggedCustomer?.id ?? 0
        self.filteredOrders = self.ordersResult.filter{$0.customer?.id == id}
    }
    
    //test push to solve conflect
    
    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}

extension OrdersViewController : UICollectionViewDelegate{
    
}
extension OrdersViewController : UICollectionViewDataSource{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filteredOrders.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "orderCell", for: indexPath) as! OrdersCollectionViewCell
        let date_time = ordersResult[indexPath.row].created_at?.components(separatedBy: "T")
        
        
        cell.layer.borderColor  = UIColor.systemGray.cgColor
        cell.layer.cornerRadius = 25.0
        cell.priceLabel.text    = ordersResult[indexPath.row].current_total_price
        cell.dateLabel.text = date_time?[0]
        cell.timeLabel.text = date_time?[1]
        
        return cell
    }
    
    
}
extension OrdersViewController : UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
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

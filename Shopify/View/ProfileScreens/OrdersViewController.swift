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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    
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
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "orderCell", for: indexPath) as! OrdersCollectionViewCell
        cell.layer.borderColor     = UIColor.systemGray.cgColor
        //cell.layer.shadowOpacity = 20
        //cell.layer.borderWidth   = 3.0
        cell.layer.cornerRadius    = 25.0
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

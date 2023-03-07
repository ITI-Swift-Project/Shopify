//
//  ProfileViewController.swift
//  Shopify
//
//  Created by Mahmoud on 21/02/2023.
//

import UIKit

class ProfileViewController: UIViewController{

    
    
    @IBOutlet weak var ordersCollectionView: UICollectionView!{
        didSet{
            ordersCollectionView.delegate = self
            ordersCollectionView.dataSource = self
            let nib = UINib(nibName: "OrdersCollectionViewCell", bundle: nil)
            ordersCollectionView.register(nib, forCellWithReuseIdentifier: "orderCell")
        }
    }

    
    
    @IBOutlet weak var wishListCollectionView: UICollectionView!{
        didSet{
           wishListCollectionView.delegate = self
            wishListCollectionView.dataSource = self
            let nib2 = UINib(nibName: "WishCollectionViewCell", bundle: nil)
          wishListCollectionView.register(nib2, forCellWithReuseIdentifier: "list")
        }
    }
        
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if UserDefaults.standard.bool(forKey: "loginState") == true
        {
            self.navigationController?.pushViewController(self, animated: true)
        }
        
        if UserDefaults.standard.bool(forKey: "loginState") == false
        {
            let storyBoard: UIStoryboard = UIStoryboard(name: "Authenticate", bundle: nil)
            let logInVC = storyBoard.instantiateViewController(withIdentifier: "signIn") as! LoginViewController
           
            self.navigationController?.pushViewController(logInVC, animated: true)
            if UserDefaults.standard.bool(forKey: "loginState") == true
            {
                super.viewWillAppear(true)
               // self.navigationController?.pushViewController(self, animated: true)
            }
            
        }
       
            //let storyBoard: UIStoryboard = UIStoryboard(name: "ProfileStoryboard", bundle: nil)
           // let meVC = storyBoard.instantiateViewController(withIdentifier: "Profile") as! ProfileViewController
          

        // Do any additional setup after loading the view.
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
extension ProfileViewController  : UICollectionViewDelegate{
    
}
extension ProfileViewController : UICollectionViewDataSource{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == ordersCollectionView
        {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "orderCell", for: indexPath) as! OrdersCollectionViewCell
            cell.layer.borderColor     = UIColor.systemGray.cgColor
            cell.layer.cornerRadius    = 25.0
            return cell
            
        }
        
    
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "list", for: indexPath) as! WishCollectionViewCell
            cell.layer.masksToBounds = true
        cell.layer.cornerRadius = 25.0

            cell.wishImg.image = UIImage(named: "product")
            cell.wishName.text = "Hoodie Green"
            cell.wishDescription.text = "Green Hoodie paul&pear"
            cell.wishPrice.text = "150.00".appending("$")
            
            
          //  cell.deleteBtn.addTarget(self, action: #selector(print), for: .touchUpInside)
            return cell
        
    }
}


extension ProfileViewController : UICollectionViewDelegateFlowLayout{
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

//
//  ProfileViewController.swift
//  Shopify
//
//  Created by Mahmoud on 21/02/2023.
//

import UIKit

class ProfileViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

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
    @IBAction func wishLIstAction(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "OrderStoryboard", bundle: nil)
        let wishListViewController = storyBoard.instantiateViewController(withIdentifier: "wishList") as! WishViewController
        //productDetailsViewController.arrProducts = result
        self.navigationController?.pushViewController(wishListViewController, animated: true)
    }
    @IBAction func ordersScreen(_ sender: Any) {
        
        let ordersVC = storyboard?.instantiateViewController(withIdentifier: "orders") as! OrdersViewController
        navigationController?.pushViewController(ordersVC, animated: true)
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

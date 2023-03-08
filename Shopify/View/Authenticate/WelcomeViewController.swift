//
//  WelcomeViewController.swift
//  Shopify
//
//  Created by Aya on 25/02/2023.
//

import UIKit

class WelcomeViewController: UIViewController {

    @IBOutlet weak var topView: UIView!
    
    @IBOutlet weak var skipBtn: UIButton!
    
    @IBOutlet weak var loginBtn: UIButton!
    
    @IBOutlet weak var signupBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.topView.layer.masksToBounds = true
        self.topView.layer.cornerRadius = self.topView.frame.size.height / 2
        self.signupBtn.layer.masksToBounds = true
        self.signupBtn.layer.cornerRadius = self.signupBtn.frame.size.height / 2
        self.loginBtn.layer.masksToBounds = true
        self.loginBtn.layer.cornerRadius = self.loginBtn.frame.size.height / 2
        self.skipBtn.layer.masksToBounds = true
        self.skipBtn.layer.cornerRadius = self.skipBtn.frame.size.height / 2
    }
    
    
    @IBAction func skipAcion(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let brandsViewController = storyBoard.instantiateViewController(withIdentifier: "tabBar") as! UITabBarController
        
        self.navigationController?.pushViewController(brandsViewController, animated: true)
    }
    @IBAction func signUp(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Authenticate", bundle: nil)
        let singUpViewController = storyBoard.instantiateViewController(withIdentifier: "signUp") as! SignUpViewController
        
        self.navigationController?.pushViewController(singUpViewController, animated: true)
    }

     @IBAction func signIn(_ sender: Any) {
         let storyBoard: UIStoryboard = UIStoryboard(name: "Authenticate", bundle: nil)
         let singInViewController = storyBoard.instantiateViewController(withIdentifier: "signIn") as! LoginViewController
         
         self.navigationController?.pushViewController(singInViewController, animated: true)
         
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

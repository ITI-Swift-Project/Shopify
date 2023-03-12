//
//  WelcomeViewController.swift
//  Shopify
//
//  Created by Aya on 25/02/2023.
//

import UIKit
protocol PresentedViewControllerDelegate: AnyObject {
    func didDismissPresentedViewController()
}
class WelcomeViewController: UIViewController {

    @IBOutlet weak var topView: UIView!
    
    @IBOutlet weak var loginBtn: UIButton!
    
    @IBOutlet weak var signupBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.topView.layer.masksToBounds = true
        self.topView.layer.cornerRadius = self.topView.frame.size.height / 2
        self.signupBtn.layer.masksToBounds = true
        self.signupBtn.layer.cornerRadius = self.signupBtn.frame.size.height / 2
        self.loginBtn.layer.masksToBounds = true
        self.loginBtn.layer.cornerRadius = self.loginBtn.frame.size.height / 2

    }
  
    
     func viewWillAppear( animated: Bool) {
        if ((UserDefaults.standard.value(forKey: "loginState")) as? Bool ?? false){
            self.dismiss(animated: true)
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "singIn" {
            let nextViewController = segue.destination as! LoginViewController
            nextViewController.delegate = self
        }
        else if segue.identifier == "singIn" {
            let nextViewController = segue.destination as! SignUpViewController
            nextViewController.delegate = self
        }
    }
    
    @IBAction func signUp(_ sender: Any) {
        performSegue(withIdentifier: "singUp", sender: self)

    }
 
     @IBAction func signIn(_ sender: Any) {
         performSegue(withIdentifier: "singIn", sender: self)

       
     }
    

}
extension WelcomeViewController : PresentedViewControllerDelegate{
    func didDismissPresentedViewController() {
        self.dismiss(animated: true)
    }
    
    
}

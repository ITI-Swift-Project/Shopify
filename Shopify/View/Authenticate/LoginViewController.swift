//
//  LoginViewController.swift
//  Shopify
//
//  Created by Aya on 23/02/2023.
//

import UIKit

@available(iOS 13.0, *)
class LoginViewController: UIViewController {
    var result : Customers?
    var network : NetworkViewModel?
    let semaphore = DispatchSemaphore(value: 0)
    let group = DispatchGroup()
    @IBOutlet weak var signupBtn: UIButton!
    
    @IBOutlet weak var skipBtn: UIButton!
    
    @IBOutlet weak var loginBtn: UIButton!
    
    
    @IBOutlet weak var emailTxt: UITextField!
    {
        didSet
        {
            
            emailTxt.tintColor = .darkGray
            //emailTxt.isSecureTextEntry = true
        }
    }
    
    
    
    @IBOutlet weak var passwordTxt: UITextField!
    {
        didSet
        {
            
            passwordTxt.tintColor = .darkGray
            passwordTxt.isSecureTextEntry = true
        }
    }
    
    @IBOutlet weak var topView: UIView!
    var customers : [allCustomers] = []
    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        network = NetworkViewModel()
        
        let endPoint = APIEndpoint.customer
        let url = endPoint.url(forShopName: NetworkService.baseUrl)
        
        emailTxt.layer.cornerRadius = emailTxt.frame.size.height / 2
        emailTxt.clipsToBounds = true
        
        passwordTxt.layer.cornerRadius = passwordTxt.frame.size.height / 2
        passwordTxt.clipsToBounds = true
        
        loginBtn.layer.cornerRadius = loginBtn.frame.size.height / 2
        loginBtn.clipsToBounds = true
        
        signupBtn.layer.cornerRadius = signupBtn.frame.size.height / 2
        signupBtn.clipsToBounds = true
        
        skipBtn.layer.cornerRadius = skipBtn.frame.size.height / 2
        skipBtn.clipsToBounds = true
        
        self.topView.layer.masksToBounds = true
        self.topView.layer.cornerRadius = self.topView.frame.size.width/2
        
        
        
    }
    
    
    @IBAction func signIn(_ sender: Any) {
        if emailTxt.text != "" && passwordTxt.text != ""
        {
            
            //semaphore.signal()
            group.enter()
            network?.getcustomerBY(email: "\(emailTxt.text ?? "")")
            
            network?.bindingCustomer = {
                DispatchQueue.main.async {
                    self.customers = self.network?.customerResult.customers ?? []
                    if (self.customers.count != 0 )
                    {
                        if (self.customers[0].tags == self.passwordTxt.text){
                            UserDefaults.standard.set(self.emailTxt.text ,forKey: "email")
                            UserDefaults.standard.set(true, forKey: "loginState")
                            UserDefaults.standard.set(self.result?.customers![0].id, forKey: "userId")
                            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                            let brandsViewController = storyBoard.instantiateViewController(withIdentifier: "tabBar") as! TabBarViewController
                            
                            self.navigationController?.pushViewController(brandsViewController, animated: false)
                            
                        }
                        else{
                            self.makeAlert(title: "wrong password", message: "please check yout password")
                        }
                        
                    }
                    else{
                        self.makeAlert(title: "Error", message: "wrong email")
                    }
                }
            }
           
        }
        else{
            makeAlert(title: "Missing Input", message: "please fill all text field")
        }
        
    }
    func makeAlert(title : String, message : String)
    {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAceion = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okAceion)
        self.present(alert, animated: true)
    }
    @IBAction func skipAction(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let brandsViewController = storyBoard.instantiateViewController(withIdentifier: "tabBar") as! UITabBarController
        
        self.navigationController?.pushViewController(brandsViewController, animated: true)
    }
    @IBAction func signUp(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Authenticate", bundle: nil)
        let singUpViewController = storyBoard.instantiateViewController(withIdentifier: "signUp") as! SignUpViewController
        
        self.navigationController?.pushViewController(singUpViewController, animated: true)
    }
}

extension UITextField
{
    func setLeftView(image : UIImage)
    {
        let iconView =  UIImageView(frame: CGRect(x: 10, y: 10, width: 25, height: 25))
        iconView.image = image
        let iconContainerView :  UIView = UIView(frame: CGRect(x: 0, y: 0, width: 35, height: 45))
        iconContainerView.addSubview(iconView)
        leftView = iconContainerView
        leftViewMode = .always
        self.tintColor = .darkGray
    }
}



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
    
    let semaphore = DispatchSemaphore(value: 0)
    @IBOutlet weak var signupBtn: UIButton!
    
    @IBOutlet weak var skipBtn: UIButton!
    
    @IBOutlet weak var loginBtn: UIButton!
    
    
    @IBOutlet weak var emailTxt: UITextField!
    {
        didSet
          {
              emailTxt.setLeftView(image: UIImage.init(systemName: "person.circle")!)
              emailTxt.tintColor = .darkGray
              //emailTxt.isSecureTextEntry = true
          }
    }
    
    
    
    @IBOutlet weak var passwordTxt: UITextField!
    {
       didSet
        {
            passwordTxt.setLeftView(image: UIImage.init(systemName: "lock.circle")!)
            passwordTxt.tintColor = .darkGray
            passwordTxt.isSecureTextEntry = true
        }
    }
    
    @IBOutlet weak var topView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let url = "https://48c475a06d64f3aec1289f7559115a55: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@ios-q2-new-capital-admin2-2022-2023.myshopify.com/admin/api/2023-01/customers.json"
       
        var frameNameTxt : CGRect = emailTxt.frame
        frameNameTxt.size.height = 53
        emailTxt.frame = frameNameTxt
        
        var framePasswordTxt : CGRect = passwordTxt.frame
        framePasswordTxt.size.height = 53
        passwordTxt.frame = framePasswordTxt
        
        
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
    
    private func validation() ->Bool
        {
            if
                emailTxt.text != "" && emailTxt.text?.count ?? 0 >= 10 && emailTxt.text?.count ?? 0 <= 40 &&  passwordTxt.text != "" && passwordTxt.text?.count ?? 0 >= 10 && passwordTxt.text?.count ?? 0 <= 20
            {
                return true
            }
            return false
        }
    
    
    @IBAction func signIn(_ sender: Any) {
        if emailTxt.text != "" && passwordTxt.text != ""
        {
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let brandsViewController = storyBoard.instantiateViewController(withIdentifier: "tabBar") as! TabBarViewController
            semaphore.signal()
            getData(from:  "https://48c475a06d64f3aec1289f7559115a55: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@ios-q2-new-capital-admin2-2022-2023.myshopify.com/admin/api/2023-01/customers/search.json?query=email:\(emailTxt.text!)")
            semaphore.wait()
          
            if result?.customers?.count != 0{
                TabBarViewController.loggedCustomer = result?.customers![0]
                UserDefaults.standard.set(result?.customers![0]
                    .id, forKey: "userId")
                UserDefaults.standard.set(true, forKey: "loginState")
                if result?.customers?[0].tags == passwordTxt.text{
                    
                    self.navigationController?.pushViewController(brandsViewController, animated: false)
                    
                }
                else{
                    
                   let alert =  UIAlertController()
                   let action = UIAlertAction(title: "check your password", style: .cancel , handler: nil)
                   alert.addAction(action)
                   present(alert, animated: true, completion: nil)
                }
            }
        }
        else
        {
            print("Invalid")
            let alert =  UIAlertController()
            let action = UIAlertAction(title: "Check your input", style: .default , handler: nil)
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
            
        }
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
    
    private func getData(from url : String)
    {
        guard let nurl = URL (string: url)
        else {return}
        let request = URLRequest(url : nurl)
        let task = URLSession.shared.dataTask(with: request)  { data, response, error in
            guard let data = data , error == nil else{
                print("Somthing Went Wrong")
                return
            }
            //have data
            
            do {
                self.result = try JSONDecoder().decode(Customers.self, from: data)
                print(self.result)
                self.semaphore.signal()
            }catch{
                print("failed to convert \(error.localizedDescription)")
            }
            guard let json = self.result else{
                return
            }
          //  print(json.first_name)
          //  print(json.email)
            print("doneeee")
           // print(data.count)
           // print(json.addresses)
            
        }
        task.resume()
        semaphore.wait()
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




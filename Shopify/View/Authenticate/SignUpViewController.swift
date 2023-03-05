//
//  SignUpViewController.swift
//  Shopify
//
//  Created by Aya on 23/02/2023.
//

import UIKit

@available(iOS 13.0, *)
class SignUpViewController: UIViewController {
    var viewModel : SignupVM?
    
    @IBOutlet weak var topView: UIView!
    
    @IBOutlet weak var usernameTxt: UITextField!
    {
        didSet
        {
            usernameTxt.setLeftView(image: UIImage.init(systemName: "person")!)
            usernameTxt.tintColor = .darkGray
            // usernameTxt.isSecureTextEntry = true
        }
    }
    
    @IBOutlet weak var emailTxt: UITextField!
    {
        didSet
        {
            emailTxt.setLeftView(image: UIImage.init(systemName: "mail.fill")!)
            emailTxt.tintColor = .darkGray
            //emailTxt.isSecureTextEntry = true
        }
    }
    
    @IBOutlet weak var passwordTxt: UITextField!
    {
        didSet
        {
            passwordTxt.setLeftView(image: UIImage.init(systemName: "lock")!)
            passwordTxt.tintColor = .darkGray
            passwordTxt.isSecureTextEntry =  true
        }
    }
    
    @IBOutlet weak var confirmPasswordTxt: UITextField!
    {
        didSet
        {
            confirmPasswordTxt.setLeftView(image: UIImage.init(systemName: "lock")!)
            confirmPasswordTxt.tintColor = .darkGray
            confirmPasswordTxt.isSecureTextEntry = true
        }
    }
    
    @IBOutlet weak var addressTxt: UITextField!
    {
        didSet
        {
            // addressTxt.setRightView(image: UIImage.init(systemName: "map")!)
            addressTxt.setLeftView(image: UIImage.init(systemName: "mappin.and.ellipse")!)
            addressTxt.tintColor = .darkGray
            // addressTxt.isSecureTextEntry = true
        }
        
    }
    
    @IBOutlet weak var phoneTxt: UITextField!
    {
        didSet
        {
            phoneTxt.setLeftView(image: UIImage.init(systemName: "phone")!)
            phoneTxt.tintColor = .darkGray
            // addressTxt.isSecureTextEntry = true
        }
    }
    
    
    @IBOutlet weak var cityTxt: UITextField!
    {
        didSet
        {
            cityTxt.setLeftView(image: UIImage.init(systemName: "building.2.crop.circle")!)
            cityTxt.tintColor = .darkGray
            // addressTxt.isSecureTextEntry = true
        }
    }
    
    
    @IBOutlet weak var countryTxt: UITextField!
    {
        didSet
        {
            countryTxt.setLeftView(image: UIImage.init(systemName: "building.columns.circle")!)
            countryTxt.tintColor = .darkGray
            // addressTxt.isSecureTextEntry = true
        }
    }
    
    
    @IBOutlet weak var signupBtn: UIButton!
    
    @IBOutlet weak var loginBtn: UIButton!
    
    @IBOutlet weak var skipBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        var frameUsernameTxt : CGRect = usernameTxt.frame
        frameUsernameTxt.size.height = 53
        usernameTxt.frame = frameUsernameTxt
        
        var frameEmailTxt : CGRect = emailTxt.frame
        frameEmailTxt.size.height = 53
        emailTxt.frame = frameEmailTxt
        
        var framePasswordTxt : CGRect = passwordTxt.frame
        framePasswordTxt.size.height = 53
        passwordTxt.frame = framePasswordTxt
        
        var frameConfirmPasswordTxt : CGRect = confirmPasswordTxt.frame
        frameConfirmPasswordTxt.size.height = 53
        confirmPasswordTxt.frame = frameConfirmPasswordTxt
        
        var framPhoneTxt : CGRect = phoneTxt.frame
        framPhoneTxt.size.height = 53
        phoneTxt.frame = framPhoneTxt
        
        var frameAddressTxt : CGRect = addressTxt.frame
        frameAddressTxt.size.height = 53
        addressTxt.frame = frameAddressTxt
        
        var frameCityTxt : CGRect = cityTxt.frame
        frameCityTxt.size.height = 53
        cityTxt.frame = frameCityTxt
        
        var frameCountryTxt : CGRect = countryTxt.frame
        frameCountryTxt.size.height = 53
        countryTxt.frame = frameCountryTxt
        
        
        usernameTxt.layer.cornerRadius = usernameTxt.frame.size.height / 2
        usernameTxt.clipsToBounds = true
        
        emailTxt.layer.cornerRadius = emailTxt.frame.size.height / 2
        emailTxt.clipsToBounds = true
        
        passwordTxt.layer.cornerRadius = passwordTxt.frame.size.height / 2
        passwordTxt.clipsToBounds = true
        
        confirmPasswordTxt.layer.cornerRadius = confirmPasswordTxt.frame.size.height / 2
        confirmPasswordTxt.clipsToBounds = true
        
        phoneTxt.layer.cornerRadius = phoneTxt.frame.size.height / 2
        phoneTxt.clipsToBounds = true
        
        addressTxt.layer.cornerRadius = addressTxt.frame.size.height / 2
        addressTxt.clipsToBounds = true
        
        cityTxt.layer.cornerRadius = cityTxt.frame.size.height / 2
        cityTxt.clipsToBounds = true
        
        countryTxt.layer.cornerRadius = countryTxt.frame.size.height / 2
        countryTxt.clipsToBounds = true
        
        signupBtn.layer.cornerRadius = signupBtn.frame.size.height / 2
        signupBtn.clipsToBounds = true
        
        
        self.topView.layer.masksToBounds = true
        self.topView.layer.cornerRadius = self.topView.frame.size.height / 2
        
        
    }
    
    @IBAction func signUP(_ sender: Any) {
       if validation() == true
        {
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let brandsViewController = storyBoard.instantiateViewController(withIdentifier: "tabBar") as! UITabBarController
            
            self.navigationController?.pushViewController(brandsViewController, animated: true)
            
            let userDefualts2 = UserDefaults.standard
            userDefualts2.set(true, forKey: "signUpState")
            viewModel = SignupVM()
            let   newData  : [String : Any] = [
                "customer" : [
                    "email":"\(emailTxt.text!)",
                    "first_name":"\(usernameTxt.text!)",
                    "tags": "\(passwordTxt.text!)",
                    "addresses" : [["phone" : "\(phoneTxt.text!)",
                        "address1":"\(addressTxt.text!)",
                                    "city": "\(cityTxt.text!)",
                                    "country" : "\(countryTxt.text!)"]]
                ]
            ]
            viewModel?.postCustomer(url: "https://48c475a06d64f3aec1289f7559115a55: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@ios-q2-new-capital-admin2-2022-2023.myshopify.com/admin/api/2023-01/customers.json", data: newData)
       
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
    
    @IBAction func signIn(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Authenticate", bundle: nil)
        let singInViewController = storyBoard.instantiateViewController(withIdentifier: "signIn") as! LoginViewController
        
        self.navigationController?.pushViewController(singInViewController, animated: true)
    }
    @IBAction func skipAction(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let brandsViewController = storyBoard.instantiateViewController(withIdentifier: "tabBar") as! UITabBarController
        
        self.navigationController?.pushViewController(brandsViewController, animated: true)
    }
    
    
    private func validation() ->Bool
    {
        if usernameTxt.text != "" && usernameTxt.text?.count ?? 0 >= 10 && usernameTxt.text?.count ?? 0 <= 20 &&
            emailTxt.text != "" && emailTxt.text?.count ?? 0 >= 10 && emailTxt.text?.count ?? 0 <= 40 &&  passwordTxt.text != "" && passwordTxt.text?.count ?? 0 >= 10 && passwordTxt.text?.count ?? 0 <= 20 && confirmPasswordTxt.text != "" && confirmPasswordTxt.text?.count == passwordTxt.text?.count && addressTxt.text != "" && addressTxt.text?.count ?? 0 >= 5 && addressTxt.text?.count ?? 0 <= 8 &&
            cityTxt.text != "" && cityTxt.text?.count ?? 0 >= 5 && cityTxt.text?.count ?? 0 <= 8 && countryTxt.text != "" && countryTxt.text?.count ?? 0 >= 5 && countryTxt.text?.count ?? 0 <= 8 && phoneTxt.text != "" && phoneTxt.text?.count ?? 0 >= 11 && phoneTxt.text?.count ?? 0 <= 13
        {
            return true
        }
        return false
    }
    
}



extension UITextField
{
    func setLeftViewSignup(image : UIImage)
    {
        let iconView = UIImageView(frame: CGRect(x: 10, y: 10, width: 25, height: 25))
        iconView.image = image
        let iconContainerView : UIView =  UIView(frame: CGRect(x: 0, y: 0, width: 35, height: 45))
        iconContainerView.addSubview(iconView)
        leftView = iconContainerView
        leftViewMode = .always
        self.tintColor = .darkGray
    }
}

extension UITextField
{
    func setRightView(image :  UIImage)
    {
        let iconView = UIImageView(frame: CGRect(x: 0, y: 10, width: 25, height: 25))
        iconView.image = image
        let iconContainerView :UIView = UIView(frame: CGRect(x: 0, y: 0, width: 35, height: 45))
        iconContainerView.addSubview(iconView)
        rightView = iconContainerView
        rightViewMode = .always
        self.tintColor = .darkGray
    }
}

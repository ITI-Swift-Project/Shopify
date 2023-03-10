//
//  SignUpViewController.swift
//  Shopify
//
//  Created by Aya on 23/02/2023.
//

import UIKit

@available(iOS 13.0, *)
class SignUpViewController: UIViewController {
    var viewModel : NetworkViewModel?
    var alertText : String = ""
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
    
    @IBOutlet weak var lastNameTxt: UITextField!
    
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
        
//        var frameUsernameTxt : CGRect = usernameTxt.frame
//        frameUsernameTxt.size.height = 53
//        usernameTxt.frame = frameUsernameTxt
        
//        var frameEmailTxt : CGRect = emailTxt.frame
//        frameEmailTxt.size.height = 53
//        emailTxt.frame = frameEmailTxt
//
//        var framePasswordTxt : CGRect = passwordTxt.frame
//        framePasswordTxt.size.height = 53
//        passwordTxt.frame = framePasswordTxt
//
//        var frameConfirmPasswordTxt : CGRect = confirmPasswordTxt.frame
//        frameConfirmPasswordTxt.size.height = 53
//        confirmPasswordTxt.frame = frameConfirmPasswordTxt
//
//        var framPhoneTxt : CGRect = phoneTxt.frame
//        framPhoneTxt.size.height = 53
//        phoneTxt.frame = framPhoneTxt
//
//        var frameAddressTxt : CGRect = addressTxt.frame
//        frameAddressTxt.size.height = 53
//        addressTxt.frame = frameAddressTxt
//
//        var frameCityTxt : CGRect = cityTxt.frame
//        frameCityTxt.size.height = 53
//        cityTxt.frame = frameCityTxt
//
//        var frameCountryTxt : CGRect = countryTxt.frame
//        frameCountryTxt.size.height = 53
//        countryTxt.frame = frameCountryTxt
        
        makeCircle(object: usernameTxt)
        makeCircle(object: lastNameTxt)
        makeCircle(object: emailTxt)
        makeCircle(object: phoneTxt)
        makeCircle(object: confirmPasswordTxt)
        makeCircle(object: cityTxt)
        makeCircle(object: phoneTxt)
        makeCircle(object: passwordTxt)
        makeCircle(object: addressTxt)
        makeCircle(object: countryTxt)
       

        
        signupBtn.layer.cornerRadius = signupBtn.frame.size.height / 2
        signupBtn.clipsToBounds = true
        
        
        self.topView.layer.masksToBounds = true
        self.topView.layer.cornerRadius = self.topView.frame.size.height / 2
        self.loginBtn.layer.masksToBounds = true
        self.loginBtn.layer.cornerRadius = self.loginBtn.frame.size.height / 2
        self.skipBtn.layer.masksToBounds = true
        self.skipBtn.layer.cornerRadius = self.skipBtn.frame.size.height / 2
        
        
    }
    func makeCircle(object : UITextField)
    {
        object.layer.cornerRadius = object.frame.size.height / 2
        object.clipsToBounds = true
    }
    
    @IBAction func signUP(_ sender: Any) {
       if !checkFildes()
        {
           print("Invalid")
           let alert =  UIAlertController(title: "Missing filed", message: "please complete your data", preferredStyle: .alert)
           let action = UIAlertAction(title: "ok" , style: .default , handler: nil)
           alert.addAction(action)
           present(alert, animated: true, completion: nil)
       }
        alertText = ""
        
        if !validEmail(email: "\(emailTxt.text ?? "")")
        {
            alertText.append("check email")
            alertText.append("\n")
        }
        if !validPassword(password:  "\(passwordTxt.text ?? "")") || !((passwordTxt.text) == (confirmPasswordTxt.text))
        {
            alertText.append("check password")
            alertText.append("\n")
        }
        if !validPhone(phone:  "\(phoneTxt.text ?? "")")
        {
            alertText.append("check phone")
            alertText.append("\n")
        }
        if alertText == ""
        {
            
            viewModel = NetworkViewModel()
            let   newData  : [String : Any] = [
                "customer" : [
                    "email":"\(emailTxt.text!)",
                    "phone":"\(phoneTxt.text!)",
                    "first_name":"\(usernameTxt.text!)",
                    "last_name":"\(lastNameTxt.text!)",
                    "tags": "\(passwordTxt.text!)",
                    "addresses" : [["phone" : "\(phoneTxt.text!)",
                                    "address1":"\(addressTxt.text!)",
                                    "city": "\(cityTxt.text!)",
                                    "country" : "\(countryTxt.text!)"]]
                ]
            ]
            let endPoint = APIEndpoint.customer
            let url = endPoint.url(forShopName: NetworkService.baseUrl)
            viewModel?.postCustomer(url:url , data: newData){ result in
                print("here in sign up view controller")
                switch result {
                case .success(let data):
                    do {
                        if let dict = try JSONSerialization.jsonObject(with: data, options: []) as? [String:Any] {
                            if let errors = dict["errors"] as? [String: [String]] {
                                var message = ""
                                for (key, value) in errors {
                                   
                                            if let errorMessage = value[0] as? String {
                                                message.append("\(key) : ")
                                                message.append("\(errorMessage)")
                                                message.append("\n")

                                    }
                                }
                                DispatchQueue.main.async {
                                    let alert =  UIAlertController(title: "Error", message: message, preferredStyle: .alert)
                                    let action = UIAlertAction(title: "OK" , style: .default , handler: nil)
                                    alert.addAction(action)
                                    self.present(alert, animated: true, completion: nil)
                                    message = ""
                                    print(message)
                                }
                               
                            } else if let customer : [String : Any] = dict["customer"] as? [String : Any] {
                                DispatchQueue.main.async {
                                    
                                    let userDefaults = UserDefaults.standard
                                    userDefaults.set(true, forKey: "signUpState")
                                    userDefaults.set(self.emailTxt.text ,forKey: "email")
                                    userDefaults.set(true, forKey: "loginState")
                                    userDefaults.set(customer["id"] as? Int, forKey: "userId")
                                    let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                                    let brandsViewController = storyBoard.instantiateViewController(withIdentifier: "tabBar") as! UITabBarController
                                    
                                    self.navigationController?.pushViewController(brandsViewController, animated: true)
                                   
                                }
                            } else {
                                print("Unknown response")
                            }
                        } else {
                            print("Response is not a dictionary")
                        }
                    } catch {
                        print("Error parsing JSON: \(error.localizedDescription)")
                    }
                case .failure(let error):
                    let alert =  UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
                    let action = UIAlertAction(title: "OK" , style: .default , handler: nil)
                    alert.addAction(action)
                    self.present(alert, animated: true, completion: nil)
                }
            }
        
        }
        else
        {
            print("Invalid")
            let alert =  UIAlertController(title: "Wrong Data", message: alertText, preferredStyle: .alert)
            let action = UIAlertAction(title: "Ok" , style: .default , handler: nil)
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
    
    

    func checkFildes()->Bool{
        if emailTxt.text == "" || usernameTxt.text == "" || passwordTxt.text ==  "" || confirmPasswordTxt.text == "" || phoneTxt.text == "" || cityTxt.text == "" || addressTxt.text == "" || countryTxt.text == "" || lastNameTxt.text == ""
        {
            return false
        }
        else
        {
            return true
        }
    }
    func validEmail(email : String)->Bool{
            let emailRegex = RegexForFields.email
            let emailRegexString = emailRegex.rawValue
            let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegexString)
        print(email)
        
        return emailPredicate.evaluate(with: email)
    }
    func validPassword(password : String)->Bool{
            let passwordRegex = RegexForFields.password
            let passwordRegexString = passwordRegex.rawValue
            let passwordPredicate = NSPredicate(format: "SELF MATCHES %@", passwordRegexString)
        print(password)
        print(passwordPredicate.evaluate(with: password))
            return passwordPredicate.evaluate(with: password)
    }
    func validPhone(phone : String)->Bool{
        let phoneRegex = RegexForFields.phone
        let phoneRegexString = phoneRegex.rawValue
        let phonePredicate = NSPredicate(format: "SELF MATCHES %@", phoneRegexString)
        print(phonePredicate.evaluate(with: phone))
        return phonePredicate.evaluate(with: phone)
}
    enum RegexForFields: String {
        case email = "[A-Z0-9a-z_]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        case password = "[A-Za-z\\d]{8,}$"
        case phone = "^(01)[0125][0-9]{8}$"
        
        
        func getDescription() -> String {
            return self.rawValue
        }
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


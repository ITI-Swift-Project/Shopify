//
//  SignUpViewController.swift
//  Shopify
//
//  Created by Aya on 23/02/2023.
//

import UIKit

@available(iOS 13.0, *)
class SignUpViewController: UIViewController {
    
    @IBOutlet weak var topView: UIView!
    
    @IBOutlet weak var usernameTxt: UITextField!
    {
        didSet
        {
            usernameTxt.setLeftView(image: UIImage.init(systemName: "person")!)
            usernameTxt.tintColor = .darkGray
            usernameTxt.isSecureTextEntry = true
        }
    }
    
    @IBOutlet weak var emailTxt: UITextField!
    {
        didSet
        {
            emailTxt.setLeftView(image: UIImage.init(systemName: "mail.fill")!)
            emailTxt.tintColor = .darkGray
            emailTxt.isSecureTextEntry = true
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
            addressTxt.setRightView(image: UIImage.init(systemName: "map")!)
            addressTxt.setLeftView(image: UIImage.init(systemName: "mappin.and.ellipse")!)
            addressTxt.tintColor = .darkGray
            addressTxt.isSecureTextEntry = true
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
        
        var frameAddressTxt : CGRect = addressTxt.frame
        frameAddressTxt.size.height = 53
        addressTxt.frame = frameAddressTxt
        
        
        usernameTxt.layer.cornerRadius = usernameTxt.frame.size.height / 2
        usernameTxt.clipsToBounds = true
        
        emailTxt.layer.cornerRadius = emailTxt.frame.size.height / 2
        emailTxt.clipsToBounds = true
        
        passwordTxt.layer.cornerRadius = passwordTxt.frame.size.height / 2
        passwordTxt.clipsToBounds = true
        
        confirmPasswordTxt.layer.cornerRadius = confirmPasswordTxt.frame.size.height / 2
        confirmPasswordTxt.clipsToBounds = true
        
        addressTxt.layer.cornerRadius = addressTxt.frame.size.height / 2
        addressTxt.clipsToBounds = true
        
        signupBtn.layer.cornerRadius = signupBtn.frame.size.height / 2
        signupBtn.clipsToBounds = true
        
       
        self.topView.layer.masksToBounds = true
        self.topView.layer.cornerRadius = self.topView.frame.size.height / 2
        
       
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

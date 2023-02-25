//
//  LoginViewController.swift
//  Shopify
//
//  Created by Aya on 23/02/2023.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var signupBtn: UIButton!
    
    @IBOutlet weak var skipBtn: UIButton!
    
    @IBOutlet weak var loginBtn: UIButton!
    
    @IBOutlet weak var nameTxt: UITextField!
    {
      didSet
        {
            nameTxt.setLeftView(image: UIImage.init(systemName: "person.circle")!)
            nameTxt.tintColor = .darkGray
            nameTxt.isSecureTextEntry = true
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
        
        
        var frameNameTxt : CGRect = nameTxt.frame
        frameNameTxt.size.height = 53
        nameTxt.frame = frameNameTxt
        
        var framePasswordTxt : CGRect = passwordTxt.frame
        framePasswordTxt.size.height = 53
        passwordTxt.frame = framePasswordTxt
        
        
        nameTxt.layer.cornerRadius = nameTxt.frame.size.height / 2
        nameTxt.clipsToBounds = true
        
        passwordTxt.layer.cornerRadius = nameTxt.frame.size.height / 2
        passwordTxt.clipsToBounds = true
        
        loginBtn.layer.cornerRadius = loginBtn.frame.size.height / 2
        loginBtn.clipsToBounds = true
        
        
       /* nameTxt.leftViewMode = UITextField.ViewMode.always
        let imageView = UIImageView(frame: CGRect(x: 8.0, y: 8.0, width: 24.0, height: 24.0))
        
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 32, height: 40))
      //  let imageView = UIImageView(frame: CGRect(x: 6, y: 6, width: 20, height: 20))
        let image = UIImage(named: "profile")
        imageView.image = image
        nameTxt.leftView = imageView
       //
        nameTxt.leftView = view
*/
        
       /* nameTxt.leftViewMode = UITextField.ViewMode.always

        nameTxt.leftViewMode = .always*/
        
     
       // nameTxt.layer.borderWidth = 2.0
       // nameTxt.layer.borderWidth = nameTxt.layer.borderWidth
       // nameTxt.layer.
        
      self.topView.layer.masksToBounds = true
    self.topView.layer.cornerRadius = self.topView.frame.size.width/2
        
      //  self.topView.layer.cornerRadius = self.topView.frame.size.width/CGFloat(2)
        
       // self.topView.layer.contentsScale = self.topView.frame.size.height/2
      //  self.topView.layer.
           
       // let layershape = CAShapeLayer()
       // let circlePath = UIBezierPath(arcCenter: center, radius: 200, startAngle: 6.28, endAngle: 3 * CGFloat.pi , clockwise: true)
        
        
      /*  let circlePath = UIBezierPath(arcCenter: center, radius: 200, startAngle: 6.28, endAngle: 3 * CGFloat.pi , clockwise: true)
        layershape.path = circlePath.cgPath
        view.layer.addSublayer(layershape)
        */
        
        /*
         // MARK: - Navigation
         
         // In a storyboard-based application, you will often want to do a little preparation before navigation
         override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         // Get the new view controller using segue.destination.
         // Pass the selected object to the new view controller.
         }
         */
        
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




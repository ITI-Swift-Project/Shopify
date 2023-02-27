//
//  SettingViewController.swift
//  Shopify
//
//  Created by Mahmoud on 21/02/2023.
//

import UIKit

class SettingViewController: UIViewController {

    @IBOutlet weak var settingsTable: UITableView!
    {
        didSet
        {
            settingsTable.dataSource = self
            settingsTable.delegate = self
            let nib = UINib(nibName: "SettingsCell", bundle: nil)
            settingsTable.register(nib, forCellReuseIdentifier: "settingsCell")
        }
    }
    @IBOutlet weak var bgFrame: UIView!
    @IBOutlet weak var wishListFrame: UIView!
    
    @IBAction func shoppingCart(_ sender: Any) {
       
           // performSegue(withIdentifier: "shoppingCart", sender: self)
    }
    @IBOutlet weak var shoppingCartFrame: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        settingsVCStyle()
    }
    
}
extension SettingViewController : UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.5//CGFloat(1)
        }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
            let headerView : UIView = UIView()
            //headerView.frame.size.height = 0.1
            headerView.backgroundColor = UIColor.clear
            //headerView.layer.masksToBounds = true
            //headerView.layer.cornerRadius = 30
            return headerView
        }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "settingsCell", for: indexPath) as! SettingsCell
        cell.layer.borderWidth = 3
        cell.layer.cornerRadius = cell.frame.height/3
        cell.selectionIndicator.image = UIImage(named: "more")
        switch (indexPath.section)
        {
        case 0 :
            cell.settingTitle.text = "Edit Profile"
            cell.settingImage.image = UIImage(named: "editProfile")
            return cell
        case 1 :
            cell.settingTitle.text = "Theme"
            cell.settingImage.image = UIImage(named: "theme")
            return cell
        case 2 :
            cell.settingTitle.text = "Currency"
            cell.settingImage.image = UIImage(named: "currency")
            return cell
        case 3 :
            cell.settingTitle.text = "About Us"
            cell.settingImage.image = UIImage(named: "aboutUs")
            return cell
        case 4 :
            cell.settingTitle.text = "Contact Us"
            cell.settingImage.image = UIImage(named: "contactUs")
            return cell
        default:
            return cell
         }
    }
}
extension SettingViewController : UITableViewDelegate
{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 68
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch (indexPath.section)
        {
        case 0 :
            let editProfileVC = storyboard?.instantiateViewController(withIdentifier: "editProfile") as! EditProfileViewController
            self.present(editProfileVC , animated: true , completion: nil)
        case 1 :
            let themeVC = storyboard?.instantiateViewController(withIdentifier: "theme") as! ThemeViewController
            self.present(themeVC , animated: true , completion: nil)
        case 2 :
            let currencyVC = storyboard?.instantiateViewController(withIdentifier: "currency") as! CurrencyViewController
            self.present(currencyVC , animated: true , completion: nil)
        case 3 :
            let aboutUsVC = storyboard?.instantiateViewController(withIdentifier: "aboutUs") as! AboutUsViewController
            self.present(aboutUsVC , animated: true , completion: nil)
       case 4 :
            let contactUsVC = storyboard?.instantiateViewController(withIdentifier: "contactUs") as! ContactUsViewController
            self.present(contactUsVC , animated: true , completion: nil)
        default :
            break
        }
    }
}
extension  SettingViewController
{
     func settingsVCStyle()
    {
        bgFrame.layer.masksToBounds = true
        bgFrame.layer.cornerRadius = 30
        wishListFrame.layer.masksToBounds = true
        wishListFrame.layer.cornerRadius = wishListFrame.frame.size.width/2
        shoppingCartFrame.layer.masksToBounds = true
        shoppingCartFrame.layer.cornerRadius = shoppingCartFrame.frame.size.width/2

    }
}

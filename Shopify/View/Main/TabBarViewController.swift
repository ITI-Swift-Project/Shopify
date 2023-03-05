//
//  TabBarViewController.swift
//  Shopify
//
//  Created by Mahmoud on 22/02/2023.
//

import UIKit

class TabBarViewController: UITabBarController {
    static var loggedCustomer : Customer?
    override func viewDidLoad() {
        super.viewDidLoad()
        makeCornerRound()
        // Do any additional setup after loading the view.
    }
    func makeCornerRound()->Void{
        self.tabBar.layer.masksToBounds = true
        self.tabBar.isTranslucent       = true
//        self.tabBar.layer.borderWidth   = 5
        self.tabBar.layer.borderColor   = UIColor(named: "firstColor")?.cgColor
        self.tabBar.backgroundColor = UIColor(named: "firstColor")
        self.tabBar.layer.cornerRadius  = UIScreen.main.bounds.width / 20
//        self.tabBar.app
        UITabBar.appearance().isTranslucent = true
        UITabBar.appearance().barTintColor = .white
//        UITabBar.appearance().backgroundColor = .white
        UITabBar.appearance().unselectedItemTintColor = .white
        self.tabBar.layer.maskedCorners = [.layerMinXMinYCorner,.layerMaxXMinYCorner]
    }

}

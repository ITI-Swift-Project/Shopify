//
//  TabBarViewController.swift
//  Shopify
//
//  Created by Mahmoud on 22/02/2023.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        makeCornerRound()
        // Do any additional setup after loading the view.
    }
    func makeCornerRound()->Void{
        self.tabBar.layer.masksToBounds = true
        self.tabBar.isTranslucent       = true
//        self.tabBar.layer.borderWidth   = 5
        self.tabBar.layer.borderColor   = UIColor(named: "HomeCellBackground")?.cgColor
        self.tabBar.backgroundColor = UIColor(named: "HomeCellBackground")
        self.tabBar.layer.cornerRadius  = UIScreen.main.bounds.width / 20
//        self.tabBar.app
        UITabBar.appearance().isTranslucent = true
        UITabBar.appearance().barTintColor = .white
//        UITabBar.appearance().backgroundColor = .white
        UITabBar.appearance().unselectedItemTintColor = .white
        self.tabBar.layer.maskedCorners = [.layerMinXMinYCorner,.layerMaxXMinYCorner]
    }

}
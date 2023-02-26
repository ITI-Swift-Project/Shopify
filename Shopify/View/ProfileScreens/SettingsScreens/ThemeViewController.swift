//
//  ThemeViewController.swift
//  Shopify
//
//  Created by Fatma on 25/02/2023.
//

import UIKit

class ThemeViewController: UIViewController {

    @IBOutlet weak var bgFrame: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        StyleHelper.bgFrameStyle(frame: bgFrame)

        // Do any additional setup after loading the view.
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

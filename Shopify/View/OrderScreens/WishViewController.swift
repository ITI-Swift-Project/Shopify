//
//  WishViewController.swift
//  Shopify
//
//  Created by Mahmoud on 21/02/2023.
//

import UIKit

class WishViewController: UIViewController {

    @IBOutlet weak var WishTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        WishTableView.delegate = self
        WishTableView.dataSource = self
        WishTableView.register(UINib(nibName: "WishTableViewCell", bundle: nil), forCellReuseIdentifier: "WishCell")
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

extension WishViewController : UITableViewDelegate
{
    
}


extension WishViewController : UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WishCell", for: indexPath) 
        return cell
    }
    
    
}

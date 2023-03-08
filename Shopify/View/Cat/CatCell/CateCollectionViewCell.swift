//
//  CatCollectionViewCell.swift
//  Shopify
//
//  Created by Mahmoud on 22/02/2023.
//

import UIKit
import Kingfisher
import CoreData
class CateCollectionViewCell: UICollectionViewCell {

    
    @IBOutlet weak var fLabel: UILabel!
    @IBOutlet weak var img: UIImageView!
    
    @IBOutlet weak var prouductName: UILabel!
    
    @IBOutlet weak var vendorLabel: UILabel!
    
    @IBOutlet weak var typeLabel: UILabel!
    var myWishlist :NSManagedObject!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        //1
        let appDelegate  = UIApplication.shared.delegate as! AppDelegate
        //2
        let context = appDelegate.persistentContainer.viewContext
        //3
        let entity = NSEntityDescription.entity(forEntityName: "WishListProduct", in: context)
        //4
         myWishlist = NSManagedObject(entity: entity!, insertInto: context)
    }
    func configImg(name : URL)->Void
    {
        img.backgroundColor = UIColor.white
        img.layer.masksToBounds = true
        img.layer.cornerRadius = 20
        img.kf.setImage(with: name, placeholder: UIImage(named: "notFound"))
    }
    func configProductInfo(name : String,vendor : String,type : String)->Void
    {
        prouductName.text = name
        vendorLabel.text  = vendor
        typeLabel.text    = type
    }
    
    @IBAction func wishListBtn(_ sender: Any) {
        myWishlist.setValue(prouductName.text, forKey: "productTitle")
        //myWishlist.setValue(, forKey: <#T##String#>)
        print("\(myWishlist.setValue(prouductName.text, forKey: "productTitle"))")
    }
    
}

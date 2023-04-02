//
//  CatCollectionViewCell.swift
//  Shopify
//
//  Created by Mahmoud on 22/02/2023.
//

import UIKit
import Kingfisher
class CateCollectionViewCell: UICollectionViewCell {

    
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var fLabel: UILabel!
    @IBOutlet weak var img: UIImageView!
    
    @IBOutlet weak var prouductName: UILabel!
    @IBOutlet weak var vendorLabel: UILabel!
    
    @IBOutlet weak var addProductToWishList: UIButton!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var wishButtonOutlet: UIButton!
    var product : Product?
    var coreDateViewModel : CoreDataViewModelClass!
    override func awakeFromNib() {
        super.awakeFromNib()
        coreDateViewModel = CoreDataViewModelClass()
        coreDateViewModel.checkWishListState(id: product?.id ?? 0)
    }
    func configImg(name : URL)->Void
    {
        img.backgroundColor = UIColor.white
        img.layer.masksToBounds = true
        img.layer.cornerRadius = 20
        img.kf.setImage(with: name, placeholder: UIImage(named: "notFound"))
    }
    func configProductInfo(name : String,vendor : String,price : String)->Void
    {
        prouductName.text = name
        vendorLabel.text  = vendor
        typeLabel.text    = price
    }
    
    @IBAction func wishButton(_ sender: UIButton) {
//        if coreDateViewModel.wishListState {
//            print("deletes")
//                coreDateViewModel.deleteFromWishList(id: product?.id ?? 0)
//            sender.setImage(UIImage(systemName:  "heart"), for: .normal)
//        }else{
//            print("Added")
//            coreDateViewModel.addToWishList(id: product?.id ?? 0, title: product?.title ?? "" , price:  product?.variants?.first?.price ?? "" , quantity: product?.variants?.first?.inventory_quantity ?? 0, image: product?.images?.first?.src ?? "" , vendor: vendorLabel.text ?? "")
//            sender.setImage(UIImage(systemName:  "heart.fill"), for: .normal)
//        }
    }
        
}

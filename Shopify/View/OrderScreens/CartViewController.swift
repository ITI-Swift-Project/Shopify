//
//  CartViewController.swift
//  Shopify
//
//  Created by Mahmoud on 21/02/2023.
//

import UIKit

class CartViewController: UIViewController {

    @IBOutlet weak var shoppingCartFrame: UIView!
    @IBOutlet weak var subTotal: UILabel!
    @IBOutlet weak var shoppingCartCollectionView: UICollectionView!
    @IBOutlet weak var checkout: UIButton!
    @IBAction func proceedToCheckout(_ sender: Any) {
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        shoppingCartCollectionView.dataSource = self
        shoppingCartCollectionView.delegate = self
        self.shoppingCartFrame.layer.masksToBounds = true
        self.shoppingCartFrame.layer.cornerRadius = 30
        self.shoppingCartCollectionView.backgroundColor = UIColor(named: "thirdColor")
        self.subTotal.layer.masksToBounds = true
        self.subTotal.layer.cornerRadius = 20
        self.subTotal.text = "  600.00".appending("$")
        let nib = UINib(nibName: "ShoppingCartCell", bundle: nil)
        shoppingCartCollectionView.register(nib, forCellWithReuseIdentifier: "shoppingCartCell")
        self.subTotal.bringSubviewToFront(checkout)
        self.subTotal.layer.shadowRadius = 6.0
        self.subTotal.layer.shadowOpacity = 1.0
        self.subTotal.layer.shadowColor = UIColor.red.cgColor
        self.subTotal.layer.shadowOffset = CGSize(width: 4.0, height: 4.0)
        
    }
    

    
}
extension CartViewController : UICollectionViewDataSource,UICollectionViewDelegate
{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "shoppingCartCell", for: indexPath) as! ShoppingCartCell
        cell.layer.masksToBounds = true
        cell.layer.cornerRadius = 30
      //  cell.layer.borderColor = UIColor(named: "s")?.cgColor
      //  cell.layer.borderWidth = 8
        

        //cell.frame = cell.frame.inset(by: UIEdgeInsets(top: 10, left: 10, bottom: 50, right: 10))
        
        cell.cartProductImage.image = UIImage(named: "product")
        cell.cartProductName.text = "Hoodie Green"
        cell.cartProductDescription.text = "Green Hoodie paul&pear"
        cell.cartProductPrice.text = "150.00".appending("$")
        cell.cartProductsCount.text = "6"
        cell.cartProductSuTotalPrice.text = "450.00".appending("EGP")
        cell.cartProductsCount.layer.masksToBounds = true
        cell.cartProductsCount.layer.cornerRadius = 12
        cell.trashFrame.layer.masksToBounds = true
        cell.trashFrame.layer.cornerRadius = cell.trashFrame.frame.size.width/2
        cell.deleteCartProduct.addTarget(self, action: #selector(print), for: .touchUpInside)
        return cell
        
    }
}

extension CartViewController : UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: shoppingCartCollectionView.layer.bounds.size.width-5,height: (shoppingCartCollectionView.layer.bounds.size.height/2.5)-30)
    }
}
extension CartViewController
{
    @objc func print()
    {
        Swift.print("fatma")
    }
}


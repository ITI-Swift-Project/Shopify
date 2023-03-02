//
//  CartViewController.swift
//  Shopify
//
//  Created by Mahmoud on 21/02/2023.
//

import UIKit

class CartViewController: UIViewController {
    
    var shoppingCartItemsList = Array<CartItem>()
    var total : Float = 0.0
    @IBOutlet weak var shoppingCartFrame: UIView!
    @IBOutlet weak var subTotal: UILabel!
    @IBOutlet weak var shoppingCartCollectionView: UICollectionView!
    {
        didSet
        {
            shoppingCartCollectionView.dataSource = self
            shoppingCartCollectionView.delegate = self
            let nib = UINib(nibName: "ShoppingCartCell", bundle: nil)
            shoppingCartCollectionView.register(nib, forCellWithReuseIdentifier: "shoppingCartCell")
        }
    }
    @IBOutlet weak var checkout: UIButton!
    @IBAction func proceedToCheckout(_ sender: Any) {
        let orderDetailsVC = storyboard?.instantiateViewController(withIdentifier: "orderDetails") as! OrderDetailsViewController
        navigationController?.pushViewController(orderDetailsVC, animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        cartVCStyle()
        var p1 = CartItem()
        var p2 = CartItem()
        var p3 = CartItem()
        var p4 = CartItem()
        var p5 = CartItem()
        shoppingCartItemsList.append(p1)
        shoppingCartItemsList.append(p2)
        shoppingCartItemsList.append(p3)
        shoppingCartItemsList.append(p4)
        shoppingCartItemsList.append(p5)
        
        for i in 0..<shoppingCartItemsList.count{
            total += shoppingCartItemsList[i].cartItemSubTotal
        }
        self.subTotal.text = "   ".appending(String(total)).appending("$")

          //   subTotal.text = String(shoppingCartItemsList.reduce(p1, { x, y in x + y }))
        }
    
        
    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}

extension CartViewController : UICollectionViewDataSource,UICollectionViewDelegate
{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return shoppingCartItemsList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "shoppingCartCell", for: indexPath) as! ShoppingCartCell
        cell.layer.masksToBounds = true
        cell.layer.cornerRadius = 30
      //  cell.layer.borderColor = UIColor(named: "s")?.cgColor
      //  cell.layer.borderWidth = 8
      //cell.frame = cell.frame.inset(by: UIEdgeInsets(top: 10, left: 10, bottom: 50, right: 10))
        cell.cartProductImage.image = UIImage(named: "product")
        cell.cartProductName.text = shoppingCartItemsList[indexPath.row].cartItemName
        cell.cartProductDescription.text = shoppingCartItemsList[indexPath.row].cartItemDescription
        cell.cartProductPrice.text = String(shoppingCartItemsList[indexPath.row].cartItemPrice).appending("$")
        cell.cartProductsCount.text = String(shoppingCartItemsList[indexPath.row].cartItemCount)
        cell.cartProductSuTotalPrice.text = String(shoppingCartItemsList[indexPath.row].cartItemSubTotal ).appending(" $")
        cell.cartProductsCount.layer.masksToBounds = true
        cell.cartProductsCount.layer.cornerRadius = 12
        cell.increaseProductItemCount.tag = indexPath.row
        cell.decreaseProductItemCount.tag = indexPath.row
        cell.increaseProductItemCount.addTarget(self, action: #selector(increaseProductsCount(sender:)), for: .touchUpInside)
        cell.decreaseProductItemCount.addTarget(self, action: #selector(decreaseProductsCount(sender:)), for: .touchUpInside)
        cell.trashFrame.layer.masksToBounds = true
        cell.trashFrame.layer.cornerRadius = cell.trashFrame.frame.size.width/2
        cell.deleteCartProduct.addTarget(self, action: #selector(print), for: .touchUpInside)
        cell.cartCellBackView.layer.cornerRadius = 20
        cell.cartCellBackView.backgroundColor = .white
        cell.cartCellBackView.layer.shadowRadius = 3
        cell.cartCellBackView.layer.shadowOpacity = 0.5
        cell.cartCellBackView.layer.shadowOffset = CGSize(width: 5, height: 5)
        return cell
        
    }
}

extension CartViewController : UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: shoppingCartCollectionView.layer.bounds.size.width-5,height: (shoppingCartCollectionView.layer.bounds.size.height/2.2)-30)
    }
}
extension CartViewController
{
    @objc func print()
    {
        Swift.print("fatma")
    }
}

struct CartItem
{
    var cartItemName : String = "Hoodie Green"
    var cartItemDescription : String = "Green Hoodie paul&pear"
    var cartItemPrice : Float = 150.00
    var cartItemCount : Int = 1
    var cartItemSubTotal : Float = 150.00
    
}
extension CartViewController
{
    @objc func increaseProductsCount(sender : UIButton)
    {
        
        if  shoppingCartItemsList[sender.tag].cartItemCount < 20
        {
            shoppingCartItemsList[sender.tag].cartItemCount = shoppingCartItemsList[sender.tag].cartItemCount + 1
            
        }
        else
        {
            shoppingCartItemsList[sender.tag].cartItemCount = 20
        }
        total += Float(shoppingCartItemsList[sender.tag].cartItemCount) * shoppingCartItemsList[sender.tag].cartItemPrice
        shoppingCartItemsList[sender.tag].cartItemSubTotal = Float(shoppingCartItemsList[sender.tag].cartItemCount) * shoppingCartItemsList[sender.tag].cartItemPrice
        subTotal.text = String(total )
            self.shoppingCartCollectionView.reloadData()
        }
    
    @objc func decreaseProductsCount(sender : UIButton)
    {
        if shoppingCartItemsList[sender.tag].cartItemCount > 1
        {
            shoppingCartItemsList[sender.tag].cartItemCount = shoppingCartItemsList[sender.tag].cartItemCount - 1
        }
        else
        {
            shoppingCartItemsList[sender.tag].cartItemCount = 1
        }
        shoppingCartItemsList[sender.tag].cartItemSubTotal = Float(shoppingCartItemsList[sender.tag].cartItemCount) * shoppingCartItemsList[sender.tag].cartItemPrice
            self.shoppingCartCollectionView.reloadData()

        }
        
    }

extension CartViewController
{
    func cartVCStyle()
    {
        StyleHelper.bgFrameStyle(frame: shoppingCartFrame)
        self.shoppingCartCollectionView.backgroundColor = UIColor(named: "thirdColor")
        self.subTotal.layer.masksToBounds = true
        self.subTotal.layer.cornerRadius = 20
        self.subTotal.bringSubviewToFront(checkout)
        self.subTotal.layer.shadowRadius = 6.0
        self.subTotal.layer.shadowOpacity = 1.0
        self.subTotal.layer.shadowColor = UIColor.red.cgColor
        self.subTotal.layer.shadowOffset = CGSize(width: 4.0, height: 4.0)
    }
}

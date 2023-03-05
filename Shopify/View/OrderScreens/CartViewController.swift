//
//  CartViewController.swift
//  Shopify
//
//  Created by Mahmoud on 21/02/2023.
//

import UIKit

class CartViewController: UIViewController {
    var cartViewModel : NetworkViewModel?
    var tempCartItemsList : [DraftOrder]?
    var shoppingCartItemsList : [DraftOrder]?
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
        Swift.print(TabBarViewController.loggedCustomer!.id)

        cartVCStyle()
        cartViewModel = NetworkViewModel()
        cartViewModel?.getCartProducts()
        cartViewModel?.bindingCartProducts = {
            DispatchQueue.main.async { [self] in
                self.shoppingCartItemsList = self.cartViewModel?.ShoppingCartProductsResult ?? []
                self.tempCartItemsList = self.cartViewModel?.ShoppingCartProductsResult ?? []
                Swift.print(tempCartItemsList?[0].created_at)
               // self.shoppingCartItemsList = self.tempCartItemsList?.filter { ($0.customer?.id) == TabBarViewController.loggedCustomer!.id }
                for item in tempCartItemsList!{
                    if item.customer!.id == TabBarViewController.loggedCustomer?.id{
                        shoppingCartItemsList?.append(item)
                    }
                }
             /*   for i in 0..<shoppingCartItemsList!.count{
                    total += (Float((shoppingCartItemsList![0].line_items![0].price)!)! * Float((shoppingCartItemsList![0].line_items![0].quantity)!))
                  }
                self.subTotal.text = String(total)//.appending(shoppingCartItemsList?[0].currency ?? "")
              */
                self.shoppingCartCollectionView.reloadData()
            }
        }
        
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
        return shoppingCartItemsList?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "shoppingCartCell", for: indexPath) as! ShoppingCartCell
        StyleHelper.cvCellStyle(cvCell: cell)
        cell.layer.masksToBounds = true
        cell.layer.cornerRadius = 30
        cell.cartProductImage.image = UIImage(named: "product")
        cell.cartProductName.text = shoppingCartItemsList?[0].line_items?[0].title
        cell.cartProductDescription.text = "Description or vendor"
        cell.cartProductPrice.text = (shoppingCartItemsList?[indexPath.row].line_items?[0].price)?.appending(" ").appending(shoppingCartItemsList?[indexPath.row].currency ?? "")
        cell.cartProductsCount.text = String((shoppingCartItemsList?[0].line_items?[0].quantity)!)
        let quantity = Float(shoppingCartItemsList?[0].line_items?[0].quantity ?? 0)
        let price = Float(shoppingCartItemsList?[0].line_items?[0].price ?? "")
        cell.cartProductSuTotalPrice.text = String(quantity * price!).appending(" ").appending(shoppingCartItemsList?[indexPath.row].currency ?? "")
        cell.cartProductsCount.layer.masksToBounds = true
        cell.cartProductsCount.layer.cornerRadius = 12
    /*  cell.increaseProductItemCount.tag = indexPath.row
        cell.decreaseProductItemCount.tag = indexPath.row
        cell.increaseProductItemCount.addTarget(self, action: #selector(increaseProductsCount(sender:)), for: .touchUpInside)
        cell.decreaseProductItemCount.addTarget(self, action: #selector(decreaseProductsCount(sender:)), for: .touchUpInside)*/
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

/*extension CartViewController
{
    @objc func increaseProductsCount(sender : UIButton)
    {
        
        if  shoppingCartItemsList?[sender.tag].cartItemCount < 20
        {
            shoppingCartItemsList?[sender.tag].cartItemCount = shoppingCartItemsList?[sender.tag].cartItemCount + 1
            
        }
        else
        {
            shoppingCartItemsList?[sender.tag].cartItemCount = 20
        }
        total += Float( shoppingCartItemsList?[sender.tag].cartItemPrice)
        shoppingCartItemsList?[sender.tag].cartItemSubTotal = Float(shoppingCartItemsList?[sender.tag].cartItemCount) * shoppingCartItemsList?[sender.tag].cartItemPrice
        subTotal.text = String(total )
            self.shoppingCartCollectionView.reloadData()
        }
    
    @objc func decreaseProductsCount(sender : UIButton)
    {
        if shoppingCartItemsList?[sender.tag].cartItemCount > 1
        {
            shoppingCartItemsList?[sender.tag].cartItemCount = shoppingCartItemsList?[sender.tag].cartItemCount - 1
        }
        else
        {
            shoppingCartItemsList[sender.tag].cartItemCount = 1
        }
        total -= Float( shoppingCartItemsList[sender.tag].cartItemPrice)

        shoppingCartItemsList[sender.tag].cartItemSubTotal = Float(shoppingCartItemsList[sender.tag].cartItemCount) * shoppingCartItemsList[sender.tag].cartItemPrice
        subTotal.text = String(total )
            self.shoppingCartCollectionView.reloadData()
        }
    }*/

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

//
//  OrderDetailsViewController.swift
//  Shopify
//
//  Created by Fatma on 27/02/2023.
//

import UIKit
import CoreData
class OrderDetailsViewController: UIViewController {

    var orderProductsList : [DraftOrder]?
    var orderSubTotal : Float?
    var homeViewModel : NetworkViewModel?
    var copounsList : [DiscountCode]?
    var flag : Bool = false
    var usedCopouns : [NSManagedObject]?
    var discountAmount : Float = 0.0
    @IBOutlet weak var orderProductsTableView: UITableView!
    {
        didSet
        {
            orderProductsTableView.dataSource = self
            orderProductsTableView.delegate = self
            let nib = UINib(nibName: "OrderDetailsCell", bundle: nil)
            orderProductsTableView.register(nib, forCellReuseIdentifier: "orderDetailsCell")
        }
    }
    @IBOutlet weak var orderSubTotalPrice: UILabel!
    @IBOutlet weak var shoppingFees: UILabel!
    @IBOutlet weak var discount: UILabel!
    @IBOutlet weak var orderTotalPrice: UILabel!
    @IBOutlet weak var enteringCopounCode: UITextField!
    @IBOutlet weak var bgFrame: UIView!
    
    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func validateCopoun(_ sender: Any) {
        for i in 0..<(copounsList?.count ?? 0)
        {
            if copounsList?[i].code == enteringCopounCode.text
            {
                flag = true
            }
        }
        if flag == true
        {
            var f : Bool?
            f = isUsedCopoun(code: enteringCopounCode.text ?? "")
            if f == true
            {
                let copounAlert : UIAlertController  = UIAlertController(title:"Copoun is used before!!", message: "", preferredStyle: .actionSheet)
                copounAlert.addAction(UIAlertAction(title: "Ok", style: .destructive, handler:{ action in
                }))
                self.present(copounAlert, animated:true, completion:nil )
            }
            else
            {
                discountAmount = ((orderSubTotal ?? 0.0) + 30.0) * 0.3
                discount.text = String(discountAmount)
                orderTotalPrice.text = String(((orderSubTotal ?? 0.0)+30.0)-discountAmount)

            }
            
        }
        else
        {
            let copounAlert : UIAlertController  = UIAlertController(title:"Copoun is not valid!!", message: "", preferredStyle: .actionSheet)
            copounAlert.addAction(UIAlertAction(title: "Ok", style: .destructive, handler:{ action in
            }))
            self.present(copounAlert, animated:true, completion:nil )
        }
    }
    
    @IBAction func placeOrder(_ sender: Any) {
        let confirmAddressVC = storyboard?.instantiateViewController(withIdentifier: "chooseAddress") as! ConfirmAddressViewController
        navigationController?.pushViewController(confirmAddressVC, animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        orderDetailsVCStyle()
        enteringCopounCode.layer.masksToBounds = true

        enteringCopounCode.layer.cornerRadius = 20
        enteringCopounCode.borderStyle = UITextField.BorderStyle(rawValue: 0)!
        orderSubTotalPrice.text = String(orderSubTotal ?? 0.0)
        homeViewModel = NetworkViewModel()
        homeViewModel?.getAds()
        homeViewModel?.bindingAds = {
            DispatchQueue.main.async {
                self.copounsList = self.homeViewModel?.adsResult?.discount_codes ?? []
                print("fatma\(self.copounsList?.count)")
            }
        }
        discount.text = String(discountAmount)
        orderTotalPrice.text = String(((orderSubTotal ?? 0.0)+30.0)-discountAmount)
    }
    override func viewWillAppear(_ animated: Bool) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Copouns")
        do{
            usedCopouns = try managedContext.fetch(fetchRequest)
        }catch let error{
            print(error.localizedDescription)

        }
    }
}
extension OrderDetailsViewController : UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orderProductsList?.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "orderDetailsCell", for: indexPath) as! OrderDetailsCell
        cell.backView.layer.masksToBounds = true
        cell.backView.layer.cornerRadius = 30
        cell.orderItemProductName.text = orderProductsList?[indexPath.row].line_items?[0].title
        cell.orderItemProductPrice.text =  orderProductsList?[indexPath.row].line_items?[0].price
        cell.orderItemImage.image = UIImage(named: "product")
        cell.orderItemProductQuantity.text =  String(orderProductsList?[indexPath.row].line_items?[0].quantity ?? 0)
        
        let price = Float(orderProductsList?[indexPath.row].line_items?[0].price ?? "")
        let quantity = Float(orderProductsList?[indexPath.row].line_items?[0].quantity ?? 0)
        cell.orderItemTotalPrice.text =  String((price ?? 0.0) * (quantity ))

        return cell
    }
}
extension OrderDetailsViewController : UITableViewDelegate
{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
}
extension OrderDetailsViewController
{
    func orderDetailsVCStyle()
    {
        StyleHelper.bgFrameStyle(frame: bgFrame)
        StyleHelper.smallLablesStyle(label: orderSubTotalPrice)
        StyleHelper.smallLablesStyle(label: shoppingFees)
        StyleHelper.smallLablesStyle(label: discount)
        StyleHelper.bigLablesStyle(label: orderTotalPrice)
    }
}

extension OrderDetailsViewController
{
    func isUsedCopoun(code : String) -> Bool
    {
        var flag : Bool?
        for i in 0..<(usedCopouns?.count ?? 0)
        {
            if usedCopouns?[i].value(forKey: "copoun_code") as! String == code
            {
                 flag = false
            }
            else
            {
                flag = true
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                let managedContext = appDelegate.persistentContainer.viewContext
                let entity = NSEntityDescription.entity(forEntityName: "Copouns", in: managedContext)
                let copoun = NSManagedObject(entity: entity!, insertInto: managedContext)
                copoun.setValue(self.enteringCopounCode.text ?? "", forKey: "copoun_code")
                copoun.setValue(true, forKey: "copoun_state")
                do{
                    try managedContext.save()
                    print("Saved!")
                }catch let error{
                    print(error.localizedDescription)
                }
            }
        }
        return flag ?? false
    }
}

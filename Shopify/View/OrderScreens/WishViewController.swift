//
//  WishViewController.swift
//  Shopify
//
//  Created by Mahmoud on 21/02/2023.
//

import UIKit
import CoreData

class WishViewController: UIViewController {
    
    var managedContext : NSManagedObjectContext!
    var savedLeagues : [NSManagedObject] = []
    var deleteLeague : NSManagedObject?
    
    @IBOutlet weak var wishV: UIView!
    
    @IBOutlet weak var wishCV: UICollectionView!
    var  tempWishListItems : [DraftOrder]?
    var  wishListItems : DraftOrders?
    var wishVM : NetworkViewModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        
    
    
        NetworkService.getShoppingCartProducts(url: "https://48c475a06d64f3aec1289f7559115a55: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@ios-q2-new-capital-admin2-2022-2023.myshopify.com/admin/api/2023-01/draft_orders.json") { DraftOrders in
            self.wishListItems = DraftOrders
            self.wishCV.reloadData()
        }
    
        
        //1
        let appDelegate  = UIApplication.shared.delegate as! AppDelegate
        //2
        let context = appDelegate.persistentContainer.viewContext
        //3
        let entity = NSEntityDescription.entity(forEntityName: "WishListProduct", in: context)
        //4
        let wishlist = NSManagedObject(entity: entity!, insertInto: context)
        
        wishCV.delegate = self
        wishCV.dataSource = self
        let nibb = UINib(nibName: "WishCollectionViewCell", bundle: nil)
        wishCV.register(nibb, forCellWithReuseIdentifier: "list")
        self.wishV.layer.masksToBounds = true
        self.wishV.layer.cornerRadius = 25.0
        self.wishCV.backgroundColor = UIColor(named: "thirdColor")
        
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
    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    /*
    private func getData(from url : String) -> DraftOrders
    {
       
        let task = URLSession.shared.dataTask(with: URL(string: url)!, completionHandler: { data, response, error in
            guard let data = data , error == nil else{
                Swift.print("Somthing Went Wrong")
                return
            }
            
            
            var result : DraftOrders?
            do {
                result = try JSONDecoder().decode(DraftOrders.self, from: data)
            }catch{
                Swift.print("failed to convert \(error.localizedDescription)")
            }
            guard let json = result else{
                return
            }
          //  print(json.first_name)
          //  print(json.email)
            Swift.print("doneeee")
            Swift.print(data.count)
        //  var  wishListItems = result
           // print(json.addresses)
          
        }
                                              return result
        )
        task.resume()
        
    }*/
    
    
}

extension WishViewController : UICollectionViewDelegate
{
  
}


extension WishViewController : UICollectionViewDataSource
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        Swift.print("\(wishListItems?.draft_orders?.count ?? 0)")
        return wishListItems?.draft_orders?.count ?? 0
       
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "list", for: indexPath) as! WishCollectionViewCell
        cell.layer.masksToBounds = true
        cell.layer.cornerRadius = 25.0
      //  cell.layer.borderColor = UIColor(named: "s")?.cgColor
      //  cell.layer.borderWidth = 8
        

        //cell.frame = cell.frame.inset(by: UIEdgeInsets(top: 10, left: 10, bottom: 50, right: 10))
        
        cell.wishImg.image = UIImage(named: "product")
        cell.wishName.adjustsFontSizeToFitWidth = true
        cell.wishName.text = wishListItems?.draft_orders?[indexPath.row].line_items?[0].title
        cell.wishDescription.text = wishListItems?.draft_orders?[indexPath.row].line_items?[0].vendor
        cell.wishPrice.text = wishListItems?.draft_orders?[indexPath.row].line_items?[0].price
        
        
        //cell.deleteBtn.addTarget(self, action: #selector(print), for: .touchUpInside)
        return cell
        
    }
}

extension WishViewController : UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        
            
        return CGSize(width: self.view.frame.width - 50, height: self.view.frame.height * 0.17)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets
    {
        
        
            return UIEdgeInsets(top: 0 , left: 25, bottom: 0, right: 25)
       
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat
    {
        return CGFloat(15)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat
    {
        return CGFloat(25)
    }
}


extension WishViewController
{
    @objc func print()
    {
        Swift.print("Aya")
    }
}
//extension WishViewController : flowlay

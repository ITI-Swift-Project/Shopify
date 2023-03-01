//
//  CatViewController.swift
//  Shopify
//
//  Created by Mahmoud on 21/02/2023.
//

import UIKit
import Floaty
class CatViewController: UIViewController {
    var viewModel : NetworkViewModel?
    var result : [Product] = []
    var floaty : Floaty?
    var flag : Int = 0
    var categoryId : URL?
    
    @IBOutlet weak var catCollection: UICollectionView!{
        didSet{
            catCollection.delegate = self
            catCollection.dataSource  = self
            
            let nib = UINib(nibName: "CatCollectionViewCell", bundle: nil)
            catCollection.register(nib, forCellWithReuseIdentifier: "catCell")
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        createFloatyButton()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        let endPoint = APIEndpoint.products
        filterDataByType(endPoint: endPoint)
    }
    
    func createFloatyButton(){
        floaty = Floaty()
        //        floaty?.tintColor = UIColor(named:"third" )
        floaty?.buttonColor = UIColor(named: "HomeCellBackground")!
        floaty?.backgroundColor = UIColor(named: "third")
        floaty?.size = CGFloat(70)
        floaty?.buttonImage = UIImage(named: "filter 2")
        
        view.addSubview(floaty!)
        let filterByPriceButton = FloatyItem()
        filterByPriceButton.title = "Price"
        
        floaty!.addItem(icon : UIImage(named: "accessories")){_ in
            // Code to execute when button 1 is tapped
            switch self.flag{
            case 0:
                let endpoint  = APIEndpoint.products
                self.getFilterResltFloatyButtonAllProuducts(endPoint: endpoint, product_type: "Accessories")
            case 1:
                let endpoint  = APIEndpoint.men
                self.getFilterResltFloatyButton(endPoint: endpoint,product_type: "Accessories")
            case 2:
                let endpoint  = APIEndpoint.wowen
                self.getFilterResltFloatyButton(endPoint: endpoint,product_type: "Accessories")
            case 3:
                let endpoint  = APIEndpoint.kids
                self.getFilterResltFloatyButton(endPoint: endpoint,product_type: "Accessories")
            case 4:
                let endpoint  = APIEndpoint.sale
                self.getFilterResltFloatyButton(endPoint: endpoint,product_type: "Accessories")
           
            default:
                break
            }
        }
        floaty!.addItem(icon : UIImage(named: "t-shirt")){_ in
            // Code to execute when button 2 is tapped
            switch self.flag{
            case 0:
                let endpoint  = APIEndpoint.products
                self.getFilterResltFloatyButtonAllProuducts(endPoint: endpoint, product_type: "T-SHIRTS")
            case 1:
                let endpoint  = APIEndpoint.men
                self.getFilterResltFloatyButton(endPoint: endpoint,product_type: "T-SHIRTS")
            case 2:
                let endpoint  = APIEndpoint.wowen
                self.getFilterResltFloatyButton(endPoint: endpoint,product_type: "T-SHIRTS")
            case 3:
                let endpoint  = APIEndpoint.kids
                self.getFilterResltFloatyButton(endPoint: endpoint,product_type: "T-SHIRTS")
            case 4:
                let endpoint  = APIEndpoint.sale
                self.getFilterResltFloatyButton(endPoint: endpoint,product_type: "T-SHIRTS")
           
            default:
                break
            }
        }
       
        floaty!.addItem(icon : UIImage(named: "shoes")){_ in
            // Code to execute when button 2 is tapped
            switch self.flag{
            case 0:
                let endpoint  = APIEndpoint.products
                self.getFilterResltFloatyButtonAllProuducts(endPoint: endpoint, product_type: "SHOES")
            case 1:
                let endpoint  = APIEndpoint.men
                self.getFilterResltFloatyButton(endPoint: endpoint,product_type: "SHOES")
            case 2:
                let endpoint  = APIEndpoint.wowen
                self.getFilterResltFloatyButton(endPoint: endpoint,product_type: "SHOES")
            case 3:
                let endpoint  = APIEndpoint.kids
                self.getFilterResltFloatyButton(endPoint: endpoint,product_type: "SHOES")
            case 4:
                let endpoint  = APIEndpoint.sale
                self.getFilterResltFloatyButton(endPoint: endpoint,product_type: "SHOES")
           
            default:
                break
            }
        }
        floaty!.paddingX = 16
        floaty!.paddingY = 100
        
        floaty!.friendlyTap = false
        
    }
   
    @IBAction func filterByMen(_ sender: Any) {
        flag = 1
        let endPoint = APIEndpoint.men
        filterDataByType(endPoint: endPoint)
        
    }
    
    @IBAction func filterByWomen(_ sender: Any) {
        flag = 2
        let endPoint = APIEndpoint.wowen
        filterDataByType(endPoint: endPoint)
    }
    @IBAction func filterByKids(_ sender: Any) {
        flag = 3
        let endPoint = APIEndpoint.kids
        filterDataByType(endPoint: endPoint)
    }
    @IBAction func filterBySale(_ sender: Any) {
        flag = 4
        let endPoint = APIEndpoint.sale
        filterDataByType(endPoint:endPoint )
    }
    
    func getFilterResltFloatyButtonAllProuducts(endPoint : APIEndpoint,product_type : String)->Void{
        let url = endPoint.urlTofiltrtion(forShopName: NetworkService.baseUrl, product_type: product_type)
        self.viewModel = NetworkViewModel()
        self.viewModel?.getProductsAt(url: url )
        self.viewModel?.bindingProducts = {
            DispatchQueue.main.async {
             
                self.result = self.viewModel!.productsResult
                print(self.result.count)
                self.catCollection.reloadData()
            }
        }
    }
    
    
    func getFilterResltFloatyButton(endPoint : APIEndpoint,product_type : String)->Void{
        let url = endPoint.urlTofiltrtionCategory(forShopName: NetworkService.baseUrl, product_type: product_type)
        self.viewModel = NetworkViewModel()
        self.viewModel?.getProductsAt(url: url )
        self.viewModel?.bindingProducts = {
            DispatchQueue.main.async {
             
                self.result = self.viewModel!.productsResult
                print(self.result.count)
                self.catCollection.reloadData()
            }
        }
    }
    
    
    
    func filterDataByType(endPoint:APIEndpoint)->Void{
        let url = endPoint.url(forShopName:NetworkService.baseUrl)
        viewModel = NetworkViewModel()
        viewModel?.getProductsAt(url: url )
        viewModel?.bindingProducts = {
            DispatchQueue.main.async {
             
                self.result = self.viewModel!.productsResult
                print(self.result.count)
                self.catCollection.reloadData()
            }
        }
    }
}
extension CatViewController : UICollectionViewDelegate
{
    
}
extension CatViewController : UICollectionViewDataSource
{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return result.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "catCell", for: indexPath) as! CateCollectionViewCell
        
        cell.configImg(name:URL(string : (result[indexPath.row].image?.src!)!)!)
        cell.configProductInfo(name: result[indexPath.row].title!, vendor: result[indexPath.row].vendor!, type: result[indexPath.row].product_type!)
//        cell.layer.borderColor   = UIColor.systemGray.cgColor
//            cell.layer.shadowOpacity = 20
//        cell.layer.borderWidth   = 3.0
        cell.layer.cornerRadius  = 25.0
        return cell
    }
    
    
}
extension CatViewController : UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width / 2 - 20, height: self.view.frame.height * 0.25)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0 , left: 10, bottom: 0, right: 10)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return CGFloat(15)
    }
    
}

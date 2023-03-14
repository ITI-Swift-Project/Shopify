//
//  CatViewController.swift
//  Shopify
//
//  Created by Mahmoud on 21/02/2023.
//

import UIKit
import Floaty
class CatViewController: UIViewController {
    var viewModel : ProductsViewModel?
    var result : [Product] = []
    var floaty : Floaty?
    var flag : Int = 0
    var categoryId : URL?
    var userdef = UserDefaults.standard
    var currencyConverter : Float = 0.0
    var currency : String?
    var coreDateViewModel : CoreDataViewModelClass!
    @IBOutlet weak var kids: UIBarButtonItem!
    
    @IBOutlet weak var sale: UIBarButtonItem!
    @IBOutlet weak var woman: UIBarButtonItem!
    @IBOutlet weak var menButton: UIBarButtonItem!
    @IBOutlet weak var catCollection: UICollectionView!{
        didSet{
            catCollection.delegate = self
            catCollection.dataSource  = self
            
            let nib = UINib(nibName: "CatCollectionViewCell", bundle: nil)
            catCollection.register(nib, forCellWithReuseIdentifier: "catCell")
        }
        
    }
    let refreshControl = UIRefreshControl()
    override func viewDidLoad() {
        super.viewDidLoad()
        catCollection.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        
        createFloatyButton()
        coreDateViewModel = CoreDataViewModelClass()
        menButton.tintColor = UIColor.white
        woman.tintColor = UIColor.white
        kids.tintColor = UIColor.white
        sale.tintColor = UIColor.white
        let endPoint = APIEndpoint.products
        filterDataByType(endPoint: endPoint)
        currencyConverter = userdef.value(forKey: "currency") as?  Float ?? 0
          if userdef.value(forKey: "currency") as? Double == 1.0
          {
              currency = "$"
          }
          else
          {
              currency = "£"
          }
          print("FA\(currencyConverter)")
    }
    
    @objc func refreshData(){
           catCollection.reloadData()
           refreshControl.endRefreshing()
       }
   
    override func viewWillAppear(_ animated: Bool) {
        self.catCollection.reloadData()
    }
    //MARK: Floaty Creation
    func createFloatyButton(){
        floaty = Floaty()
        floaty?.buttonColor = UIColor(named: "firstColor")!
        floaty?.backgroundColor = UIColor(named: "third")
        floaty?.size = CGFloat(70)
        floaty?.buttonImage = UIImage(named: "filter 2")
        
        view.addSubview(floaty!)
        let filterByPriceButton = FloatyItem()
        filterByPriceButton.title = "Price"
        
        floaty!.addItem(icon : UIImage(named: "accessories")){_ in
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
        floaty!.paddingY = 90
        
        floaty!.friendlyTap = false
        
    }
   
    @IBAction func searchAction(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "SearchStoryboard", bundle: nil)
        let searchViewController = storyBoard.instantiateViewController(withIdentifier: "search") as! SearchViewController
        searchViewController.productsArray = result
        self.navigationController?.pushViewController(searchViewController, animated: true)
    }
    //MARK: Filter By Men
    @IBAction func filterByMen(_ sender: Any) {
        menButton.tintColor = UIColor.black
        woman.tintColor = UIColor.white
        kids.tintColor = UIColor.white
        sale.tintColor = UIColor.white
        flag = 1
        let endPoint = APIEndpoint.men
        filterDataByType(endPoint: endPoint)
        
    }
    //MARK: Filter By Wemen
    @IBAction func filterByWomen(_ sender: Any) {
        menButton.tintColor = UIColor.white
        woman.tintColor = UIColor.black
        kids.tintColor = UIColor.white
        sale.tintColor = UIColor.white
        flag = 2
        let endPoint = APIEndpoint.wowen
        filterDataByType(endPoint: endPoint)
    }
    //MARK: Filter By Kids
    @IBAction func filterByKids(_ sender: Any) {
        menButton.tintColor = UIColor.white
        woman.tintColor = UIColor.white
        kids.tintColor = UIColor.black
        sale.tintColor = UIColor.white
        flag = 3
        let endPoint = APIEndpoint.kids
        filterDataByType(endPoint: endPoint)
    }
    //MARK: Filter By Style
    @IBAction func filterBySale(_ sender: Any) {
        menButton.tintColor = UIColor.white
        woman.tintColor = UIColor.white
        kids.tintColor = UIColor.white
        sale.tintColor = UIColor.black
        flag = 4
        let endPoint = APIEndpoint.sale
        filterDataByType(endPoint:endPoint )
    }
    //MARK: Fitch method
    func getFilterResltFloatyButtonAllProuducts(endPoint : APIEndpoint,product_type : String)->Void{
        let url = endPoint.urlTofiltrtion(forShopName: NetworkService.baseUrl, product_type: product_type)
        self.viewModel = ProductsViewModel()
        self.viewModel?.getProductsAt(url: url )
        self.viewModel?.bindingProducts = {
            DispatchQueue.main.async {
             
                self.result = self.viewModel!.productsResult.products ?? []
                print(self.result.count)
                self.catCollection.reloadData()
            }
        }
    }
    
    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
   
    
    func getFilterResltFloatyButton(endPoint : APIEndpoint,product_type : String)->Void{
        let url = endPoint.urlTofiltrtionCategory(forShopName: NetworkService.baseUrl, product_type: product_type)
        self.viewModel = ProductsViewModel()
        self.viewModel?.getProductsAt(url: url )
        self.viewModel?.bindingProducts = {
            DispatchQueue.main.async {
             
                self.result = self.viewModel!.productsResult .products ?? []
                print(self.result.count)
                self.catCollection.reloadData()
            }
        }
    }
    
    
    
    func filterDataByType(endPoint:APIEndpoint)->Void{
        let url = endPoint.url(forShopName:NetworkService.baseUrl)
        viewModel = ProductsViewModel()
        viewModel?.getProductsAt(url: url )
        viewModel?.bindingProducts = {
            DispatchQueue.main.async {
             
                self.result = self.viewModel!.productsResult.products ?? []
                print(self.result.count)
                self.catCollection.reloadData()
            }
        }
    }
    
    @IBAction func wishList(_ sender: Any) {
        if !(UserDefaults.standard.bool(forKey: "loginState")) 
        {
            makeAlert()
        }
        else{
            let storyBoard: UIStoryboard = UIStoryboard(name: "OrderStoryboard", bundle: nil)
            let wishListViewController = storyBoard.instantiateViewController(withIdentifier: "wishList") as! WishViewController
            self.navigationController?.pushViewController(wishListViewController, animated: true)
        }
    }
    func makeAlert()
    {
        let alert = UIAlertController(title: "", message: "please loggin or register", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okAction)
        self.present(alert, animated: true)
    }
    @IBAction func cartAction(_ sender: Any) {
        if !(UserDefaults.standard.bool(forKey: "loginState")) 
        {
            makeAlert()
        }
        else{
            let storyBoard: UIStoryboard = UIStoryboard(name: "OrderStoryboard", bundle: nil)
            let cartViewController = storyBoard.instantiateViewController(withIdentifier: "shoppingCart") as! CartViewController
            
            self.navigationController?.pushViewController(cartViewController, animated: true)
            
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

        cell.product = result[indexPath.row]
        if let urlString = result[indexPath.row].image?.src,
            let url = URL(string: urlString) {
            cell.configImg(name: url)
        }
           coreDateViewModel.checkWishListState(id: result[indexPath.row].id ?? 0)
            if coreDateViewModel.wishListState {
                cell.wishButtonOutlet.setImage(UIImage(systemName:  "heart.fill"), for: .normal)
            }else{
                cell.wishButtonOutlet.setImage(UIImage(systemName: "heart"), for: .normal)
            }

        cell.configProductInfo(name: result[indexPath.row].title!, vendor: result[indexPath.row].vendor!, price: String(Float(result[indexPath.row].variants?[0].price ?? "") ?? 0.0 * currencyConverter).appending(" ").appending(currency ?? ""))
        cell.layer.cornerRadius  = 25.0
        cell.backView.layer.cornerRadius = 30
        cell.backView.layer.shadowRadius = 3
        cell.backView.layer.shadowColor = UIColor.gray.cgColor
        cell.backView.layer.shadowOpacity = 0.8
        cell.wishButtonOutlet.tag = indexPath.row
        cell.wishButtonOutlet.addTarget(self, action: #selector(wishButton(_:)), for: .touchUpInside)
        return cell
    }
    
    
    @objc func wishButton(_ sender: UIButton) {
        
        if coreDateViewModel.wishListState {
            print("deletes")
            coreDateViewModel.deleteFromWishList(id: result[sender.tag].id ?? 0)
            sender.setImage(UIImage(systemName:  "heart"), for: .normal)
        }else{
            print("Added")
            coreDateViewModel.addToWishList(id: result[sender.tag].id ?? 0, title: result[sender.tag].title ?? "" , price:  result[sender.tag].variants?.first?.price ?? "" , quantity: result[sender.tag].variants?.first?.inventory_quantity ?? 0, image: result[sender.tag].images?.first?.src ?? "" , vendor: result[sender.tag].vendor ?? "")
            sender.setImage(UIImage(systemName:  "heart.fill"), for: .normal)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "HomeStoryboard", bundle: nil)
        let productDetailsViewController = storyBoard.instantiateViewController(withIdentifier: "productDetails") as! ProductDetailsViewController
        productDetailsViewController.product = result[indexPath.row]
        self.navigationController?.pushViewController(productDetailsViewController, animated: true)
    }
    
    
}
extension CatViewController : UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width / 2 - 20, height: self.view.frame.height * 0.33)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0 , left: 10, bottom: 0, right: 10)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return CGFloat(15)
    }
    
}

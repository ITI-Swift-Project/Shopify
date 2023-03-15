//
//  HomeViewController.swift
//  Shopify
//
//  Created by Mahmoud on 21/02/2023.
//

import UIKit
import Kingfisher
import TTGSnackbar
class HomeViewController: UIViewController {
    @IBOutlet weak var pageController: UIPageControl!
    var adsViewModel : ADsViewModel?
    var brandsViewModel : BrandsViewModel?
    var cellIndex = 0
    var timer :  Timer?
    var brandArray : [Brand] = []
    var adsList : [DiscountCode] = []
    var adsImages : [String] = ["c1","c2","c3","c4","c5","c6","c7"]
    @IBOutlet weak var adsCollection: UICollectionView!
    {
        didSet
        {
            adsCollection.dataSource = self
            adsCollection.delegate   = self
            
            let nib = UINib(nibName: "AdsCollectionViewCell", bundle: nil)
            adsCollection.register(nib, forCellWithReuseIdentifier: "AdsCell")
        }
    }
    
    @IBOutlet weak var brandCollection: UICollectionView!
    {
        didSet
        {
            brandCollection.dataSource = self
            brandCollection.delegate   = self
            
            let nib = UINib(nibName: "BrandCollectionViewCell", bundle: nil)
            brandCollection.register(nib, forCellWithReuseIdentifier: "BrandCell")
        }
    }
    let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if adsList.count == 0
        {
            adsCollection.isHidden = true
            let imgError = UIImageView(frame: CGRect(x: 100, y: 300, width: self.view.frame.width - 200 , height: 150))
            imgError.image =  UIImage(systemName: "icloud.slash")
            imgError.tintColor = .darkGray
            self.view.addSubview(imgError)
            
            let lblMsg = UILabel(frame: CGRect(x: Int(imgError.frame.minX), y: Int(imgError.frame.maxY) + 15, width: Int(imgError.frame.width) + 50, height: 30))
            lblMsg.text = "There is no Data to Display"
        //    lblMsg = .darkGray
          //  lblMsg.textAlignment = .center
            self.view.addSubview(lblMsg)
            
        }
        if brandArray.count == 0
        {
            brandCollection.isHidden = true
            let imgError = UIImageView(frame: CGRect(x: 100, y: 300, width: self.view.frame.width - 200 , height: 150))
            imgError.image =  UIImage(systemName: "icloud.slash")
            imgError.tintColor = .darkGray
            self.view.addSubview(imgError)
            
            let lblMsg = UILabel(frame: CGRect(x: Int(imgError.frame.minX), y: Int(imgError.frame.maxY) + 15, width: Int(imgError.frame.width) + 50, height: 30))
            lblMsg.text = "There is no Data to Display"
        //    lblMsg = .darkGray
          //  lblMsg.textAlignment = .center
            self.view.addSubview(lblMsg)
            
        }
        
        
        brandCollection.refreshControl = refreshControl
            refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        
      print("Login \(UserDefaults.standard.bool(forKey: "loginState"))")
      print("SignUP\(UserDefaults.standard.bool(forKey: "signUpState"))")
        
       
        self.startTimer()
    }
        @objc func refreshData(){
            brandCollection.reloadData()
            adsCollection.reloadData()
            refreshControl.endRefreshing()
        }
    override func viewWillDisappear(_ animated: Bool) {
       
        
    }
    
    func startTimer()
    {
        timer = Timer.scheduledTimer(timeInterval: 2.5, target: self, selector: #selector(toNextItem), userInfo: nil, repeats: true)
    }
    @objc
    func toNextItem(){
        if cellIndex < adsImages.count - 1
        {
            cellIndex += 1
        }
        else
        {
            cellIndex  = 0
        }
        adsCollection.scrollToItem(at: IndexPath(item: cellIndex, section: 0), at: .centeredHorizontally, animated: true)
        pageController.currentPage = cellIndex
    }
    @IBAction func wishAction(_ sender: Any) {
        if !(UserDefaults.standard.bool(forKey: "loginState")) ?? false
        {
            makeAlert()
        }
        else{
            let storyBoard: UIStoryboard = UIStoryboard(name: "OrderStoryboard", bundle: nil)
            let wishListViewController = storyBoard.instantiateViewController(withIdentifier: "wishList") as! WishViewController
            //productDetailsViewController.arrProducts = result
            self.navigationController?.pushViewController(wishListViewController, animated: true)
        }
    }
    
    @IBAction func cartAction(_ sender: Any) {
        if !(UserDefaults.standard.bool(forKey: "loginState")) ?? false
        {
            makeAlert()
        }
        else{
            let storyBoard: UIStoryboard = UIStoryboard(name: "OrderStoryboard", bundle: nil)
            let cartViewController = storyBoard.instantiateViewController(withIdentifier: "shoppingCart") as! CartViewController
            
            self.navigationController?.pushViewController(cartViewController, animated: true)
        }
    }
    
    @IBAction func searchButtonAction(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "SearchStoryboard", bundle: nil)
        let searchViewController = storyBoard.instantiateViewController(withIdentifier: "search") as! SearchViewController
        searchViewController.whereFrom = "Home"
        //productDetailsViewController.arrProducts = result
        self.navigationController?.pushViewController(searchViewController, animated: true)
    }
    
    func makeAlert()
    {
        let alert = UIAlertController(title: "", message: "please loggin or register", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okAction)
        self.present(alert, animated: true)
    }
        // Do any additional setup after loading the view.
    
    override var prefersStatusBarHidden: Bool{
        return true
    }
    override func viewWillAppear(_ animated: Bool) {
        //        let statusBar: UIView = UIApplication.shared.value(forKey: "statusBar") as! UIView
        //           if statusBar.responds(to:#selector(setter: UIView.backgroundColor)) {
        //                statusBar.backgroundColor = UIColor.blue
        //            }
        let statusBarFrame: CGRect
                if #available(iOS 13.0, *) {
                    statusBarFrame = view.window?.windowScene?.statusBarManager?.statusBarFrame ?? CGRect.zero
                } else {
                    statusBarFrame = UIApplication.shared.statusBarFrame
                }
                let statusBarView = UIView(frame: statusBarFrame)
        statusBarView.backgroundColor = .red
                view.addSubview(statusBarView)
        adsViewModel = ADsViewModel()
        brandsViewModel = BrandsViewModel()
        brandsViewModel?.getBrands()

        brandsViewModel?.bindingBrands = {
            //            print(self.homeViewModel?.brandsResult.count)
            //            print(self.homeViewModel?.brandsResult[0].id)
            DispatchQueue.main.async {
                self.brandArray = self.brandsViewModel!.brandsResult?.smart_collections ?? []
                print(self.brandArray.count)
                
                self.brandCollection.reloadData()
            }
            
        }
        adsViewModel?.getAds()
        adsViewModel?.bindingAds = {
            DispatchQueue.main.async {
                self.adsList = self.adsViewModel?.adsResult?.discount_codes ?? []
                self.pageController.numberOfPages = self.adsImages.count
                
                self.adsCollection.reloadData()
            }
        }
    }
    
}

extension HomeViewController : UICollectionViewDelegate
{
    
}
extension HomeViewController : UICollectionViewDataSource
{
    func numberOfSections(in collectionView: UICollectionView) -> Int
    {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        if collectionView == adsCollection
        {
            return adsList.count
        }
        else{
            return brandArray.count
        }
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == brandCollection
        {
            let storyBoard: UIStoryboard = UIStoryboard(name: "CatStoryboard", bundle: nil)
            let brandsViewController = storyBoard.instantiateViewController(withIdentifier: "brands") as! BrandsViewController
            brandsViewController.brandId = brandArray[indexPath.row].id
            self.navigationController?.pushViewController(brandsViewController, animated: true)
        }
        else if collectionView == adsCollection
        {
            let pasteboard = UIPasteboard.general
            pasteboard.string = adsList[indexPath.row].code
            showSnakbar(msg: "Couopn code copied to clipboard!")
             func showSnakbar(msg : String){
             let snackbar = TTGSnackbar(
                 message: msg,
                 duration: .middle
             )
             snackbar.actionTextColor = UIColor.blue
             snackbar.borderColor = UIColor.black
             snackbar.messageTextColor = UIColor.white
             snackbar.show()
            }
            print("m\(adsList[indexPath.row].code)")

        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        if collectionView == adsCollection
        {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AdsCell", for: indexPath) as! AdsCollectionViewCell
            cell.layer.borderColor   = UIColor.systemGray.cgColor
//            cell.layer.shadowOpacity = 20
            cell.layer.borderWidth   = 3.0
            cell.layer.cornerRadius  = 25.0
            var x = 7
            if indexPath.row < x
            {
                cell.configImg(name: adsImages[indexPath.row])
            }
        else if indexPath.row > x && (indexPath.row < (x + 7))
            {
                cell.configImg(name: adsImages[indexPath.row - x])
                x = x + 7
            }
            return cell
            
        }

        else
        {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BrandCell", for: indexPath) as! BrandCollectionViewCell
            cell.layer.borderColor   = UIColor(named: "secondColor")?.cgColor
//            cell.layer.shadowOpacity = 20
            cell.layer.borderWidth   = 3.0
            cell.layer.cornerRadius  = 25.0
            cell.configImg(name: URL(string: (brandArray[indexPath.row].image?.src)!)!)
            cell.configLabel(label: brandArray[indexPath.row].title ?? "")
            return cell
            
        }
    }
}

extension HomeViewController : UICollectionViewDelegateFlowLayout
{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        if collectionView == adsCollection
        {
            
            return CGSize(width: self.view.frame.width - 50, height: self.view.frame.height * 0.22)
        }
        else
        {
            return CGSize(width: self.view.frame.width / 2 - 20, height: self.view.frame.height * 0.25)
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets
    {
        if collectionView == adsCollection
        {
            return UIEdgeInsets(top: 0 , left: 25, bottom: 0, right: 25)
        }
        else
        {
            return UIEdgeInsets(top: 0 , left: 10, bottom: 0, right: 10)
        }
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

struct Fav
{
    var img : [UIImage]
}

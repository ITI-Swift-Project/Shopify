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
    var homeViewModel : NetworkViewModel?
    var brandArray : [Brand] = []
    var adsList : [DiscountCode]?
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
    override func viewDidLoad() {
        super.viewDidLoad()
        homeViewModel = NetworkViewModel()
        homeViewModel?.getBrands()
        homeViewModel?.bindingBrands = {
            //            print(self.homeViewModel?.brandsResult.count)
            //            print(self.homeViewModel?.brandsResult[0].id)
            DispatchQueue.main.async {
                self.brandArray = self.homeViewModel!.brandsResult
                print(self.brandArray.count)
                self.brandCollection.reloadData()
            }
            
        }
        homeViewModel?.getAds()
        homeViewModel?.bindingAds = {
            DispatchQueue.main.async {
                self.adsList = self.homeViewModel?.adsResult?.discount_codes ?? []
                self.adsCollection.reloadData()
            }
        }
       
    }
    override func viewWillDisappear(_ animated: Bool) {
       
        
    }
    @IBAction func wishAction(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "OrderStoryboard", bundle: nil)
        let wishListViewController = storyBoard.instantiateViewController(withIdentifier: "wishList") as! WishViewController
        //productDetailsViewController.arrProducts = result
        self.navigationController?.pushViewController(wishListViewController, animated: true)
    }
    
    @IBAction func cartAction(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "OrderStoryboard", bundle: nil)
        let cartViewController = storyBoard.instantiateViewController(withIdentifier: "shoppingCart") as! CartViewController
       
        self.navigationController?.pushViewController(cartViewController, animated: true)
    }
    @IBAction func searchButtonAction(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "SearchStoryboard", bundle: nil)
        let searchViewController = storyBoard.instantiateViewController(withIdentifier: "search") as! SearchViewController
        searchViewController.whereFrom = "Home"
        //productDetailsViewController.arrProducts = result
        self.navigationController?.pushViewController(searchViewController, animated: true)
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
            return 7
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
            pasteboard.string = adsList?[0].code
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
            cell.configImg(name: adsImages[indexPath.row] )
            return cell
            
        }

        else
        {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BrandCell", for: indexPath) as! BrandCollectionViewCell
            cell.layer.borderColor   = UIColor.systemGray.cgColor
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

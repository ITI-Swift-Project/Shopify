//
//  BrandsViewController.swift
//  Shopify
//
//  Created by Mahmoud on 26/02/2023.
//

import UIKit
import Floaty
class BrandsViewController: UIViewController {
//    @IBOutlet weak var floaty: UIButton!
    
    var brandId : Int?
    var floaty : Floaty?
    var itemsArray : [Product] = []
    var filterItems : [Product] = []
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var sliderView: UIView!{
        didSet{
            sliderView.isHidden = true
        }
    }
    @IBOutlet weak var slider: UISlider!
    var networkViewModel : BrandItemsViewModel?
    @IBOutlet weak var brandsCollection: UICollectionView!{
        didSet{
            brandsCollection.dataSource = self
            brandsCollection.delegate = self
            let nib = UINib(nibName: "CatCollectionViewCell", bundle: nil)
            brandsCollection.register(nib, forCellWithReuseIdentifier: "catCell")
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        createFloatyButton()
        brandsCollection.layer.cornerRadius = 20
       
        //MARK: Fetch Data From API
        networkViewModel = BrandItemsViewModel()
        
        networkViewModel?.getItems(brandId: brandId)
        
        
        networkViewModel?.bindingBrandItems = {
            //            print(self.homeViewModel?.brandsResult.count)
            //            print(self.homeViewModel?.brandsResult[0].id)
            DispatchQueue.main.async {
                self.itemsArray = self.networkViewModel!.brandItemsResult.products ?? []
                self.filterItems = self.itemsArray
                print(self.itemsArray.count)
                print(UserDefaults.standard.value(forKey: "userId")as? Int)
                print(UserDefaults.standard.value(forKey: "email")as? String)
                self.brandsCollection.reloadData()
            }
            
        }
       
    }
    @IBAction func searchAction(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "SearchStoryboard", bundle: nil)
        let searchViewController = storyBoard.instantiateViewController(withIdentifier: "search") as! SearchViewController
        
        searchViewController.productsArray = filterItems
        self.navigationController?.pushViewController(searchViewController, animated: true)
    }
    func createFloatyButton(){
        floaty = Floaty()
//        floaty?.tintColor = UIColor(named:"third" )
        floaty?.buttonColor = UIColor(named: "firstColor")!
        floaty?.backgroundColor = UIColor(named: "third")
        floaty?.size = CGFloat(70)
        floaty?.buttonImage = UIImage(named: "filter 2")
        
        view.addSubview(floaty!)
        
        let filterByPriceButton = FloatyItem()
        filterByPriceButton.title = "Price"
        //MARK: Price Frilter
        floaty!.addItem(icon : UIImage(systemName: "dollarsign")){_ in
                
                // Code to execute when button 1 is tapped
                if self.sliderView.isHidden
                {
                    self.sliderView.isHidden = false
                }
                else{
                    self.sliderView.isHidden = true
                    self.filterItems = self.itemsArray
                    self.brandsCollection.reloadData()
                }
          
        }
        //MARK: A-Z to Filter
        floaty!.addItem(icon : UIImage(named: "a-z")){_ in
                
                // Code to execute when button 2 is tapped
            self.filterItems = self.itemsArray.sorted(by:{ $0.title ?? "" < $1.title ?? ""})
            
                    self.brandsCollection.reloadData()
                
          
        }
        //MARK: Z-A to filter
        floaty!.addItem(icon : UIImage(named: "z-a")){_ in
                
            // Code to execute when button 3 is tapped
            self.filterItems = self.itemsArray.sorted(by:{ $0.title ?? "" > $1.title ?? ""})
            self.brandsCollection.reloadData()
                
          
        }
//        floaty!.addItem(item: button2)
        floaty!.paddingX = 16
        floaty!.paddingY = 60
        
        floaty!.friendlyTap = false
    }
    @IBAction func filterAction(_ sender: Any) {
        if sliderView.isHidden
        {
            sliderView.isHidden = false
        }
        else{
            sliderView.isHidden = true
            filterItems = itemsArray
            brandsCollection.reloadData()
        }
    }
    @IBAction func sliderMover(_ sender: UISlider) {
        priceLabel.text = "Price : " +  String(slider.value)
        filterItems = []
        for item in itemsArray{
            if Float(item.variants![0].price!)! < slider.value
            {
                filterItems.append(item)
            }
                
        }
        brandsCollection.reloadData()
    }
    
    @IBAction func dissMissScreen(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}
extension BrandsViewController : UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "HomeStoryboard", bundle: nil)
        let productDetailsViewController = storyBoard.instantiateViewController(withIdentifier: "productDetails") as! ProductDetailsViewController
        productDetailsViewController.product = filterItems[indexPath.row]
        self.navigationController?.pushViewController(productDetailsViewController, animated: true)
    }
}
extension BrandsViewController : UICollectionViewDataSource{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filterItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "catCell", for: indexPath) as! CateCollectionViewCell
        cell.configImg(name: URL(string: (filterItems[indexPath.row].image?.src!)!)!)
        cell.configProductInfo(name: filterItems[indexPath.row].title!, vendor: filterItems[indexPath.row].vendor!, price: filterItems[indexPath.row].variants?[0].price ?? "")
        cell.layer.cornerRadius  = 25.0
        cell.backView.layer.cornerRadius = 30
        cell.backView.layer.shadowRadius = 3
        cell.backView.layer.shadowColor = UIColor.gray.cgColor
        cell.backView.layer.shadowOpacity = 0.8
        return cell
    }
    
    
}
extension BrandsViewController : UICollectionViewDelegateFlowLayout
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

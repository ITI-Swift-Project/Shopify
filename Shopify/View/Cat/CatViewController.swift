//
//  CatViewController.swift
//  Shopify
//
//  Created by Mahmoud on 21/02/2023.
//

import UIKit

class CatViewController: UIViewController {
    var viewModel : NetworkViewModel?
    var result : [Product] = []
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
        let brandEndPoint = APIEndpoint.products
        let url = brandEndPoint.url(forShopName:NetworkService.baseUrl)
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
    @IBAction func filterByMen(_ sender: Any) {
        let brandEndPoint = APIEndpoint.men
        let url = brandEndPoint.url(forShopName:NetworkService.baseUrl)
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
    
    @IBAction func filterByWomen(_ sender: Any) {
        let brandEndPoint = APIEndpoint.wowen
        let url = brandEndPoint.url(forShopName:NetworkService.baseUrl)
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
    @IBAction func filterByKids(_ sender: Any) {
        let brandEndPoint = APIEndpoint.kids
        let url = brandEndPoint.url(forShopName:NetworkService.baseUrl)
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
    @IBAction func filterBySale(_ sender: Any) {
        let brandEndPoint = APIEndpoint.sale
        let url = brandEndPoint.url(forShopName:NetworkService.baseUrl)
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

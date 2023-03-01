//
//  SearchViewController.swift
//  Shopify
//
//  Created by Aya on 01/03/2023.
//

import UIKit

class SearchViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    
    @IBOutlet weak var searchCV: UICollectionView!
    {
        didSet
        {
            searchCV.delegate = self
            searchCV.dataSource = self
            let nib = UINib(nibName: "CatCollectionViewCell", bundle: nil)
            searchCV.register(nib, forCellWithReuseIdentifier: "catCell")
        }
    }
  
    var viewModel : NetworkViewModel?
    var productsArray : [Product] = []
    var productsArray2 : [Product] = []
    var whereFrom : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        if whereFrom ==  "Home"
        {
            let brandEndPoint = APIEndpoint.products
            let url = brandEndPoint.url(forShopName: NetworkService.baseUrl)
            viewModel = NetworkViewModel()
            viewModel?.getProductsAt(url: url)
            viewModel?.bindingProducts =
            {
                DispatchQueue.main.async
                {
                    self.productsArray = self.viewModel!.productsResult
                    print(self.productsArray.count)
                    self.searchCV.reloadData()
                }
            }
        }
        
        searchBar.placeholder = "Search"
        definesPresentationContext = true
      //  searchBar.searchre
        productsArray2 = productsArray
    }
}


extension SearchViewController : UICollectionViewDelegate
{
    
}
extension SearchViewController : UICollectionViewDataSource
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return productsArray2.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "catCell", for: indexPath) as! CateCollectionViewCell
        cell.configImg(name:URL(string : (productsArray2[indexPath.row].image?.src!)!)!)
        cell.configProductInfo(name: productsArray2[indexPath.row].title!, vendor: productsArray2[indexPath.row].vendor!, type: productsArray2[indexPath.row].product_type!)
        
        cell.layer.cornerRadius  = 25.0
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       
            let storyBoard: UIStoryboard = UIStoryboard(name: "CatStoryboard", bundle: nil)
            let brandsViewController = storyBoard.instantiateViewController(withIdentifier: "brands") as! BrandsViewController
            brandsViewController.brandId = productsArray2[indexPath.row].id
            self.navigationController?.pushViewController(brandsViewController, animated: true)
        }
    
    
}

extension SearchViewController : UISearchBarDelegate
{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print("aaa")
        productsArray2 = productsArray.filter({ $0 .title!.uppercased().contains(searchText.uppercased())
        })
        
    }
}
extension SearchViewController : UICollectionViewDelegateFlowLayout
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


//
//  SearchViewController.swift
//  Shopify
//
//  Created by Aya on 01/03/2023.
//

import UIKit

class SearchViewController: UIViewController {
    var coreDateViewModel = CoreDataViewModelClass()
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
  
    var viewModel : ProductsViewModel?
    var productsArray : [Product] = []
    var productsArray2 : [Product] = []
    var whereFrom : String?
    let refreshControl = UIRefreshControl()
    
 
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        coreDateViewModel = CoreDataViewModelClass()
        searchCV.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        
        if whereFrom ==  "Home"
        {
            coreDateViewModel = CoreDataViewModelClass()
            let brandEndPoint = APIEndpoint.products
            let url = brandEndPoint.url(forShopName: NetworkService.baseUrl)
            viewModel = ProductsViewModel()
            viewModel?.getProductsAt(url: url)
            viewModel?.bindingProducts =
            {
                DispatchQueue.main.async
                { [self] in
                    self.productsArray = self.viewModel!.productsResult .products ?? []
                    print(self.productsArray.count)
                    self.productsArray2 = productsArray
                    self.searchCV.reloadData()
                }
            }
        }
        else{
            productsArray2 = productsArray
            self.searchCV.reloadData()
        }
        searchBar.placeholder = "Search"
        definesPresentationContext = true
      //  searchBar.searchre
       
        print(productsArray2.count)
    }
    
    @objc func refreshData(){
        searchCV.reloadData()
        refreshControl.endRefreshing()
    }
    
    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
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
        
        if let urlString = productsArray2[indexPath.row].image?.src,
            let url = URL(string: urlString) {
            cell.configImg(name: url)
        }
        coreDateViewModel = CoreDataViewModelClass()
        coreDateViewModel.checkWishListState(id: productsArray2[indexPath.row].id ?? 0)
        print(productsArray2[indexPath.row].id ?? 0)
         if coreDateViewModel.wishListState {
             cell.wishButtonOutlet.setImage(UIImage(systemName:  "heart.fill"), for: .normal)
         }else{
             cell.wishButtonOutlet.setImage(UIImage(systemName: "heart"), for: .normal)
         }
        cell.configProductInfo(name: productsArray2[indexPath.row].title!, vendor: productsArray2[indexPath.row].vendor!, price: productsArray2[indexPath.row].variants?[0].price ?? "")
        cell.layer.cornerRadius  = 25.0
        cell.layer.cornerRadius  = 25.0
        cell.backView.layer.cornerRadius = 30
        cell.backView.layer.shadowRadius = 3
        cell.backView.layer.shadowColor = UIColor.gray.cgColor
        cell.backView.layer.shadowOpacity = 0.8
        cell.wishButtonOutlet.tag = indexPath.row
        cell.wishButtonOutlet.addTarget(self, action: #selector(wishButton(_:)), for: .touchUpInside)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       
        let storyBoard: UIStoryboard = UIStoryboard(name: "HomeStoryboard", bundle: nil)
        let productDetailsViewController = storyBoard.instantiateViewController(withIdentifier: "productDetails") as! ProductDetailsViewController
        productDetailsViewController.product = productsArray2[indexPath.row]
        self.navigationController?.pushViewController(productDetailsViewController, animated: true)
        }
    @objc func wishButton(_ sender: UIButton) {
        
        if coreDateViewModel.wishListState {
            print("deletes")
            coreDateViewModel.deleteFromWishList(id: productsArray2[sender.tag].id ?? 0)
            sender.setImage(UIImage(systemName:  "heart"), for: .normal)
        }else{
            print("Added")
            coreDateViewModel.addToWishList(id: productsArray2[sender.tag].id ?? 0, title: productsArray2[sender.tag].title ?? "" , price:  productsArray2[sender.tag].variants?.first?.price ?? "" , quantity: productsArray2[sender.tag].variants?.first?.inventory_quantity ?? 0, image: productsArray2[sender.tag].images?.first?.src ?? "" , vendor: productsArray2[sender.tag].vendor ?? "")
            sender.setImage(UIImage(systemName:  "heart.fill"), for: .normal)
        }
    }
    
}

extension SearchViewController : UISearchBarDelegate
{
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if(searchText == "")
        {
            productsArray2 = productsArray
        }
        else
        {
            productsArray2 = []
            print("aaa")
            productsArray2 = productsArray.filter({ $0 .title!.uppercased().contains(searchText.uppercased())
            })
            
        }
        searchCV.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
            searchBar.endEditing(true)
        }
    
}
extension SearchViewController : UICollectionViewDelegateFlowLayout
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


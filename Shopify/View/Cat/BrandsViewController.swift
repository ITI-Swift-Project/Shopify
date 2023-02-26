//
//  BrandsViewController.swift
//  Shopify
//
//  Created by Mahmoud on 26/02/2023.
//

import UIKit

class BrandsViewController: UIViewController {
    var brandId : Int?
    var itemsArray : [Product] = []
    var brandItemsViewModel : BrandItemsViewModel?
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
        brandItemsViewModel = BrandItemsViewModel()
        brandItemsViewModel?.brandId = brandId!
        brandItemsViewModel?.getItems()
        
        
        brandItemsViewModel?.bindingBrandItems = {
            //            print(self.homeViewModel?.brandsResult.count)
            //            print(self.homeViewModel?.brandsResult[0].id)
            DispatchQueue.main.async {
                self.itemsArray = self.brandItemsViewModel!.brandItemsResult
                print(self.itemsArray.count)
                self.brandsCollection.reloadData()
            }
            
        }
       
    }
    

}
extension BrandsViewController : UICollectionViewDelegate{
    
}
extension BrandsViewController : UICollectionViewDataSource{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return itemsArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "catCell", for: indexPath) as! CateCollectionViewCell
        cell.configImg(name: "Hodie")
        cell.confirstLabel(name: itemsArray[indexPath.row].title!)
        cell.layer.cornerRadius  = 25.0
        return cell
    }
    
    
}
extension BrandsViewController : UICollectionViewDelegateFlowLayout
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

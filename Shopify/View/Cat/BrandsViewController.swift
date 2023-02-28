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
    var filterItems : [Product] = []
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var sliderView: UIView!{
        didSet{
            sliderView.isHidden = true
        }
    }
    @IBOutlet weak var slider: UISlider!
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
        brandItemsViewModel?.brandId = brandId ?? 0
        brandItemsViewModel?.getItems()
        
        
        brandItemsViewModel?.bindingBrandItems = {
            //            print(self.homeViewModel?.brandsResult.count)
            //            print(self.homeViewModel?.brandsResult[0].id)
            DispatchQueue.main.async {
                self.itemsArray = self.brandItemsViewModel!.brandItemsResult
                self.filterItems = self.itemsArray
                print(self.itemsArray.count)
                self.brandsCollection.reloadData()
            }
            
        }
       
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
        cell.confirstLabel(name: filterItems[indexPath.row].title!)
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

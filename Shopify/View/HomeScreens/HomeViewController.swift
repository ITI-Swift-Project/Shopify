//
//  HomeViewController.swift
//  Shopify
//
//  Created by Mahmoud on 21/02/2023.
//

import UIKit

class HomeViewController: UIViewController {
    @IBOutlet weak var AdsCollection: UICollectionView!
    
    
    var imgsFav = [UIImage(named: "temp"), UIImage(named: "temp"), UIImage(named: "temp")]
    
    var arrFav = [Fav]()
    
    //var savedFav = []
    override func viewDidLoad() {
        super.viewDidLoad()
        AdsCollection.dataSource = self
        AdsCollection.delegate = self

        let nib = UINib(nibName: "AdsCollectionViewCell", bundle: nil)
        AdsCollection.register(nib, forCellWithReuseIdentifier: "AdsCell")
        // Do any additional setup after loading the view.
    }
    

}
extension HomeViewController : UICollectionViewDelegate
{
    
}
extension HomeViewController : UICollectionViewDataSource
{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AdsCell", for: indexPath) as! AdsCollectionViewCell
        cell.layer.borderColor = UIColor.systemGray.cgColor
        cell.layer.borderWidth = 3.0
        cell.layer.cornerRadius = 25.0
        cell.configImg(name: "tmp")
        cell.fav.tag = indexPath.row
        return cell
    }
    override func viewWillAppear(_ animated: Bool) {
        if arrFav.count == 0
        {
            
        }
    }
    
}

extension HomeViewController : UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        return CGSize(width: self.view.frame.width - 50, height: self.view.frame.height*0.22)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0 , left: 25, bottom: 0, right: 25)

    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return CGFloat(15)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return CGFloat(25)
    }
}

struct Fav
{
    var img : [UIImage]
}

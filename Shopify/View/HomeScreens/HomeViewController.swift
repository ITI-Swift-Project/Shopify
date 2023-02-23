//
//  HomeViewController.swift
//  Shopify
//
//  Created by Mahmoud on 21/02/2023.
//

import UIKit

class HomeViewController: UIViewController {
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
        
        // Do any additional setup after loading the view.
    }
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
        return 10
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
            cell.configImg(name: "coupon")
            return cell
            
        }

        else
        {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BrandCell", for: indexPath) as! BrandCollectionViewCell
            cell.layer.borderColor   = UIColor.systemGray.cgColor
//            cell.layer.shadowOpacity = 20
            cell.layer.borderWidth   = 3.0
            cell.layer.cornerRadius  = 25.0
            cell.configImg(name: "tmpBrand")
            cell.configLabel(label: "Nike")
            return cell
            
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        if arrFav.count == 0
        {
            
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

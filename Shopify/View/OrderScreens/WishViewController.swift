//
//  WishViewController.swift
//  Shopify
//
//  Created by Mahmoud on 21/02/2023.
//

import UIKit

class WishViewController: UIViewController {
    
    @IBOutlet weak var wishV: UIView!
    
    @IBOutlet weak var wishCV: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        wishCV.delegate = self
        wishCV.dataSource = self
        let nibb = UINib(nibName: "WishCollectionViewCell", bundle: nil)
        wishCV.register(nibb, forCellWithReuseIdentifier: "list")
        self.wishV.layer.masksToBounds = true
        self.wishV.layer.cornerRadius = 30
        self.wishCV.backgroundColor = UIColor(named: "thirdColor")
        
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
  
    
}

extension WishViewController : UICollectionViewDelegate
{
  
}


extension WishViewController : UICollectionViewDataSource
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "list", for: indexPath) as! WishCollectionViewCell
        cell.layer.masksToBounds = true
        cell.layer.cornerRadius = 30
      //  cell.layer.borderColor = UIColor(named: "s")?.cgColor
      //  cell.layer.borderWidth = 8
        

        //cell.frame = cell.frame.inset(by: UIEdgeInsets(top: 10, left: 10, bottom: 50, right: 10))
        
        cell.wishImg.image = UIImage(named: "product")
        cell.wishName.text = "Hoodie Green"
        cell.wishDescription.text = "Green Hoodie paul&pear"
        cell.wishPrice.text = "150.00".appending("$")
        
        
        cell.deleteBtn.addTarget(self, action: #selector(print), for: .touchUpInside)
        return cell
        
    }
}

extension WishViewController : UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width:  wishCV.layer.bounds.size.width-5,height: ( wishCV.layer.bounds.size.height/2.5)-30)
    }
}

extension WishViewController
{
    @objc func print()
    {
        Swift.print("Aya")
    }
}
//extension WishViewController : flowlay

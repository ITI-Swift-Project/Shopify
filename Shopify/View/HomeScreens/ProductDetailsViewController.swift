//
//  ProductDetailsViewController.swift
//  Shopify
//
//  Created by Mahmoud on 21/02/2023.
//

import UIKit

class ProductDetailsViewController: UIViewController , UICollectionViewDelegate , UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    var arrProducts : Product? 
    
    var arrImgs = [UIImage(named: "product")!, UIImage(named: "tmp")!, UIImage(named: "tmpBrand")]
    var arrReviews : [Reviews] = [Reviews(img: UIImage(named: "review1")!, name: "Anedrew", reviewTxt: "Very Good"), Reviews(img: UIImage(named: "review2")!, name: "Sandra", reviewTxt: "Good"), Reviews(img: UIImage(named: "review3")!, name: "John", reviewTxt: "Nice"), Reviews(img: UIImage(named: "review4")!, name: "Leli", reviewTxt: "Very Good")]
    var timer :  Timer?
    var currentCellIndex  = 0
    
    @IBOutlet weak var reviewCV: UICollectionView!
    
    
    @IBOutlet weak var favBtn: UIButton!
    
    @IBOutlet weak var myscroll: UIScrollView!
    
    
    
    @IBOutlet weak var imgsCV: UICollectionView!
    
    @IBOutlet weak var txtView: UITextView!
    
    @IBOutlet weak var pageController: UIPageControl!
    @IBOutlet weak var productV: UIView!
    
    @IBOutlet weak var priceLbl: UILabel!
    
    @IBOutlet weak var addcartLbl: UILabel!
    
    @IBOutlet weak var cartBtn: UIButton!
    
    @IBOutlet weak var size1: UILabel!
    
    @IBOutlet weak var size2: UILabel!
    
    @IBOutlet weak var size3: UILabel!
    
    @IBOutlet weak var size4: UILabel!
    
    @IBOutlet weak var color1: UILabel!
    
    @IBOutlet weak var color2: UILabel!
    
    @IBOutlet weak var color3: UILabel!
    
    @IBOutlet weak var color4: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view.
        
        
        myscroll.contentSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height + 210)
        imgsCV.delegate = self
        imgsCV.dataSource = self
        reviewCV.dataSource = self
        reviewCV.delegate = self
        pageController.numberOfPages = arrImgs.count
        startTimer()
      //  txtView.layer.cornerRadius = txtView.frame.size.height / 2
      // txtView.clipsToBounds = true
        txtView.isEditable = false
        myscroll.layer.cornerRadius = myscroll.frame.size.height / 9
       myscroll.clipsToBounds = true
        
        cartBtn.layer.cornerRadius = cartBtn.frame.size.height / 2
        cartBtn.clipsToBounds = true
        
        priceLbl.layer.cornerRadius = priceLbl.frame.size.height / 2
       priceLbl.clipsToBounds = true
        
        addcartLbl.layer.cornerRadius = addcartLbl.frame.size.height / 2
       addcartLbl.clipsToBounds = true
        
        
        size1.layer.cornerRadius = size1.frame.size.height / 3
      size1.clipsToBounds = true
        
        size2.layer.cornerRadius = size2.frame.size.height / 2
      size2.clipsToBounds = true
        
        size3.layer.cornerRadius = size3.frame.size.height / 2
      size3.clipsToBounds = true
        
        size4.layer.cornerRadius = size4.frame.size.height / 2
      size4.clipsToBounds = true
        
        color1.layer.cornerRadius = color1.frame.size.height / 2
      color1.clipsToBounds = true
        color2.layer.cornerRadius = color2.frame.size.height / 2
      color2.clipsToBounds = true
        color3.layer.cornerRadius = color3.frame.size.height / 2
      color3.clipsToBounds = true
        color4.layer.cornerRadius = color4.frame.size.height / 2
      color4.clipsToBounds = true
    }
    func startTimer()
    {
        timer = Timer.scheduledTimer(timeInterval: 2.5, target: self, selector: #selector(moveToNextIndex), userInfo: nil, repeats: true)
    }
    
  @objc  func moveToNextIndex()
    {
        if currentCellIndex < arrImgs.count - 1
        {
            currentCellIndex += 1
        }
        else
        {
            currentCellIndex  = 0
        }
       // currentCellIndex += 1
        imgsCV.scrollToItem(at: IndexPath(item: currentCellIndex, section: 0), at: .centeredHorizontally, animated: true)
        pageController.currentPage = currentCellIndex
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == imgsCV
        {
            return (arrProducts?.images?.count)!
        }
        return (arrProducts?.images!.count)!
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == imgsCV
        {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "productDetailsCell", for: indexPath) as! ProductDetailsCollectionViewCell
           // cell.productDetailsImg(name: URL(string: (arrProducts[indexPath.row])))
            cell.productDetailsImg.kf.setImage(with: URL(string: ((arrProducts?.images?[indexPath.row])?.src!)!))
            return cell
            
           // cell.productDetailsImg(name:URL(string : (arrProducts[indexPath.row].images!)))
           // return cell
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "reviewCell", for: indexPath) as! ReviewCollectionViewCell
        let rev = arrReviews[indexPath.row]
        cell.setReview(img: rev.img, name: rev.name, txt: rev.reviewTxt)
        return cell
    }
    
    

    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: imgsCV.frame.width, height: imgsCV.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        //spacing between cells
        return 0
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func backAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}

struct Reviews
{
    let img : UIImage
    let name : String
    let reviewTxt : String
    
}


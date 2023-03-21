//
//  ProductDetailsViewController.swift
//  Shopify
//
//  Created by Mahmoud on 21/02/2023.
//

import UIKit
import Cosmos
import CoreData

class ProductDetailsViewController: UIViewController {
    
    var userdef = UserDefaults.standard
    var coreDateViewModel : CoreDataViewModelClass!
    var currencyConverter : Float = 0.0
    var currency : String?
    var product : Product = Product()
    var arrReviews : [Reviews] = [Reviews(img: "review1", name: "Salma", reviewTxt: "Very Good Very Good Very Good"), Reviews(img: "review2", name: "Sandra", reviewTxt: "Good"), Reviews(img:  "review3", name: "Emelia", reviewTxt: "Nice"), Reviews(img: "review4", name: "Leli", reviewTxt: "Very Good")]
    var timer :  Timer?
    var currentCellIndex  = 0
    
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productDiscription: UITextView!
    @IBOutlet weak var productSize: UILabel!
    @IBOutlet weak var productColor: UILabel!
    @IBOutlet weak var pageController: UIPageControl!
    @IBOutlet weak var priceLbl: UILabel!
    @IBOutlet weak var favbtn: UIButton!
    @IBOutlet weak var reviewsTableView: UITableView!{
        didSet{
            reviewsTableView.dataSource = self
            reviewsTableView.delegate = self
            let nib = UINib(nibName: "ProductReviewsCell", bundle: nil)
            reviewsTableView.register(nib, forCellReuseIdentifier: "productReviews")
        }
    }
    @IBOutlet weak var imgsCV: UICollectionView!{
        didSet{
            imgsCV.delegate = self
            imgsCV.dataSource = self
            let nib = UINib(nibName: "ProductImagesCell", bundle: nil)
            imgsCV.register(nib, forCellWithReuseIdentifier: "productImage")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        coreDateViewModel = CoreDataViewModelClass()
        self.checkWishListState()
        self.checkCartState()
        startTimer()
     //   productName.adjustsFontSizeToFitWidth = true
        productName.text = product.title ?? ""
        productDiscription.text = product.body_html ?? ""
        productSize.text = product.variants?[0].option1
        productColor.text = product.variants?[0].option2
        priceLbl.text = "  ".appending(product.variants?[0].price ?? "")
        pageController.numberOfPages = product.images?.count ?? 0
        productDiscription.isEditable = false
        priceLbl.layer.cornerRadius = 25
        priceLbl.clipsToBounds = true
    }
    @IBAction func addProductToCart(_ sender: Any) {
        if coreDateViewModel.cartState {
            let alert : UIAlertController = UIAlertController(title: "", message: "This Product is already in your cart", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "ok", style: .cancel, handler: nil))
            self.present(alert, animated: true , completion: nil)
        }else{
            coreDateViewModel.addToCart(id: product.id ?? 0, title: product.title ?? "" , price: product.variants?.first?.price ?? "" , quantity: 1, image: product.images?.first?.src ?? "" , vendor: product.vendor ?? "" ,inventory :product.variants?.first?.inventory_quantity ?? 0 )
        }
    }
    @IBAction func favvBtn(_ sender: Any) {
        if coreDateViewModel.wishListState {
            let alert : UIAlertController = UIAlertController(title: "Delete From Wish List", message: "Are you sure you want to delete this product from wish list?", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Yes", style: .default , handler: { [self]action in
                coreDateViewModel.deleteFromWishList(id: product.id ?? 0)
                favbtn.setImage(UIImage(systemName: "heart"), for: .normal)
            }))
            alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
            self.present(alert, animated: true , completion: nil)
        }else{
            coreDateViewModel.addToWishList(id: product.id ?? 0, title: product.title ?? "" , price: product.variants?.first?.price ?? "" , quantity: product.variants?.first?.inventory_quantity ?? 0, image: product.images?.first?.src ?? "" , vendor: product.vendor ?? "")
            favbtn.setImage(UIImage(systemName:  "heart.fill"), for: .normal)
        }
    }
    @IBAction func backAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}

extension ProductDetailsViewController :  UICollectionViewDataSource ,UICollectionViewDelegate
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return product.images?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "productImage", for: indexPath) as! ProductImagesCell
        cell.productImage.kf.setImage(with: URL(string: ((product.images?[indexPath.row])?.src ?? "")))
            return cell
    }
}

extension ProductDetailsViewController : UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        return CGSize(width: self.view.frame.width - 50, height: self.view.frame.height * 0.17)
    }
}

extension ProductDetailsViewController : UITableViewDataSource , UITableViewDelegate
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "productReviews", for: indexPath) as! ProductReviewsCell
        cell.reviewerName.text = arrReviews[indexPath.row].name
        cell.reviewerImage.image = UIImage(named: arrReviews[indexPath.row].img)
        cell.review.text = arrReviews[indexPath.row].reviewTxt
        cell.reviewerImage.clipsToBounds = true
        cell.reviewerImage.layer.cornerRadius = cell.reviewerImage.frame.height/2
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 125
    }
}

//MARK: - WishList

extension ProductDetailsViewController
{
    func checkWishListState(){
        if coreDateViewModel.checkWishListState(id: product.id ?? 0) {
            favbtn.setImage(UIImage(systemName:  "heart.fill"), for: .normal)
        }else{
            favbtn.setImage(UIImage(systemName: "heart"), for: .normal)
        }
    }
    func checkCartState(){
        coreDateViewModel.checkCartState(id: product.id ?? 0)
    }
    func startTimer()
    {
        timer = Timer.scheduledTimer(timeInterval: 2.5, target: self, selector: #selector(moveToNextIndex), userInfo: nil, repeats: true)
    }
    
    @objc  func moveToNextIndex()
    {
        if currentCellIndex < (product.images?.count ?? 0) - 1
        {
            currentCellIndex += 1
        }
        else
        {
            currentCellIndex  = 0
        }
        imgsCV.scrollToItem(at: IndexPath(item: currentCellIndex, section: 0), at: .centeredHorizontally, animated: true)
        pageController.currentPage = currentCellIndex
    }
    struct Reviews
    {
        let img : String
        let name : String
        let reviewTxt : String
    }
}


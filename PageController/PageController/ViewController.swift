//
//  ViewController.swift
//  PageController
//
//  Created by Nivedita Gupta on 27/07/18.
//  Copyright © 2018 Nivedita Gupta. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var collectionViewPageController: UICollectionView!
    
    var imagesArray = ["1","2","3","4","5"]
    
    
    //MARK:- View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pageControl.numberOfPages = imagesArray.count
        Timer.scheduledTimer(timeInterval: 4.0, target: self, selector: #selector(ViewController.scrollAutomatically), userInfo: nil, repeats: true)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    //MARK- Timer Method
    
    @objc func scrollAutomatically(_ timer1: Timer) {
        
        if let collectionView  = collectionViewPageController {
            for cell in collectionView.visibleCells {
                let indexPath: IndexPath? = collectionView.indexPath(for: cell)
                if ((indexPath?.row)!  < imagesArray.count - 1){
                    let indexPath1: IndexPath?
                    indexPath1 = IndexPath.init(row: (indexPath?.row)! + 1, section: (indexPath?.section)!)
                    collectionView.scrollToItem(at: indexPath1!, at: .right, animated: true)
                    pageControl.currentPage = indexPath1!.row
                }
                else{
                    let indexPath1: IndexPath?
                    indexPath1 = IndexPath.init(row: 0, section: (indexPath?.section)!)
                    collectionView.scrollToItem(at: indexPath1!, at: .left, animated: true)
                    pageControl.currentPage = indexPath1!.row
                }
            }
        }
    }
    
    //MARK:- Memory Management Methods
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK:- ScrollView Delegate Method
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageWidth = collectionViewPageController.frame.size.width
        let fractionalPage = collectionViewPageController.contentOffset.x / pageWidth
        let page = lround(Double(fractionalPage))
        pageControl.currentPage = page
    }
    
    //MARK:- UICollectionViewDatasource Methods
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imagesArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PageControllerCollectionViewCell", for: indexPath) as! PageControllerCollectionViewCell
        
        cell.cellImageView.image = UIImage(named: imagesArray[indexPath.row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width, height: collectionView.frame.size.height)
    }
    
    
}


//
//  onBoardingVC.swift
//  Elkenany-Project
//
//  Created by عبدالعزيز رضا  on 11/21/21.
//

import UIKit

class onBoardingVC: UIViewController {

   
    var slider:[onboardingData] = onboardingData.onBoardingSlider
    @IBOutlet weak var SplashCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        configuerUI()

    }
    
    private func configuerUI(){
        let layout = UICollectionViewFlowLayout()
        SplashCollectionView.collectionViewLayout  = layout
        SplashCollectionView.delegate = self
        SplashCollectionView.dataSource = self
        SplashCollectionView.register(UINib(nibName: "onBoardingCell", bundle: nil), forCellWithReuseIdentifier:"onBoardingCell")
        SplashCollectionView.contentInsetAdjustmentBehavior = .never
        SplashCollectionView.isPagingEnabled = true
        layout.scrollDirection = .vertical
    }
    
    
    private func handlingActionWithIndexpath(at indexpath: IndexPath){
        if indexpath.item == slider.count - 1 {
            showHomeVc()
        }else{
            
            let index = indexpath.item + 1
            let nextitem = IndexPath(item: index, section: 0)
            SplashCollectionView.scrollToItem(at: nextitem, at: .top, animated: true)
        }
        
    }
    
    private func showHomeVc() {
        let HomeVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "LoginVC")
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene ,
           let sceneDeleget = windowScene.delegate as? SceneDelegate,
           let window = sceneDeleget.window{
            window.rootViewController = HomeVC
            UIView.transition(with: window, duration: 0.25, options: .transitionCrossDissolve, animations: nil, completion: nil)
        }
        
    }
}


extension onBoardingVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return slider.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "onBoardingCell", for: indexPath) as! onBoardingCell
       
        let slides = slider[indexPath.item]
        cell.configuerSlide(slide: slides)
        cell.actionBtnDidTap = { [weak self] in
            self?.handlingActionWithIndexpath(at: indexPath)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: collectionView.bounds.height)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

    





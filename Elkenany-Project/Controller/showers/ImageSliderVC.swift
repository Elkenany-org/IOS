//
//  ImageSliderVC.swift
//  Elkenany-Project
//
//  Created by عبدالعزيز رضا  on 6/2/22.
//

import UIKit

class ImageSliderVC: UIViewController {
    
    
    //MARK: Outlets and Vars
    @IBOutlet weak var sliderImage: UICollectionView!
    @IBOutlet weak var pageControle: UIPageControl!
    var showModel:ShoweModel?
    var timer:Timer?
    var startIndex: Int! = 1
    var currentIndex = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        SliderService()
        handelTap()
    }
    
    
    fileprivate func setupUI() {
        sliderImage.dataSource = self
        sliderImage.delegate = self
        self.sliderImage.register(UINib(nibName: "sliderCellShow", bundle: nil), forCellWithReuseIdentifier: "sliderCellShow")
    }
    
    
    //Tap Guister
    func handelTap() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(closePop))
        view.addGestureRecognizer(tap)
    }
    
    @objc func closePop(){
        dismiss(animated: true)
    }
    
    
    //MARK:- Timer of slider and page controller ?? 0 -1
    func setTimer(){
        timer = Timer.scheduledTimer(timeInterval: 10, target: self, selector: #selector(MoveToNextIndex), userInfo: nil, repeats: true)
    }
    
    @objc func MoveToNextIndex(){
        if currentIndex < showModel?.data?.images?.count ?? 0 {
            currentIndex += 1
        }else{
            currentIndex = 0
        }
        sliderImage.scrollToItem(at: IndexPath(item: currentIndex, section: 0), at: .centeredHorizontally, animated: true)
        pageControle.currentPage = currentIndex
    }
    
    
    //MARK:- featch data from servier
    func SliderService(){
        let idShow = UserDefaults.standard.string(forKey: "IDDD") ?? ""
        let parm = ["id" : "\(idShow)"]
        DispatchQueue.global(qos: .background).async {
            let url = "https://elkenany.com/api/showes/one-show/?id="
            APIServiceForQueryParameter.shared.fetchData(url: url, parameters: parm, headers: nil, method: .get) { (success:ShoweModel?, filier:ShoweModel?, error) in
                if let error = error{
                    //internet error
                    print("============ error \(error)")
                    
                }
                else if let loginError = filier {
                    //Data Wrong From Server
                    print("--========== \(loginError.error?.localizedCapitalized ?? "") ")
                }
                else {
                    guard let success = success else {return}
                    self.showModel = success
                    DispatchQueue.main.async {
                        self.sliderImage.reloadData()
                    }
                }
            }
        }
    }
    
    
    //MARK:Dismiss
    @IBAction func dismisss(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}


//MARK:- handeling collection view service

extension ImageSliderVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    //count
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return showModel?.data?.images?.count ?? 0
    }
    
    
    //confguier
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell1 = collectionView.dequeueReusableCell(withReuseIdentifier: "sliderCellShow", for: indexPath) as! sliderCellShow
        let image = showModel?.data?.images?[indexPath.item].image ?? ""
        cell1.configureImage(image: image)
        return cell1
    }
    
    
    //width and height
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width , height: collectionView.frame.height)
    }
    
}

//
//  HomeSceneViewController.swift
//  DeliveryApp
//
// Create by Johnny Owayed
//

import UIKit
import SDWebImage

protocol HomeScenePresenterOutput: AnyObject {
    func presenter(didRetreiveImageUrls imageUrls: [URL])
}

final class HomeSceneViewController: UIViewController {
    var interactor: HomeSceneInteractor?
    var router: HomeSceneRouter?
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    var imageURLs = [URL]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Delivery App"
        
        self.setup()
        self.registerNib()
        self.setupUI()
        self.interactor?.viewDidLoad()
        self.router?.setupBottomSheet()
    }
    
    func setupUI() {
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
        self.view.backgroundColor = .systemBackground
        
        let flowLayout = UICollectionViewFlowLayout()
        let width = UIScreen.main.bounds.width
        let height = self.collectionView.frame.height
        let statusBarHeight = UIApplication.shared.statusBarFrame.height
        flowLayout.itemSize = CGSize(width: width, height: height + statusBarHeight)
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.minimumLineSpacing = 0
        flowLayout.scrollDirection = .horizontal
        
        self.collectionView?.collectionViewLayout = flowLayout
        self.collectionView.isPagingEnabled = true
        self.pageControl.size(forNumberOfPages: 3)
        self.setuptimer()
    }
    
    func registerNib() {
        self.collectionView.register(UINib.init(nibName: "ImageCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "Cell")
    }
    
    // MARK: Auto Scrolling with 3s Timer
    
    func setuptimer() {
        let _ = Timer.scheduledTimer(timeInterval: 3, target: self , selector:#selector(startScrolling), userInfo: nil, repeats: true)
    }
    
    @objc func startScrolling() {
        
        if pageControl.currentPage == pageControl.numberOfPages - 1 {
            pageControl.currentPage = 0
        } else {
            pageControl.currentPage += 1
        }
        self.collectionView.isPagingEnabled = false
        self.collectionView.scrollToItem(at: IndexPath(row: pageControl.currentPage, section: 0), at: .right, animated: true)
        self.collectionView.isPagingEnabled = true
    }
}

extension HomeSceneViewController: HomeScenePresenterOutput {
    func presenter(didRetreiveImageUrls imageUrls: [URL]) {
        self.imageURLs = imageUrls
        self.collectionView.reloadData()
    }
}

extension HomeSceneViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! ImageCollectionViewCell
        cell.imageView.sd_setImage(with: imageURLs[indexPath.row], placeholderImage: UIImage(named: "placeholder.png"))
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        self.pageControl.currentPage = indexPath.row
    }
}

//MARK: Setup Clean Code Design Pattern

extension HomeSceneViewController {
    func setup() {
        let viewController = self
        let interactor = HomeSceneInteractorImplementation()
        let presenter = HomeScenePresenterImplementation()
        let router = HomeSceneRouterImplementation()
        let worker = MockHomeSceneWorkerImplementation()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        interactor.worker = worker
        presenter.viewController = viewController
        router.navigationController = viewController.navigationController
        router.source = viewController
    }
}

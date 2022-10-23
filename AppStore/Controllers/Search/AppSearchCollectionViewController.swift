//
//  AppSearchCollectionViewController.swift
//  AppStore
//
//  Created by Toga on 6/9/22.
//
import SDWebImage
import UIKit


class AppSearchCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {
    
    fileprivate let identifier = "cellID"
    fileprivate var searchResults = [Result]()
    fileprivate var searchController = UISearchController()
    fileprivate var timer: Timer?
    fileprivate var enterSearchLabel: UILabel = {
        let label = UILabel()
        label.text = "Please enter search item above"
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.register(SearchAppCell.self, forCellWithReuseIdentifier: identifier)
        
        createSearchController()
        
        collectionView.addSubview(enterSearchLabel)
        enterSearchLabel.fillSuperview(padding: .init(top: 50, left: 50, bottom: 0, right: 50))
        
        
    }
    
//    MARK: SearchBar
    fileprivate func createSearchController() {
        searchController = UISearchController(searchResultsController: nil)
        self.navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.searchBar.delegate = self
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 0.3, repeats: false, block: { (_) in
            //    MARK: JSon
            Service.shared.fetchApps(searchString: searchText) { (res) in
                self.searchResults = res.results
                DispatchQueue.main.sync {
                    self.collectionView.reloadData()
                }
            }
        })
    }
    
    override func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        searchController.searchBar.endEditing(true)
    }
        
//    MARK: UICollectionViewDelegateFlowLayout - size for cell
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 350)
    }
    
//    MARK: //    MARK:  numberOfItemsInSection, cellForItemAt

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        enterSearchLabel.isHidden = searchResults.count != 0
        return searchResults.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as? SearchAppCell {
            let appResult = searchResults[indexPath.item]
            cell.appName.text = appResult.trackName
            cell.appCategory.text = appResult.primaryGenreName
            cell.appRating.text = "Rating:\(appResult.averageUserRating ?? 0)"
            cell.imageView.sd_setImage(with: URL(string: appResult.artworkUrl100))
            cell.sreenShot1ImageView.sd_setImage(with: URL(string: appResult.screenshotUrls![0]))
            if appResult.screenshotUrls!.count > 1 {
                cell.sreenShot2ImageView.sd_setImage(with: URL(string: appResult.screenshotUrls![1]))
            }
            if appResult.screenshotUrls!.count > 2 {
            cell.sreenShot3ImageView.sd_setImage(with: URL(string: appResult.screenshotUrls![2]))
            }
        return cell
        }
        return UICollectionViewCell()
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let appResult = searchResults[indexPath.item]
        let controller = AppDetailController(appId: String(appResult.trackId!))
        navigationController?.pushViewController(controller, animated: true)
    }
    
    init() {
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

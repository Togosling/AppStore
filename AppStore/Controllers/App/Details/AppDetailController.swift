//
//  AppDetailController.swift
//  AppStore
//
//  Created by Toga on 13/9/22.
//

import UIKit

class AppDetailController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    let appId: String
    var app: Result?
    var reviews: Review?
    
    fileprivate let AppDetailCellID = "AppDetailCellID"
    fileprivate let previewCellId = "previewCellId"
    fileprivate let reviewCellId = "reviewCellId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        navigationItem.largeTitleDisplayMode = .never
        
        collectionView.register(AppDetailCell.self, forCellWithReuseIdentifier: AppDetailCellID)
        collectionView.register(PreviewCell.self, forCellWithReuseIdentifier: previewCellId)
        collectionView.register(ReviewCell.self, forCellWithReuseIdentifier: reviewCellId)
        
        fetchApp()
        
    }
    
    fileprivate func fetchApp() {
        let urlString = "https://itunes.apple.com/lookup?id=\(appId )"
        Service.shared.fetchAppJSONGeneric(urlString: urlString) { (result: SearchApp) in
            let resultApp = result.results.first
            self.app = resultApp
            DispatchQueue.main.sync {
                self.collectionView.reloadData()
            }
        }
        let reviewsUrl = "https://itunes.apple.com/rss/customerreviews/page=1/id=\(appId )/sortby=mostrecent/json?l=en&cc=us"
        Service.shared.fetchAppJSONGeneric(urlString: reviewsUrl) { (result: Review ) in
            self.reviews = result
            DispatchQueue.main.sync {
                self.collectionView.reloadData()
            }
        }
    }
        
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.item == 0 {
         let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AppDetailCellID, for: indexPath) as! AppDetailCell
            cell.nameLabel.text = app?.trackName
            cell.releaseNotesLabel.text = app?.releaseNotes
            cell.imageView.sd_setImage(with: URL(string: app?.artworkUrl100 ?? ""))
            cell.priceButton.setTitle(app?.formattedPrice, for: .normal)
            return cell
        } else if indexPath.item == 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: previewCellId, for: indexPath) as! PreviewCell
            cell.horizontalController.app = self.app
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reviewCellId, for: indexPath) as! ReviewCell
            cell.horizontalController.reviews = self.reviews
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.item == 0 {
        let dummyCell = AppDetailCell(frame: .init(x: 0, y: 0, width: view.frame.width, height: 1000))
        
        dummyCell.nameLabel.text = app?.trackName
        dummyCell.releaseNotesLabel.text = app?.releaseNotes
        dummyCell.imageView.sd_setImage(with: URL(string: app?.artworkUrl100 ?? ""))
        dummyCell.priceButton.setTitle(app?.formattedPrice, for: .normal)
        
        dummyCell.layoutIfNeeded()
        
        let estimatedSize = dummyCell.systemLayoutSizeFitting(.init(width: view.frame.width, height: 1000))
        
        return .init(width: view.frame.width, height: estimatedSize.height)
        } else if indexPath.item == 1 {
            return .init(width: view.frame.width, height: 500)
        } else {
            return .init(width: view.frame.width, height: 300)
        }
    }
    
    init(appId: String) {
        self.appId = appId
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

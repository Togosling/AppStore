//
//  AppInsideController.swift
//  AppStore
//
//  Created by Toga on 9/9/22.
//

import UIKit
import SDWebImage

class AppHorizontalController: HorizontalSnappingController, UICollectionViewDelegateFlowLayout {
    
    fileprivate let CellId = "HorizontalCellID"
     var appGroup: AppGroup?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = .white
        
        collectionView.register(AppCell.self, forCellWithReuseIdentifier: CellId)
        collectionView.contentInset = .init(top: 12, left: 16, bottom: 12, right: 16)
        
    }
    
    var didSelectHandler: ((FeedResult)->())?

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let app = appGroup?.feed.results[indexPath.item] {
            didSelectHandler?(app)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width - 40, height: 70)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return appGroup?.feed.results.count ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellId, for: indexPath) as? AppCell {
            let app = appGroup?.feed.results[indexPath.item]
            cell.nameLabel.text = app?.name
            cell.descriptionLabel.text = app?.artistName
            cell.imageView.sd_setImage(with: URL(string: app?.artworkUrl100 ?? ""))
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    // Replaced with collectionView.contentInset
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        return .init(top: 12, left: 16, bottom: 12, right: 16)
//    }

}

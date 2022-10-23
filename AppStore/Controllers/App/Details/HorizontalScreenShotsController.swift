//
//  HorizontalScreenShotsController.swift
//  AppStore
//
//  Created by Toga on 14/9/22.
//

import UIKit

class HorizontalScreenShotsController: HorizontalSnappingController, UICollectionViewDelegateFlowLayout {
    
    fileprivate let cellId = "cellId"
    var app: Result? {
        didSet{
            collectionView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.register(ScreenShotsCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.contentInset = .init(top: 0, left: 16, bottom: 0, right: 16)

    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let count = app?.screenshotUrls?.count else {return 0}
        return count
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ScreenShotsCell
        guard let screenShot = app?.screenshotUrls?[indexPath.item] else {return UICollectionViewCell()}
        cell.imageView.sd_setImage(with: URL(string: screenShot))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: 250, height: view.frame.height)
    }
    
    
}

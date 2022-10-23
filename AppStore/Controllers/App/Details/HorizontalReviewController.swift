//
//  HorizontalReviewController.swift
//  AppStore
//
//  Created by Toga on 15/9/22.
//

import UIKit

class HorizontalReviewController: HorizontalSnappingController, UICollectionViewDelegateFlowLayout {
    
    fileprivate let cellId = "cellId"
    
    var reviews: Review? {
        didSet {
            collectionView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super .viewDidLoad()
        
        collectionView.register(ReviewHorizontalCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.contentInset = .init(top: 16, left: 16, bottom: 16, right: 16)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return reviews?.feed.entry.count ?? 0
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ReviewHorizontalCell
        let review = reviews?.feed.entry[indexPath.item]
        cell.titleLabel.text = review?.title.label
        cell.authorLabel.text = review?.author.name.label
        cell.bodyLabel.text = review?.content.label
        for (index,view) in cell.starsStackView.arrangedSubviews.enumerated() {
            if let rating = Int(review?.rating.label ?? "0") {
                view.alpha = index >= rating ? 0 : 1
            }
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width - 48, height: view.frame.height)
    }
    
}

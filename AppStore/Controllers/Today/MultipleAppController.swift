//
//  MultipleAppController.swift
//  AppStore
//
//  Created by Toga on 21/9/22.
//

import UIKit

class MultipleAppController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    private let cellId = "cellId"
    var appResult = [FeedResult]() //
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if style == .small {
            collectionView.isScrollEnabled = false
        } else if style == .fullScreen {
            navigationController?.isNavigationBarHidden = true
        }
        
        collectionView.register(MultipleAppCell.self, forCellWithReuseIdentifier: cellId)
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailsController = AppDetailController(appId: appResult[indexPath.item].id)
        navigationController?.pushViewController(detailsController, animated: true)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if style == .small {
            return min(4, appResult.count)
        } else {
            return appResult.count
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! MultipleAppCell
        cell.appResult = self.appResult[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if style == .small {
            return .init(width: view.frame.width, height: (view.frame.height - 3 * 16) / 4)
        }
        return .init(width: view.frame.width - 48, height: 74)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if style == .fullScreen {
            return .init(top: 12, left: 24, bottom: 12, right: 24)
        } else {
            return .zero
        }
    }
    
    private let style: Mode
    
    enum Mode {
        case small, fullScreen
    }
    
    init(style: Mode) {
        self.style = style
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

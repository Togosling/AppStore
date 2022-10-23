//
//  HorizontalSnappingController.swift
//  AppStore
//
//  Created by Toga on 13/9/22.
//

import UIKit

class HorizontalSnappingController: UICollectionViewController {
    
    init(){
        let layout = BetterSnappingLayout()
        layout.scrollDirection = .horizontal
        super.init(collectionViewLayout: layout)
        collectionView.decelerationRate = .fast
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//
//  AppHeaderView.swift
//  AppStore
//
//  Created by Toga on 10/9/22.
//

import UIKit

class AppHeaderView: UICollectionReusableView {
    
    let horizontalController = AppHeaderHorizontalController()
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        
        addSubview(horizontalController.view)
        horizontalController.view.fillSuperview()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

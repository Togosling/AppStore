//
//  AppGroupCell.swift
//  AppStore
//
//  Created by Toga on 9/9/22.
//

import UIKit

class AppGroupCell: UICollectionViewCell {
    
    let titleLabel: UILabel = {
       let label = UILabel()
        label.text = "App Section"
        label.font = .boldSystemFont(ofSize: 30)
        return label
    }()
    
    let horizontalController = AppHorizontalController()
    
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        
        addSubview(titleLabel)
        titleLabel.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 0, left: 16, bottom: 0, right: 0))
        
        addSubview(horizontalController.view)
        horizontalController.view.anchor(top: titleLabel.bottomAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//
//  PreviewCell.swift
//  AppStore
//
//  Created by Toga on 14/9/22.
//

import UIKit

class PreviewCell: UICollectionViewCell {
    
    let horizontalController = HorizontalScreenShotsController()
    let previewLabel: UILabel = {
        let label = UILabel()
        label.text = "Preview"
        label.font = .boldSystemFont(ofSize: 20)
        return label
    }()
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        
        addSubview(horizontalController.view)
        addSubview(previewLabel)
        previewLabel.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 0, left: 16, bottom: 0, right: 16))
        horizontalController.view.anchor(top: previewLabel.bottomAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor,padding: .init(top: 16, left: 0, bottom: 0, right: 0))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

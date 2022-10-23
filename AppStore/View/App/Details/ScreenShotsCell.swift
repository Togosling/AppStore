//
//  ScreenShotsCell.swift
//  AppStore
//
//  Created by Toga on 14/9/22.
//

import UIKit

class ScreenShotsCell: UICollectionViewCell {
    
    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.layer.cornerRadius = 16
        iv.clipsToBounds = true
        return iv
    }()
    
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        addSubview(imageView)
        imageView.fillSuperview()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

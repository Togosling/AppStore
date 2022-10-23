//
//  BaseCell.swift
//  AppStore
//
//  Created by Toga on 21/9/22.
//

import UIKit

class BaseCell: UICollectionViewCell {
    
    var todayItem: AppItem!
    
    override var isHighlighted: Bool {
        didSet{
            var transform: CGAffineTransform = .identity
            if isHighlighted {
                transform = .init(scaleX: 0.9, y: 0.9)
            }
            UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut) {
                self.transform = transform
            }
        }
    }
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        
        self.backgroundView = UIView()
        addSubview(backgroundView!)
        backgroundView?.fillSuperview()
        backgroundView?.backgroundColor = .white
        backgroundView?.layer.cornerRadius = 16
        backgroundView?.layer.shadowOpacity = 0.1
        backgroundView?.layer.shadowRadius = 10
        backgroundView?.layer.shadowOffset = .init(width: 0, height: 10)
        backgroundView?.layer.shouldRasterize = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

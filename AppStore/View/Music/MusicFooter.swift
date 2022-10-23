//
//  MusicFooter.swift
//  AppStore
//
//  Created by Toga on 26/9/22.
//

import UIKit

class MusicFooter: UICollectionReusableView {
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        
        let aiv = UIActivityIndicatorView(style: .large)
        aiv.color = .darkGray
        aiv.startAnimating()
        
        let label = UILabel()
        label.text = "Loading..."
        label.font = .systemFont(ofSize: 16)
        label.textAlignment = .center
        
        let stackView = UIStackView(arrangedSubviews: [aiv,label])
        stackView.axis = .vertical
        stackView.spacing = 12
        
        addSubview(stackView)
        stackView.centerInSuperview(size: .init(width: 100, height: 0))
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

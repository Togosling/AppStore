//
//  MusicCell.swift
//  AppStore
//
//  Created by Toga on 26/9/22.
//

import UIKit

class MusicCell: UICollectionViewCell {
    
    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "music")
        iv.widthAnchor.constraint(equalToConstant: 64).isActive = true
        iv.heightAnchor.constraint(equalToConstant: 64).isActive = true
        iv.layer.cornerRadius = 12
        iv.clipsToBounds = true
        return iv
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Song name"
        label.font = .systemFont(ofSize: 20)
        return label
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Song description"
        label.font = .systemFont(ofSize: 13)
        return label
    }()
    
    let borderView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0.3, alpha: 0.3)
        return view
    }()
    
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        
        let labelStackView = UIStackView(arrangedSubviews: [nameLabel,descriptionLabel])
        labelStackView.axis = .vertical
        labelStackView.spacing = 12
        
        let stackView = UIStackView(arrangedSubviews: [imageView,labelStackView])
        stackView.spacing = 16
        stackView.alignment = .center
        
        addSubview(stackView)
        stackView.fillSuperview(padding: .init(top: 16, left: 16, bottom: 16, right: 16))
        
        addSubview(borderView)
        borderView.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 0, bottom: -8, right: 0), size: .init(width: 0, height: 0.5))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//
//  TodayCell.swift
//  AppStore
//
//  Created by Toga on 17/9/22.
//

import UIKit


class TodayCell: BaseCell {
    
    override var todayItem: AppItem! {
        didSet{
            categoryLabel.text = todayItem.category
            titleLabel.text = todayItem.title
            imageView.image = todayItem.image
            descriptionLabel.text = todayItem.description
            backgroundColor = todayItem.backgroundColor
            backgroundView?.backgroundColor = todayItem.backgroundColor
        }
    }

    let imageView: UIImageView = {
       let iv = UIImageView()
        iv.clipsToBounds = true
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    let categoryLabel: UILabel = {
       let label = UILabel()
        label.font = .boldSystemFont(ofSize: 20)
        return label
    }()
    
    let titleLabel: UILabel = {
       let label = UILabel()
        label.font = .boldSystemFont(ofSize: 28)
        return label

    }()
    
    let descriptionLabel: UILabel = {
       let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.numberOfLines = 3
        return label

    }()
    
    var topConstraint: NSLayoutConstraint!

    override init(frame: CGRect) {
        super .init(frame: frame)
        
        layer.cornerRadius = 16
        backgroundColor = .white
        
        let imageView2 = UIView()
        imageView2.addSubview(imageView)
        imageView.centerInSuperview(size: .init(width: 240, height: 240))

        let stackView = UIStackView(arrangedSubviews: [categoryLabel,titleLabel,imageView2,descriptionLabel])
        stackView.spacing = 12
        stackView.axis = .vertical
        addSubview(stackView)
        stackView.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 24, bottom: 24, right: 24))
        self.topConstraint = stackView.topAnchor.constraint(equalTo: topAnchor, constant: 24)
        self.topConstraint.isActive = true
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

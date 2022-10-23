//
//  ReviewHorizontalCell.swift
//  AppStore
//
//  Created by Toga on 15/9/22.
//

import UIKit

class ReviewHorizontalCell: UICollectionViewCell {
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Title"
        label.font = .boldSystemFont(ofSize: 16)
        return label
    }()
    
    let authorLabel: UILabel = {
        let label = UILabel()
        label.text = "Author"
        label.font = .systemFont(ofSize: 16)
        label.textColor = .lightGray
        return label
    }()
        
    let starsStackView: UIStackView = {
        
        var arrangedSubViews = [UIView]()
        (0..<5) .forEach { _ in
            let imageView = UIImageView(image: UIImage(named: "star"))
            imageView.constrainWidth(constant: 24)
            imageView.constrainHeight(constant: 24)
            arrangedSubViews.append(imageView)
        }
        arrangedSubViews.append(UIView())
        let stackView = UIStackView(arrangedSubviews: arrangedSubViews)
        return stackView
    }()
    
    let bodyLabel: UILabel = {
        let label = UILabel()
        label.text = "Review body"
        label.font = .systemFont(ofSize: 16)
        label.numberOfLines = 6
        return label
    }()
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        
        backgroundColor = UIColor(red: 240/255, green: 240/255, blue: 249/255, alpha: 1)
        layer.cornerRadius = 16
        
        let firstStackView = UIStackView(arrangedSubviews: [titleLabel,authorLabel])
        firstStackView.axis = .horizontal
        firstStackView.spacing = 10
        
        let finalStackView = UIStackView(arrangedSubviews: [firstStackView,starsStackView,bodyLabel])
        finalStackView.spacing = 12
        finalStackView.axis = .vertical
        
        titleLabel.setContentCompressionResistancePriority(.init(rawValue: 0), for: .horizontal)
        authorLabel.textAlignment = .right
        
        addSubview(finalStackView)
        finalStackView.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 16, left: 16, bottom: 0, right: 16))
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//
//  SearchAppCell.swift
//  AppStore
//
//  Created by Toga on 6/9/22.
//

import UIKit

class SearchAppCell: UICollectionViewCell {
    
    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.widthAnchor.constraint(equalToConstant: 64).isActive = true
        iv.heightAnchor.constraint(equalToConstant: 64).isActive = true
        iv.layer.cornerRadius = 12
        iv.clipsToBounds = true
        return iv
    }()
    
    let appName: UILabel = {
        let label = UILabel()
        label.text = "App Name"
        return label
    }()
    
    let appCategory: UILabel = {
        let label = UILabel()
        label.text = "App Category"
        return label
    }()
    
    let appRating: UILabel = {
        let label = UILabel()
        label.text = "App Rating"
        return label
    }()
    
    let getButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("GET", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 14)
        button.backgroundColor = UIColor(white: 0.95, alpha: 1)
        button.setTitleColor(.systemBlue, for: .normal)
        button.layer.cornerRadius = 14
        button.widthAnchor.constraint(equalToConstant: 80).isActive = true
        button.heightAnchor.constraint(equalToConstant: 32).isActive = true
        return button
    }()

    func createScreenShotView() -> UIImageView{
        let view = UIImageView()
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        view.layer.borderWidth = 0.5
        view.layer.borderColor = UIColor(white: 0.5, alpha: 0.5).cgColor
        view.contentMode = .scaleAspectFill
        return view
    }
    
    lazy var sreenShot1ImageView = self.createScreenShotView()
    lazy var sreenShot2ImageView = self.createScreenShotView()
    lazy var sreenShot3ImageView = self.createScreenShotView()
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        
        let scrennShotStackView = UIStackView(arrangedSubviews: [
            sreenShot1ImageView,
            sreenShot2ImageView,
            sreenShot3ImageView
        ])
        scrennShotStackView.spacing = 12
        scrennShotStackView.distribution = .fillEqually
        
        let labelStackView = UIStackView(arrangedSubviews: [
        appName, appCategory, appRating
        ])
        labelStackView.axis = .vertical
        
        let stackView = UIStackView(arrangedSubviews: [
        imageView, labelStackView, getButton
        ])
        stackView.spacing = 12
        stackView.alignment = .center
        
        let overallStackView = UIStackView(arrangedSubviews: [
        stackView,
        scrennShotStackView
        ])
        overallStackView.axis = .vertical
        overallStackView.spacing = 12
        
        addSubview(overallStackView)
       
        overallStackView.fillSuperview(padding: .init(top: 16, left: 16, bottom: 16, right: 16))

        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

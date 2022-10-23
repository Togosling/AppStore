//
//  TodayFullScrennController.swift
//  AppStore
//
//  Created by Toga on 19/9/22.
//

import Foundation
import UIKit

class TodayFullScreenController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var todayItem: AppItem?
    
    let tableView = UITableView(frame: .zero, style: .plain)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(tableView)
        tableView.fillSuperview()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        
        setupFloatingView()
    }
    
    let floatingView = UIView()
    
    fileprivate func setupFloatingView() {
        floatingView.clipsToBounds = true
        floatingView.layer.cornerRadius = 16
        view.addSubview(floatingView)
        floatingView.anchor(top: nil, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor, padding: .init(top: 0, left: 16, bottom: -90, right: 16), size: .init(width: 0, height: 90))
        
        let blurEffect = UIVisualEffectView(effect: UIBlurEffect(style: .regular))
        floatingView.addSubview(blurEffect)
        blurEffect.fillSuperview()
        
        let imageView: UIImageView = {
            let iv = UIImageView()
            iv.image = todayItem?.image
            iv.widthAnchor.constraint(equalToConstant: 64).isActive = true
            iv.heightAnchor.constraint(equalToConstant: 64).isActive = true
            iv.layer.cornerRadius = 12
            iv.clipsToBounds = true
            return iv
        }()
        
        let nameLabel: UILabel = {
            let label = UILabel()
            label.text = todayItem?.category
            label.font = .boldSystemFont(ofSize: 18)
            return label
        }()
        
        let descriptionLabel: UILabel = {
            let label = UILabel()
            label.text = todayItem?.title
            label.font = .systemFont(ofSize: 13)
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
        
        let labelStackView = UIStackView(arrangedSubviews: [nameLabel,descriptionLabel])
        labelStackView.axis = .vertical
        
        let stackView = UIStackView(arrangedSubviews: [imageView,labelStackView, getButton])
        stackView.spacing = 12
        stackView.alignment = .center
        
        floatingView.addSubview(stackView)
        stackView.fillSuperview()
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y > 100 {
            UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .curveEaseOut) {
                self.floatingView.transform = .init(translationX: 0, y: -116)
            }
        } else {
            UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .curveEaseOut) {
                self.floatingView.transform = .identity
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.item == 0{
            let headerCell = TodayFullScreenHeaderCell()
            headerCell.todayCell.todayItem = todayItem
            headerCell.todayCell.layer.cornerRadius = 0
            headerCell.todayCell.backgroundView?.layer.cornerRadius = 0
            headerCell.clipsToBounds = true
            return headerCell
        }
        let cell = TodayFullScreenCell()
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 500
        }
        return UITableView.automaticDimension
    }
    
}

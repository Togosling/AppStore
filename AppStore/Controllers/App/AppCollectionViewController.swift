//
//  AppController.swift
//  AppStore
//
//  Created by Toga on 9/9/22.
//

import UIKit

class AppCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    fileprivate let id = "AppCellId"
    fileprivate let headerId = "Header Id"
    fileprivate var appGroups = [AppGroup]()
    fileprivate var socialApps = [SocialApp]()
    let activityIndicator: UIActivityIndicatorView = {
        let aiv = UIActivityIndicatorView(style: .large)
        aiv.color = .darkGray
        aiv.startAnimating()
        aiv.hidesWhenStopped = true
        return aiv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.register(AppGroupCell.self, forCellWithReuseIdentifier: id)
        
        collectionView.register(AppHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerId)
        
        view.addSubview(activityIndicator)
        activityIndicator.fillSuperview()
        
        featchGames()
        
        
    }
    
    fileprivate func featchGames() {
        let dispatchGroup = DispatchGroup()
        var group1: AppGroup?
        var group2: AppGroup?
        
        dispatchGroup.enter()
        Service.shared.fetchTopFree { appGroup in
            dispatchGroup.leave()
            group1 = appGroup
        }
        dispatchGroup.enter()
        Service.shared.fetchTopPaid { appGroup in
            dispatchGroup.leave()
           group2 = appGroup
        }
        dispatchGroup.enter()
        Service.shared.fetchSocialApp { socialApp in
            dispatchGroup.leave()
            self.socialApps = socialApp
        }
        
        dispatchGroup.notify(queue: .main) {
            self.activityIndicator.stopAnimating()
            
            if let group1 = group1 {
                self.appGroups.append(group1)
            }
            if let group2 = group2 {
                self.appGroups.append(group2)
            }
            self.collectionView.reloadData()
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath) as? AppHeaderView {
            header.horizontalController.socialApps = self.socialApps
            header.horizontalController.collectionView.reloadData()
        return header
        }
        return UICollectionReusableView()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return .init(width: view.frame.width, height: 300)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width, height: 300)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return appGroups.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: id, for: indexPath) as? AppGroupCell{
            let app = appGroups[indexPath.item]
            cell.titleLabel.text = app.feed.title
            cell.horizontalController.appGroup = app
            cell.horizontalController.collectionView.reloadData()
            cell.horizontalController.didSelectHandler = { [weak self]
                feedResult in
                let controller = AppDetailController(appId: feedResult.id)
                controller.navigationItem.title = feedResult.name
                self?.navigationController?.pushViewController(controller, animated: true)
            }
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 16, left: 0, bottom: 0, right: 0)
    }
    
    
    
    init() {
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

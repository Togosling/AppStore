//
//  TodayController.swift
//  AppStore
//
//  Created by Toga on 17/9/22.
//

import UIKit

class TodayController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var appItems = [AppItem]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.register(TodayCell.self, forCellWithReuseIdentifier: AppItem.CellType.single.rawValue)
        collectionView.register(TodayMultipleAppCell.self, forCellWithReuseIdentifier: AppItem.CellType.multiple.rawValue)
        
        collectionView.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
        
        fetchData()
        
    }
    
    private func fetchData() {
        var topFree: AppGroup?
        var topPaid: AppGroup?
        let dispatchGroup = DispatchGroup()
        
        dispatchGroup.enter()
        Service.shared.fetchTopFree { appGroup in
            topFree = appGroup
            dispatchGroup.leave()
        }
        
        dispatchGroup.enter()
        Service.shared.fetchTopPaid { appGroup in
            topPaid = appGroup
            dispatchGroup.leave()
        }
        
        dispatchGroup.notify(queue: .main) {
            self.appItems = [
                AppItem.init(category: "DAILY LIST", title: topFree?.feed.title ?? "", image: UIImage(named: "garden") ?? UIImage(), description: "", backgroundColor: .white, cellType: .multiple, apps: topFree?.feed.results ?? []),
                AppItem.init(category: "LIFE HACK", title: "Utilizing your Time", image: UIImage(named: "garden") ?? UIImage(), description: "All the tools and apps you need to intelligently organize your life the right way.", backgroundColor: .white, cellType: .single, apps: []),
                AppItem.init(category: "DAILY LIST", title: topPaid?.feed.title ?? "", image: UIImage(named: "garden") ?? UIImage(), description: "", backgroundColor: .white, cellType: .multiple, apps: topPaid?.feed.results ?? []),
                AppItem.init(category: "HOLIDAYS", title: "Travel on a Budjet", image: UIImage(named: "holiday") ?? UIImage(), description: "Find out all you need to know on how to travel without packing everything!", backgroundColor: UIColor(red: 251/255, green: 246/255, blue: 185/255, alpha: 1),cellType: .single, apps: [])]
            
            self.collectionView.reloadData()
        }
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return appItems.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellId = appItems[indexPath.item].cellType.rawValue
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! BaseCell
        cell.todayItem = appItems[indexPath.item]
        
        (cell as? TodayMultipleAppCell)?.multipleAppController.collectionView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handlerMuiltipleAppsTap)))
        
        return cell
    }
    
    @objc func handlerMuiltipleAppsTap(gesture: UITapGestureRecognizer) {
        let collectionView = gesture.view
        var superview = collectionView?.superview

        while superview != nil {
            if let cell = superview as? TodayMultipleAppCell {
                guard let indexPath = self.collectionView.indexPath(for: cell) else {return}
                let apps = self.appItems[indexPath.item].apps

                let fullController = MultipleAppController(style: .fullScreen)
                fullController.appResult = apps
                present(BackEnabledNAvigationController(rootViewController: fullController), animated: true) // ??
            }

            superview = superview?.superview
        }
        
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width - 64, height: 500)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 16, left: 0, bottom: 16, right: 0)
    }
    
    var todayFullScreenController: TodayFullScreenController!
    var startingFrame: CGRect?
    
    var topContraint: NSLayoutConstraint?
    var leadingContraint: NSLayoutConstraint?
    var widthContraint: NSLayoutConstraint?
    var heightContraint: NSLayoutConstraint?

    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        switch appItems[indexPath.item].cellType {
        case .multiple :
            let fullScreenController = MultipleAppController(style: .fullScreen)
            fullScreenController.appResult = appItems[indexPath.item].apps
            present(BackEnabledNAvigationController(rootViewController: fullScreenController), animated: true)
        default:
            let todayFullScreenController = TodayFullScreenController()
            todayFullScreenController.todayItem = appItems[indexPath.row]
            present(todayFullScreenController, animated: true)
        }
    }
        
    init() {
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

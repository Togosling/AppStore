//
//  TapBarController.swift
//  AppStore
//
//  Created by Toga on 5/9/22.
//

import UIKit

class TapBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewControllers = [
        createVC(viewController: MusicController(), title: "Music", imageName: "music"),
        createVC(viewController: TodayController(), title: "Today", imageName: "today_icon"),
        createVC(viewController: AppCollectionViewController(), title: "Apps", imageName: "apps"),
        createVC(viewController: AppSearchCollectionViewController(), title: "Search", imageName: "search")
        ]
    }
    
    fileprivate func createVC(viewController: UIViewController, title: String, imageName: String) -> UIViewController {
        
        viewController.view.backgroundColor = .white
        viewController.navigationItem.title = title
        let navController = UINavigationController(rootViewController: viewController)
        navController.tabBarItem.title = title
        navController.tabBarItem.image = UIImage(named: imageName)
        navController.navigationBar.prefersLargeTitles = true
        return navController
    }
}

//
//  AppItem.swift
//  AppStore
//
//  Created by Toga on 19/9/22.
//

import UIKit

struct AppItem {
    
    let category: String
    let title: String
    let image: UIImage
    let description: String
    let backgroundColor: UIColor
    
    let cellType: CellType
    
    let apps: [FeedResult]
    
    enum CellType: String {
        case multiple, single
    }
}

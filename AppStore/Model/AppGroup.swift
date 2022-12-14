//
//  AppGroup.swift
//  AppStore
//
//  Created by Toga on 10/9/22.
//

import Foundation


struct AppGroup: Decodable {
    let feed: Feed
}
struct Feed: Decodable {
    let title: String
    let results: [FeedResult]
}
struct FeedResult: Decodable {
    let id: String
    let name: String
    let artistName: String
    let artworkUrl100: String
}

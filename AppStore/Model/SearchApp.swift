//
//  SearchApp.swift
//  AppStore
//
//  Created by Toga on 7/9/22.
//

import Foundation

struct SearchApp: Decodable {
    let resultCount: Int
    let results: [Result]
}

struct Result: Decodable {
    var trackId: Int?
    var trackName: String?
    let primaryGenreName: String
    let artworkUrl100: String
    let formattedPrice: String?
    var averageUserRating: Float?
    var screenshotUrls: [String]?
    var description: String?
    var releaseNotes: String?
    var artistName: String?
    var collectionName: String?
}

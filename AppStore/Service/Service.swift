//
//  Service.swift
//  AppStore
//
//  Created by Toga on 8/9/22.
//

import Foundation

class Service {
    
    static let shared = Service() // singleton
    
    func fetchApps(searchString: String, completion: @escaping (SearchApp)->()) {
        let urlString = "https://itunes.apple.com/search?term=\(searchString)&entity=software"
        fetchAppJSONGeneric(urlString: urlString, completion: completion)
    }
    
    func fetchSearchApp(urlString: String, completion: @escaping (SearchApp)->()) {
        fetchAppJSONGeneric(urlString: urlString, completion: completion)
    }
    func fetchTopFree(completion: @escaping (AppGroup)->()) {
        let urlString = "https://rss.applemarketingtools.com/api/v2/us/apps/top-free/50/apps.json"
       fetchAppGroup(urlString: urlString, completion: completion)
    }
    
    func fetchTopPaid(completion: @escaping (AppGroup)->()) {
        let urlString = "https://rss.applemarketingtools.com/api/v2/us/apps/top-paid/50/apps.json"
       fetchAppGroup(urlString: urlString, completion: completion)
    }
    
    func fetchSocialApp(completion: @escaping ([SocialApp])->()) {
        let urlString = "https://api.letsbuildthatapp.com/appstore/social"
        fetchAppJSONGeneric(urlString: urlString, completion: completion)
    }
    
//helper    
    func fetchAppGroup(urlString: String,completion: @escaping (AppGroup)->()) {
        fetchAppJSONGeneric(urlString: urlString, completion: completion)
    }
//   Generic
    func fetchAppJSONGeneric<T:Decodable> (urlString: String, completion: @escaping (T)->()) {
        guard let url = URL(string: urlString) else {return}
        URLSession.shared.dataTask(with: url) { data, resp, err in
            if let err = err {
                print(err)
                return
            }
            
            guard let data = data else {return}
            
            do{
                let fetchResult = try JSONDecoder().decode(T.self, from: data)
                completion(fetchResult)
                
            } catch {
                print(error)
            }
        }.resume()
    }
}

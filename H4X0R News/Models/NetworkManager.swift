//
//  NetworkManager.swift
//  H4X0R News
//
//  Created by Manmeet Singh on 2024-01-15.
//

import Foundation

class NetworkManager: ObservableObject {
    
    let url = "http://hn.algolia.com/api/v1/search?tags=front_page"
    
    @Published var posts = [Post]()
    
    func fetchData() {
        if let url = URL(string: url) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, response, error in
            
                if error == nil {
                    let decoder = JSONDecoder()
                    if let safeData = data {
                        do {
                            let results = try decoder.decode(Results.self, from: safeData)
                            
                            DispatchQueue.main.async {
                                
                                self.posts = results.hits}
                        } catch {
                            print(error)
                        }
                    }
                }
                
            }
            task.resume()
        }
    }
}

//
//  NetworkManager.swift
//  H4X0R News
//
//  Created by Bar Elimelech on 26/02/2025.
//

import Foundation

@MainActor
class NetworkManager: ObservableObject {
    
    @Published var posts = [Post]()

    
    func fetchData() async {
        guard let url = URL(string: "http://hn.algolia.com/api/v1/search?tags=front_page") else { return }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decoder = JSONDecoder()
            let results = try decoder.decode(Results.self, from: data)
            DispatchQueue.main.async {
                self.posts = results.hits
            }
        } catch {
            print("Error fetching data:", error)
        }
    }

}



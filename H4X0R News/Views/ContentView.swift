//
//  ContentView.swift
//  H4X0R News
//
//  Created by Bar Elimelech on 25/02/2025.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var networkManager = NetworkManager()
    
    var body: some View {
           NavigationStack {
               List(networkManager.posts) { post in
                   if let url = post.url, !url.isEmpty {
                       NavigationLink(destination: DetailView(url: url)) {
                           HStack {
                               Text(String(post.points))
                                   .fontWeight(.bold)
                               Text(post.title)
                           }
                       }
                   } else {
                       HStack {
                           Text(String(post.points))
                               .fontWeight(.bold)
                           Text(post.title)
                       }
                   }
               }
               .navigationTitle("H4X0R News")
           }
           .task {
               await networkManager.fetchData()
           }
       }
}

#Preview {
    ContentView()
}


//
//  TMDBApp.swift
//  Shared
//
//  Created by admin on 6/29/20.
//

import SwiftUI

@main
struct TMDBApp: App {
    var body: some Scene {
        WindowGroup {
            TabView {
                MovieListView()
                    .tabItem {
                        VStack {
                            Image(systemName: "tv")
                                .foregroundColor(.yellow)
                            Text("Home")
                        }
                    }
                    .tag(0)
                MovieSearchView()
                    .tabItem {
                        VStack {
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(.yellow)
                            Text("Search")
                        }
                    }
                    .tag(1)
            }
        }
    }
}

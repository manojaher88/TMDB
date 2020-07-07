//
//  MovieSearchView.swift
//  TMDB
//
//  Created by admin on 7/5/20.
//

import SwiftUI

struct MovieSearchView: View {
    
    @ObservedObject private var movieSearchState = MovieSearchState()
    
    var body: some View {
        NavigationView {
            List {
                SearchBarView(placeHolder: "Search movie", searhText: self.$movieSearchState.query)
                    .listRowInsets(EdgeInsets(top: 0, leading: 8, bottom: 0, trailing: 8))
                
                LoadingView(isLoading: movieSearchState.isLoading, error: movieSearchState.error) {
                    self.movieSearchState.search(self.movieSearchState.query)
                }
                if let movies = self.movieSearchState.movies {
                    ForEach(movies) { movie in
                        Text(movie.title)
                    }
                }
            }
            .navigationBarTitle("Search Movie")
        }
        .onAppear {
            self.movieSearchState.startObserve()
        }
    }
}

struct MovieSearchView_Previews: PreviewProvider {
    static var previews: some View {
        MovieSearchView()
    }
}

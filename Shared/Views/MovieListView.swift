//
//  MoviewListView.swift
//  TMDB
//
//  Created by admin on 7/3/20.
//

import SwiftUI

struct MovieListView: View {
    
    @StateObject var nowPlayingState = MovieListState()
    @StateObject var upcomingState = MovieListState()
    @StateObject var topRatedState = MovieListState()
    @StateObject var popularState = MovieListState()
    
    var body: some View {
        NavigationView {
            List {
                if let movies = nowPlayingState.movies {
                    MoviePosterCarouselView(movies: movies, title: "Now Playing")
                        .listRowInsets(EdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 0))
                } else {
                    LoadingView(isLoading: nowPlayingState.isLoading, error: nowPlayingState.error) {
                        nowPlayingState.loadMovie(endpoint: .nowPlaying)
                    }
                }
                
                if let movies = upcomingState.movies {
                    MovieCarouselView(title: "Upcoming Movies", movies: movies)
                        .listRowInsets(EdgeInsets(top: 8, leading: 6, bottom: 8, trailing: 0))
                } else {
                    LoadingView(isLoading: upcomingState.isLoading, error: upcomingState.error) {
                        upcomingState.loadMovie(endpoint: .upcoming)
                    }
                }
                
                if let movies = topRatedState.movies {
                    MovieCarouselView(title: "Top Rated Movies", movies: movies)
                        .listRowInsets(EdgeInsets(top: 8, leading: 6, bottom: 8, trailing: 0))
                } else {
                    LoadingView(isLoading: upcomingState.isLoading, error: upcomingState.error) {
                        topRatedState.loadMovie(endpoint: .topRated)
                    }
                }
                
                if let movies = popularState.movies {
                    MovieCarouselView(title: "Popular Movies", movies: movies)
                        .listRowInsets(EdgeInsets(top: 8, leading: 6, bottom: 8, trailing: 0))
                } else {
                    LoadingView(isLoading: upcomingState.isLoading, error: upcomingState.error) {
                        popularState.loadMovie(endpoint: .popular)
                    }
                }
            }
            .listRowBackground(Color.red)
            .navigationBarTitle("TMDB Movies")
        }
        .onAppear {
            nowPlayingState.loadMovie(endpoint: .nowPlaying)
            upcomingState.loadMovie(endpoint: .upcoming)
            topRatedState.loadMovie(endpoint: .topRated)
            popularState.loadMovie(endpoint: .popular)
        }
    }
}

struct MovieListView_Previews: PreviewProvider {
    static var previews: some View {
        MovieListView()
    }
}

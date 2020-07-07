//
//  MovieListState.swift
//  TMDB
//
//  Created by admin on 7/3/20.
//

import Foundation
import SwiftUI

class MovieListState: ObservableObject {
    
    @Published var movies: [Movie]?
    @Published var isLoading = false
    @Published var error: NSError?
    
    private let movieStore: MovieService
    
    init(movieService: MovieService = MovieStore.shared) {
        self.movieStore = movieService
    }
    
    func loadMovie(endpoint: MovieListEndpoint) {
        self.movies = nil
        self.isLoading = true
        self.movieStore.fetchMovies(from: endpoint) {[weak self] (result) in
            guard let self = self else {return}
            switch result {
            case .failure(let error):
                self.error = error as NSError
            case .success(let response):
                self.movies = response.results
            }
            self.isLoading = false
        }
    }
    
}

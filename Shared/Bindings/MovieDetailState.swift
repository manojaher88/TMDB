//
//  MoviewDetailState.swift
//  TMDB
//
//  Created by admin on 7/3/20.
//

import Foundation
import SwiftUI

class MovieDetailState: ObservableObject {
    
    private let movieService: MovieService
    @Published var movie: Movie?
    @Published var error: NSError?
    @Published var isLoading: Bool = false
    
    init(movieService: MovieService = MovieStore.shared) {
        self.movieService = movieService
    }
    
    func loadMovie(movieId: Int) {
        isLoading = true
        movieService.fetchMovie(id: movieId) {[weak self] (result) in
            guard let self = self else {return}
            self.isLoading = false
            switch result {
            case .failure(let error):
                self.error = error as NSError
            case .success(let movie):
                self.movie = movie
            }
        }
    }
}

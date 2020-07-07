//
//  MovieSearchState.swift
//  TMDB
//
//  Created by admin on 7/5/20.
//

import Foundation
import Combine

class MovieSearchState: ObservableObject {
    
    @Published var query: String = ""
    @Published var movies: [Movie]?
    @Published var isLoading: Bool = false
    @Published var error: NSError?
    
    private var subscriptionToken: AnyCancellable?
    
    private let movieService: MovieService
    
    init(movieStore: MovieService = MovieStore.shared) {
        self.movieService = movieStore
    }
    
    func startObserve() {
        guard subscriptionToken == nil else {return}
        
        self.subscriptionToken = self.$query
            .map {[weak self] text in
                self?.movies = nil
                self?.error = nil
                return text
            }.throttle(for: 1, scheduler: DispatchQueue.main, latest: true)
            .sink(receiveValue: { [weak self] in self?.search($0) })
    }
    
    func search(_ searchText: String) {
        self.movies = nil
        self.error = nil
        self.isLoading = false
        
        guard !searchText.isEmpty else { return }
        
        self.isLoading = true
        movieService.searchMovie(queryString: searchText) {[weak self] (result) in
            guard let self = self, self.query == searchText else { return }
            
            self.isLoading = false
            switch result {
            case .success(let response):
                self.movies = response.results
            case .failure(let error):
                self.error = error as NSError
            }
        }
    }
    
    deinit {
        subscriptionToken?.cancel()
        subscriptionToken = nil
    }
    
}

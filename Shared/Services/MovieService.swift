//
//  MovieService.swift
//  iOS
//
//  Created by admin on 6/29/20.
//

import Foundation

protocol MovieService {
    func fetchMovies(from endpoint : MovieListEndpoint, completionBlock : @escaping (Result<MovieResponse, MovieError>)->())
    func fetchMovie(id : Int, completionBlock : @escaping (Result<Movie, MovieError>)->())
    func searchMovie(queryString : String, completionBlock : @escaping (Result<MovieResponse, MovieError>)->())
}


enum MovieListEndpoint : String, CaseIterable {
    case nowPlaying = "now_playing"
    case upcoming
    case popular
    case topRated = "top_rated"
    
    var description : String {
        switch self {
        case .nowPlaying : return "Now Playing"
        case .upcoming :   return "Upcoming"
        case .popular :    return "Popular"
        case .topRated :   return "Top Rated"
        }
    }
}

enum MovieError : Error, CustomNSError {
    case apiError
    case invalidEndpoint
    case invalidResponse
    case noData
    case serializationError
    
    var description : String {
        switch self {
        case .apiError :             return "Failed to fetch data"
        case .invalidEndpoint :      return "Invalid Endpoint"
        case .invalidResponse :      return "Invalid response"
        case .noData :               return "No data available"
        case .serializationError :   return "Failed to decode data"
        }
    }
    
    var errorUserInfo : [String : Any] {
        [NSLocalizedDescriptionKey : description]
    }
}

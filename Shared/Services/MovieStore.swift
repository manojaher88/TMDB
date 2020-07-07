//
//  MovieStore.swift
//  iOS
//
//  Created by admin on 6/29/20.
//

import Foundation

class MovieStore : MovieService {
    
    static let shared = MovieStore()
    private let API_KEY = "API_KEY"
    private let BASE_URL = "https://api.themoviedb.org/3"
    private let sharedSession = URLSession.shared
    
    private let jsonDecoder = Utils.jsonDecoder
    
    private init() {}
    
    
    
    func fetchMovies(from endpoint: MovieListEndpoint, completionBlock: @escaping (Result<MovieResponse, MovieError>) -> ()) {
        guard let url = URL(string: "\(BASE_URL)/movie/\(endpoint.rawValue)") else {
            completionBlock(.failure(.invalidEndpoint))
            return
        }
        loadAndDecode(url: url, completion: completionBlock)
    }
    
    func fetchMovie(id: Int, completionBlock: @escaping (Result<Movie, MovieError>) -> ()) {
        guard let url = URL(string: "\(BASE_URL)/movie/\(id)") else {
            completionBlock(.failure(.invalidEndpoint))
            return
        }
        loadAndDecode(url: url, params: ["append_to_response" : "videos,credits"], completion: completionBlock)
    }
    
    func searchMovie(queryString: String, completionBlock: @escaping (Result<MovieResponse, MovieError>) -> ()) {
        guard let url = URL(string: "\(BASE_URL)/search/movie") else {
            completionBlock(.failure(.invalidEndpoint))
            return
        }
        loadAndDecode(url: url,
                      params: ["language" : "en_us",
                               "include_adult": "false",
                               "region" : "US",
                               "query": queryString],
                      completion: completionBlock)
    }
    
    
    private func loadAndDecode<D: Decodable>(url: URL, params: [String : String]? = nil, completion: @escaping (Result<D, MovieError>)->()) {
        
        guard var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false) else {
            completion(.failure(.invalidEndpoint))
            return
        }
        
        var queryItems: [URLQueryItem] = params?.map {URLQueryItem(name: $0, value: $1)} ?? []
        queryItems.append(URLQueryItem(name: "api_key", value: API_KEY))
        
        urlComponents.queryItems = queryItems
        
        guard let finalUrl = urlComponents.url else {
            completion(.failure(.invalidEndpoint))
            return
        }
        
        sharedSession.dataTask(with: finalUrl) {[weak self] (data, response, error) in
            
            guard let self = self else {
                return
            }
            
            if error != nil {
                self.executeCompletionHandlerInMainThread(with: .failure(.apiError), completion: completion)
                return
            }
            
            guard let urlReponse = response as? HTTPURLResponse,
                  200..<299 ~= urlReponse.statusCode else {
                self.executeCompletionHandlerInMainThread(with: .failure(.invalidResponse), completion: completion)
                return
            }
            
            guard let data = data else {
                self.executeCompletionHandlerInMainThread(with: .failure(.noData), completion: completion)
                return
            }
            
            do {
                let dataModel: D = try self.jsonDecoder.decode(D.self, from: data)
                self.executeCompletionHandlerInMainThread(with: .success(dataModel), completion: completion)
            } catch {
                self.executeCompletionHandlerInMainThread(with: .failure(.serializationError), completion: completion)
            }
        }.resume()
    }
    
    func executeCompletionHandlerInMainThread<D: Decodable>(with result: Result<D, MovieError>, completion: @escaping (Result<D, MovieError>)-> ()) {
        
        DispatchQueue.main.async {
            completion(result)
        }
    }
}

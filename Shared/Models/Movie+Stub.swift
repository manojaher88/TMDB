//
//  Movie+Stub.swift
//  iOS
//
//  Created by admin on 6/29/20.
//

import Foundation


extension Movie {
    
    static var stubbedMovies: [Movie] {
        let response: MovieResponse? = try? Bundle.main.loadAndDecodeJson(fileName: "Now_Playing")
        return response!.results
    }
    
    static var stubbedMovie: Movie {
        stubbedMovies[4]
    }
}


extension Bundle {
    func loadAndDecodeJson<D: Decodable>(fileName: String) throws -> D? {
        do {
            guard let url = self.url(forResource: fileName, withExtension: "json") else {
                return nil
            }
            
            let data = try Data(contentsOf: url)
            let decodedModel = try Utils.jsonDecoder.decode(D.self, from: data)
            return decodedModel  
        } catch {
            print(error)
            throw error
        }
    }
}

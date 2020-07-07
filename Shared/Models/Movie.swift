//
//  Movie.swift
//  iOS
//
//  Created by admin on 6/29/20.
//

import Foundation


// MARK: - MovieResponse
struct MovieResponse : Decodable {
    let results: [Movie]
    //    let page, totalResults: Int
    //    let dates: Dates
    //    let totalPages: Int
}

// MARK: - Dates
struct Dates : Decodable {
    let maximum, minimum: String
}

// MARK: - Movie
struct Movie : Decodable, Identifiable {
    let popularity: Double
    let voteCount: Int
    let video: Bool
    let posterPath: String?
    let backdropPath: String?
    let id: Int
    let adult: Bool
    let voteAverage: Double
    let originalLanguage, originalTitle: String
    let title: String
    let overview, releaseDate: String
    
    // Movie Info
    let genres: [Genre]?
    let runtime: Int?
    let credits: MovieCredit?
    let videos: MovieVideoResponse?
    
    var posterURL: URL {
        return URL(string: "https://image.tmdb.org/t/p/w500\(posterPath!)")!
    }
    
    var genre: String {
        genres?.first?.name ?? "N/A"
    }
    
    var ratingText: String {
        let rating = Int(voteAverage)
        return (0..<rating).reduce("") { (acc, _) -> String in
            acc + "🌟"
        }
    }
    
    var backdropPathURL: URL {
        let imagePath = self.backdropPath ?? posterPath!
        return URL(string: "https://image.tmdb.org/t/p/w500\(imagePath)")!
    }
    
    var scoreText: String {
        let rating = ratingText.count
        guard rating > 0  else {return "N/A"}
        return "\(rating)/10"
    }
    
    var yearText: String {
        guard let date = Utils.dateFormatter.date(from: releaseDate) else { return "N/A"}
        return Utils.yearFormatter.string(from: date)
    }
    
    static var timeFormatterComponents: DateComponentsFormatter = {
        let timeFormatter = DateComponentsFormatter()
        timeFormatter.unitsStyle = .full
        timeFormatter.allowedUnits = [.hour, .minute]
        return timeFormatter
    }()
    
    var runTimeText: String {
        guard let runtime = self.runtime else {return "N/A"}
        return Movie.timeFormatterComponents.string(from: TimeInterval(runtime) * 60) ?? "N/A"
    }
    
    var cast: [MovieCast]? {
        credits?.cast
    }
    
    var crew: [MovieCrew]? {
        credits?.crew
    }
    
    var director: [MovieCrew]? {
        crew?.filter({$0.job.caseInsensitiveCompare("director") == .orderedSame})
    }
    
    var screenWriters: [MovieCrew]? {
        crew?.filter({$0.job.caseInsensitiveCompare("story") == .orderedSame})
    }
    
    var producers: [MovieCrew]? {
        crew?.filter({$0.job.caseInsensitiveCompare("producer") == .orderedSame})
    }
    
    var youtubeTrailers: [MovieTrailer]? {
        return videos?.results.filter({$0.videoURL != nil})
    }
}

struct Genre : Decodable {
    let name: String
}

// MARK: - MovieCredit
struct MovieCredit : Decodable {
    let cast: [MovieCast]
    let crew: [MovieCrew]
}


// MARK: - MovieCrew
struct MovieCrew : Decodable, Identifiable {
    let creditId, department: String
    let gender, id: Int
    let job, name: String
    let profilePath: String?
}

// MARK: - MovieCast
struct MovieCast : Decodable, Identifiable {
    let castId: Int
    let character, creditId: String
    let gender, id: Int
    let name: String
    let order: Int
    let profilePath: String?
}

// MARK: - MovieVideoResponse
struct MovieVideoResponse: Decodable {
    let results: [MovieTrailer]
}

// MARK: - MovieTrailer
struct MovieTrailer: Decodable, Identifiable {
    let id: String
    let key: String
    let name: String
    let site: String
    let size: Int
    let type: String
    
    var videoURL: URL? {
        guard self.site.caseInsensitiveCompare("youtube") == .orderedSame else { return nil }
        return URL(string: "https://www.youtube.com/watch?v=\(key)")
    }
}

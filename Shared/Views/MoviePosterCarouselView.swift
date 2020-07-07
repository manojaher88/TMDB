//
//  MoviePosterCarouselView.swift
//  TMDB
//
//  Created by admin on 7/2/20.
//

import SwiftUI

struct MoviePosterCarouselView: View {
    
    let movies: [Movie]
    let title: String
    
    var body: some View {
        LazyVStack(alignment: .leading) {
            Text(title)
                .font(.title)
                .fontWeight(.bold)
            
            ScrollView(.horizontal) {
                HStack(spacing: 16) {
                    ForEach(movies) { movie in
                        NavigationLink(
                            destination: MovieDetailView(movieId: movie.id)) {
                            ZStack(alignment: Alignment(horizontal: .center, vertical: .center)) {
                                Text(movie.title)
                                    .font(.title3)
                                    .fontWeight(.bold)
                                    .multilineTextAlignment(.center)
                                    .padding([.leading, .trailing], 10)
                                    .frame(width: 204, height: 306, alignment: .center)
                                MoviePosterCard(movie: movie)
                            }
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
            }
        }
    }
}

struct PosterMovieCarouselView_Previews: PreviewProvider {
    static var previews: some View {
        MoviePosterCarouselView(movies: Movie.stubbedMovies, title: "Now Playing")
    }
}

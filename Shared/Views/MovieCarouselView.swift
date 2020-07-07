//
//  MovieCarouselView.swift
//  TMDB
//
//  Created by admin on 7/2/20.
//

import SwiftUI

struct MovieCarouselView: View {
    let title: String
    let movies: [Movie]
    var body: some View {
        LazyVStack(alignment: .leading, spacing: 0) {
            Text(title)
                .font(.title)
                .fontWeight(.bold)
                .padding(.bottom, 15)
                .padding(.leading, 10)
            
            ScrollView(.horizontal, showsIndicators: false, content: {
                LazyHStack(spacing: 16) {
                    ForEach(movies) {(movie) in
                        NavigationLink(destination:MovieDetailView(movieId: movie.id)) {
                            MovieBackdropCard(movie: movie)
                                .frame(width: 272, height: 200, alignment: .center)
                        }
                        .buttonStyle(PlainButtonStyle())
                        .padding(.leading, movie.id == self.movies.first!.id ? 10 : 0)
                        .padding(.trailing, movie.id == self.movies.last!.id ? 10 : 0)
                    }
                }
            })
        }
    }
}

struct MovieCarouselView_Previews: PreviewProvider {
    static var previews: some View {
        MovieCarouselView(title: "Now Playing", movies: Movie.stubbedMovies)
    }
}

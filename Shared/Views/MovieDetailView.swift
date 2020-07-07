//
//  MoviewDetailView.swift
//  TMDB
//
//  Created by admin on 7/3/20.
//

import SwiftUI

struct MovieDetailView: View {
    let movieId: Int
    @StateObject private var movieDetailState = MovieDetailState()
    
    var body: some View {
        ZStack {
            LoadingView(isLoading: movieDetailState.isLoading, error: movieDetailState.error) {
                self.movieDetailState.loadMovie(movieId: movieId)
            }
            if let movie = movieDetailState.movie {
                MovieDetailListView(movie: movie)
            }
        }
        .navigationTitle(movieDetailState.movie?.title ?? "")
        .listStyle(PlainListStyle())
        .onAppear {
            self.movieDetailState.loadMovie(movieId: movieId)
        }
    }
}


struct MovieDetailListView: View {
    let movie: Movie
    @State private var selectedTrailer: MovieTrailer?
    var body: some View {
        List {
            MovieDetailImage(imageURL: movie.backdropPathURL)
            LazyHStack{
                Text(movie.genre)
                Text("・")
                Text(movie.yearText)
                Text(movie.runTimeText)
            }
            Text(movie.overview)
            if let ratingText = movie.ratingText {
                LazyHStack {
                    Text(ratingText)
                    Text(movie.scoreText)
                }
                .listRowInsets(EdgeInsets(top: 0, leading: 30, bottom: 0, trailing: 0))
            }
            if let movieCrew = movie.crew, !movieCrew.isEmpty {
                HStack(alignment: .top, spacing: nil) {
                    if let movieCast = movie.cast, !movieCast.isEmpty {
                        LazyVStack(alignment: .leading, spacing: 4) {
                            Text("Starring")
                                .font(.headline)
                            ForEach(movieCast.prefix(5)) { cast in
                                Text(cast.name)
                            }
                        }
                    }
                    LazyVStack(alignment: .leading, spacing: 4) {
                        if let directors = movie.director, !directors.isEmpty {
                            Text("Director(s)")
                                .font(.headline)
                            ForEach(directors.prefix(5)) { cast in
                                Text(cast.name)
                            }
                        }
                        if let producers = movie.producers, !producers.isEmpty {
                            Text("Producer(s)")
                                .font(.headline)
                                .padding(.top, 10)
                            ForEach(producers.prefix(5)) { cast in
                                Text(cast.name)
                            }
                        }
                        if let screenWriters = movie.screenWriters, !screenWriters.isEmpty {
                            Text("Screenwriter(s)")
                                .font(.headline)
                                .padding(.top, 10)
                            ForEach(screenWriters.prefix(5)) { cast in
                                Text(cast.name)
                            }
                        }
                    }
                }
            }
            if let trailers = movie.youtubeTrailers, !trailers.isEmpty {
                Text("Trailers")
                    .font(.headline)
                ForEach(trailers) { trailer in
                    Button(action: {
                        selectedTrailer = trailer
                    }) {
                        LazyHStack {
                            Text(trailer.name)
                            Spacer()
                            Image(systemName: "play.circle.fill")
                                .foregroundColor(.blue)
                        }
                    }
                }
            }
        }
        .sheet(item: $selectedTrailer) { trailer in
            SafariViewController(url: trailer.videoURL!)
        }
    }
}

struct MovieDetailImage: View {
    
    @StateObject private var imageLoader = ImageLoader()
    let imageURL: URL
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color.gray.opacity(0.3), style: FillStyle())
            if let image = imageLoader.image {
                Image(uiImage: image)
                    .resizable()
            }
        }.aspectRatio(CGSize(width: 16, height: 9), contentMode: .fit)
        .onAppear {
            imageLoader.loadImage(with: imageURL)
        }
    }
}

struct MovieDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            MovieDetailView(movieId: Movie.stubbedMovie.id)
        }
    }
}

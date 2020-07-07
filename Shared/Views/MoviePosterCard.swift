//
//  MoviewPosterCard.swift
//  TMDB
//
//  Created by admin on 7/2/20.
//

import SwiftUI

struct MoviePosterCard: View {
    let movie: Movie
    @StateObject private var imageLoader = ImageLoader()
    
    var body: some View {
        ZStack {
            if let image = imageLoader.image {
                Image(uiImage: image)
                    .resizable()
            } else {
                Rectangle()
                    .fill(Color.gray.opacity(0.3), style: FillStyle(eoFill: true, antialiased: true))
            }
        }
        .frame(width: 204, height: 306, alignment: .center)
        .cornerRadius(8)
        .shadow(radius: 4)
        .onAppear {
            imageLoader.loadImage(with: movie.posterURL)
        }
    }
}

struct MoviePosterCard_Previews: PreviewProvider {
    static var previews: some View {
        MoviePosterCard(movie: Movie.stubbedMovie)
    }
}

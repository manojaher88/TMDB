//
//  MovieBackdropCard.swift
//  TMDB
//
//  Created by admin on 6/30/20.
//

import SwiftUI

struct MovieBackdropCard: View {
    
    let movie: Movie
    @StateObject private var imageLoader = ImageLoader()
    
    var body: some View {
        LazyVStack(alignment: .leading) {
            ZStack {
                Rectangle()
                    .fill(Color.gray.opacity(0.3), style: FillStyle(eoFill: true, antialiased: true))
                    .cornerRadius(4)
                
                if let image = self.imageLoader.image {
                    Image(uiImage: image)
                        .resizable()
                }
            }
            .aspectRatio(CGSize(width: 16, height: 9), contentMode: .fit)
            .cornerRadius(8.0)
            .shadow(radius: 4, x: 4, y: 4)
            
            Text(movie.title)
                .lineLimit(1)
                .font(.title3)
                .padding(.bottom, 5)
        }
        .onAppear {
            self.imageLoader.loadImage(with: movie.backdropPathURL)
        }
    }
}

struct MovieBackdropCard_Previews: PreviewProvider {
    static var previews: some View {
        MovieBackdropCard(movie: Movie.stubbedMovie)
    }
}

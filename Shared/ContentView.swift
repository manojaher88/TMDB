//
//  ContentView.swift
//  Shared
//
//  Created by admin on 6/29/20.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        MovieDetailView(movieId: Movie.stubbedMovie.id)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MovieBackdropCard(movie: Movie.stubbedMovie)
    }
}

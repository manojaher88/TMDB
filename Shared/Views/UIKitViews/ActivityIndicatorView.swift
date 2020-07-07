//
//  ActivityIndicatorView.swift
//  TMDB
//
//  Created by admin on 7/3/20.
//

import SwiftUI

struct ActivityIndicatorView: UIViewRepresentable {

    func makeUIView(context: Context) -> some UIActivityIndicatorView {
        let indicatorView = UIActivityIndicatorView(style: .large)
        indicatorView.startAnimating()
        return indicatorView
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
    }
}

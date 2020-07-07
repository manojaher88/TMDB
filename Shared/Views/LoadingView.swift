//
//  LoadingView.swift
//  TMDB
//
//  Created by admin on 7/3/20.
//

import SwiftUI

struct LoadingView: View {
    
    var isLoading: Bool
    let error: NSError?
    let retryAction: (()->())?
    
    var body: some View {
        Group {
            if isLoading {
                LazyHStack {
                    Spacer()
                    ActivityIndicatorView()
                    Spacer()
                }
            } else if let error = error {
                LazyHStack {
                    Spacer()
                    LazyVStack(spacing: 4) {
                        Text(error.localizedDescription)
                            .font(.headline)
                        if let action = retryAction {
                            Button("Retry", action: action)
                                .foregroundColor(.blue)
                                .buttonStyle(PlainButtonStyle())
                        }
                    }
                    Spacer()
                }
            }
        }
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView(isLoading: true, error: NSError(domain: "Test", code: 123, userInfo: nil)) {
            print("Retry")
        }
    }
}

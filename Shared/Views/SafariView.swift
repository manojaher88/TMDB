//
//  SafariView.swift
//  TMDB
//
//  Created by admin on 7/4/20.
//

import SafariServices
import Foundation
import SwiftUI

struct SafariViewController: UIViewControllerRepresentable {
    
    let url: URL
    
    func makeUIViewController(context: Context) -> some UIViewController {
        SFSafariViewController(url: url)
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
    }
    
}

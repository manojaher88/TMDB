//
//  SearchBar.swift
//  TMDB
//
//  Created by admin on 7/5/20.
//


import SwiftUI

struct SearchBarView: UIViewRepresentable {
    
    let placeHolder: String
    @Binding var searhText: String
    
    func makeUIView(context: Context) -> some UISearchBar {
        let searchBar = UISearchBar(frame: .zero)
        searchBar.placeholder = placeHolder
        searchBar.searchBarStyle = .minimal
        searchBar.enablesReturnKeyAutomatically = false
        searchBar.delegate = context.coordinator
        return searchBar
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        uiView.text = searhText
    }
    
    func makeCoordinator() -> SearchCoordinator {
        SearchCoordinator(text: self.$searhText)
    }
    
    class SearchCoordinator: NSObject, UISearchBarDelegate {
        @Binding var text: String
        init(text: Binding<String>) {
            _text = text
        }
        
        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            self.text = searchText
        }
        
        func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
            searchBar.resignFirstResponder()
        }
    }
}

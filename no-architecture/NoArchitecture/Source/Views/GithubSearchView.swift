//
//  GithubSearchView.swift
//  NoArchitecture
//
//  Created by unagami on 2023/02/02.
//

import SwiftUI

struct GithubSearchView: View {
    
    @State private (set) var isNavigation = false
    
    @State private var inputText: String = ""
    @State private var loading: Bool = false
    @State private var searchItems: [SearchItem] = []
    
    var body: some View {
        VStack {
            if loading {
                ProgressView()
            } else {
                Image("icon-github")
            }
            VStack(alignment: .leading) {
                HStack {
                    Image(systemName: "magnifyingglass")
                    TextField("Search...", text: $inputText)
                        .onSubmit {
                            loading = true
                            GithubAPI.searchRepositories(inputText) {
                                loading = false
                                isNavigation = true
                                searchItems = $0
                            }
                        }
                        .autocapitalization(.none)
                        .keyboardType(.asciiCapable)
                        .submitLabel(.done)
                }
                .textFieldStyle(RoundedBorderTextFieldStyle())
            }.padding()
        }
        .padding()
        .navigationDestination(isPresented: $isNavigation) {
            GithubSearchResultView(searchItems: searchItems)
        }
    }
}

struct GithubSearchView_Previews: PreviewProvider {
    static var previews: some View {
        GithubSearchView()
    }
}

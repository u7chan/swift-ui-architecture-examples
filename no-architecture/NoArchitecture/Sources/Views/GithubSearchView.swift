//
//  GithubSearchView.swift
//  NoArchitecture
//
//  Created by unagami on 2023/02/02.
//

import SwiftUI

struct GithubSearchView: View {
    @State private(set) var isNavigation = false

    @State private var inputText: String = ""
    @State private var loading: Bool = false
    @State private var searchItems: [SearchItem] = []

    var body: some View {
        VStack {
            if loading {
                ProgressView()
            } else {
                Image("GithubIcon")
            }
            HStack {
                Image(systemName: "magnifyingglass")
                TextField("Search...", text: $inputText)
                    .onSubmit {
                        let srcInputText = inputText.trimmingCharacters(in: .whitespaces)
                        if srcInputText.isEmpty {
                            return
                        }
                        loading = true
                        GithubAPI.searchRepositories(srcInputText) {
                            loading = false
                            isNavigation = true
                            searchItems = $0
                        }
                    }
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .autocapitalization(.none)
                    .keyboardType(.asciiCapable)
                    .submitLabel(.done)
            }
            .padding()
        }
        .modifier(FullFrameModifier())
        .padding()
        .background(Color("Background"))
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

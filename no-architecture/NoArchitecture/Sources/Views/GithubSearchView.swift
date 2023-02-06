//
//  GithubSearchView.swift
//  NoArchitecture
//
//  Created by unagami on 2023/02/02.
//

import SwiftUI

struct GithubSearchView: View {
    @State private var isNavigation = false
    @State private var inputText = ""
    @State private var loading = false
    @State private var noSearchResult = false
    @State private var invalidInput = false
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
                        invalidInput = srcInputText.isEmpty || githubUserNameValidator(srcInputText)
                        if invalidInput {
                            return
                        }
                        loading = true
                        GithubAPI.searchRepositories(srcInputText) {
                            loading = false
                            noSearchResult = $0.isEmpty
                            if $0.isEmpty {
                                return
                            }
                            searchItems = $0
                            isNavigation = true
                        }
                    }
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .autocapitalization(.none)
                    .keyboardType(.asciiCapable)
                    .submitLabel(.done)
            }
            .padding()
            if invalidInput {
                Text("Invalid username")
                    .foregroundColor(Color.red)
            }
            if noSearchResult {
                Text("Not found.")
            }
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

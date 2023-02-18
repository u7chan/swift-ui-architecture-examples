//
//  GithubSearchView.swift
//  NoArchitecture
//
//  Created by unagami on 2023/02/02.
//

import SwiftUI

struct GithubSearchView: View {
    @StateObject private var viewModel = GithubSearchViewModel()

    var body: some View {
        VStack {
            if viewModel.loading {
                ProgressView()
            } else {
                Image("GithubIcon")
            }
            HStack {
                Image(systemName: "magnifyingglass")
                TextField("Search...", text: $viewModel.inputText)
                    .onSubmit {
                        viewModel.searchText()
                    }
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .autocapitalization(.none)
                    .keyboardType(.asciiCapable)
                    .submitLabel(.done)
            }
            .padding()
            if viewModel.invalidInput {
                Text("Invalid username")
                    .foregroundColor(Color.red)
            }
            if viewModel.noSearchResult {
                Text("Not found.")
            }
        }
        .modifier(FullFrameModifier())
        .padding()
        .background(Color("Background"))
        .navigationDestination(isPresented: $viewModel.shouldNavigate) {
            GithubSearchResultView()
        }
    }
}

struct GithubSearchView_Previews: PreviewProvider {
    static var previews: some View {
        GithubSearchView()
    }
}

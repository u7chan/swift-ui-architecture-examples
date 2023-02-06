//
//  GithubSearchResultView.swift
//  NoArchitecture
//
//  Created by unagami on 2023/02/03.
//

import SwiftUI

struct GithubSearchResultView: View {
    @ObservedObject private var viewModel: GithubSearchResultViewModel

    init(viewModel: GithubSearchResultViewModel = GithubSearchResultViewModel()) {
        self.viewModel = viewModel
    }

    var body: some View {
        VStack {
            List {
                ForEach(viewModel.searchItems) { item in
                    NavigationLink(destination: {
                        GithubDetailView(searchItem: item)
                    }) {
                        Text(item.name)
                    }
                }
            }
        }
        .scrollContentBackground(.hidden)
        .navigationTitle("Repositories")
        .navigationBarTitleDisplayMode(.inline)
        .background(Color("Background"))
    }
}

struct GithubSearchResultView_Previews: PreviewProvider {
    static var previews: some View {
        GithubSearchResultView()
    }
}

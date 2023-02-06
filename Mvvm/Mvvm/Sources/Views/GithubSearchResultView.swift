//
//  GithubSearchResultView.swift
//  NoArchitecture
//
//  Created by unagami on 2023/02/03.
//

import SwiftUI

struct GithubSearchResultView: View {
    private let searchItems: [SearchItem]

    init(searchItems: [SearchItem]) {
        self.searchItems = searchItems
    }

    var body: some View {
        VStack {
            List {
                ForEach(searchItems, id: \.self) { item in
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
        GithubSearchResultView(searchItems: [SearchItem(id: 1,
                                                        name: "Dummy",
                                                        language: "Swift",
                                                        stargazers_count: 1,
                                                        watchers_count: 10)])
    }
}

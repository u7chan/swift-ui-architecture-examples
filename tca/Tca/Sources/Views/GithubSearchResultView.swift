//
//  GithubSearchResultView.swift
//  Tca
//
//  Created by unagami on 2023/02/03.
//

import SwiftUI

struct GithubSearchResultView: View {
    private let searchItems: [SearchItem]
    @State private var searchItem: SearchItem?
    @State private var isNavigation = false

    init(searchItems: [SearchItem]) {
        self.searchItems = searchItems
    }

    var body: some View {
        VStack {
            NavigationStack {
                List {
                    ForEach(searchItems) { item in
                        Text(item.name)
                            .onTapGesture {
                                searchItem = item
                                isNavigation = true
                            }
                    }
                }
            }.navigationDestination(isPresented: $isNavigation) {
                if let searchItem {
                    GithubDetailView(searchItem: searchItem)
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

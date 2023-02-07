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
            NavigationStack {
                List {
                    ForEach(viewModel.searchItems) { item in
                        Text(item.name)
                            .onTapGesture {
                                viewModel.onRowTapped(item: item)
                            }
                    }
                }
            }.navigationDestination(isPresented: $viewModel.shouldNavigate) {
                GithubDetailView()
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

//
//  GithubSearchResultView.swift
//  NoArchitecture
//
//  Created by unagami on 2023/02/03.
//

import SwiftUI

struct GithubSearchResultView: View {
    @StateObject private var viewModel = GithubSearchResultViewModel()

    var body: some View {
        VStack {
            NavigationStack {
                List($viewModel.searchItems) { $item in
                    Text(item.name)
                        .onTapGesture {
                            viewModel.rowTapped(item: item)
                        }
                }
                .onAppear {
                    viewModel.fetch()
                }
            }
            .navigationDestination(isPresented: $viewModel.shouldNavigate) {
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

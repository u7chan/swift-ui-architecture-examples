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
//            Button {
//                viewModel.fetch()
//            } label: {
//                Text("Fetch")
//            }
            NavigationStack {
                List($viewModel.searchItems) { $item in
                    Text(item.name)
                        .onTapGesture {
                            viewModel.rowTapped(item: item)
                        }
                }
                .onAppear {
                    viewModel.fetch() // !!! Not working データは取得されるが再描画されない !!!
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

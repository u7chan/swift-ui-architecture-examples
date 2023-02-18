//
//  GithubDetailView.swift
//  NoArchitecture
//
//  Created by unagami on 2023/02/03.
//

import SwiftUI

struct GithubDetailView: View {
    @StateObject private var viewModel = GithubDetailViewModel()
    @State private var navigationTitle = ""

    var body: some View {
        ZStack {
            if let searchItem = viewModel.searchItem {
                VStack(alignment: .leading, spacing: 8) {
                    HStack {
                        Text("id: ")
                        Text("\(String(searchItem.id))")
                    }
                    HStack {
                        Text("name: ")
                        Text(searchItem.name)
                    }
                    HStack {
                        Text("language: ")
                        Text(searchItem.language ?? "")
                    }
                }.onAppear {
                    navigationTitle = searchItem.name
                }
            } else {
                ProgressView()
            }
        }
        .onAppear {
            viewModel.fetch()
        }
        .modifier(FullFrameModifier())
        .navigationTitle(navigationTitle)
        .navigationBarTitleDisplayMode(.inline)
        .background(Color("Background"))
    }
}

struct GithubDetailView_Previews: PreviewProvider {
    static var previews: some View {
        GithubDetailView()
    }
}

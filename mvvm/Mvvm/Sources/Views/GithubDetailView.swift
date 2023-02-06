//
//  GithubDetailView.swift
//  NoArchitecture
//
//  Created by unagami on 2023/02/03.
//

import SwiftUI

struct GithubDetailView: View {
    @ObservedObject private var viewModel: GithubDetailViewModel

    init(viewModel: GithubDetailViewModel = GithubDetailViewModel()) {
        self.viewModel = viewModel
    }

    var body: some View {
        if let searchItem = viewModel.searchItem {
            ZStack {
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
                }
            }
            .modifier(FullFrameModifier())
            .navigationTitle(searchItem.name)
            .navigationBarTitleDisplayMode(.inline)
            .background(Color("Background"))
        } else {
            ProgressView()
        }
    }
}

struct GithubDetailView_Previews: PreviewProvider {
    static var previews: some View {
        GithubDetailView()
    }
}

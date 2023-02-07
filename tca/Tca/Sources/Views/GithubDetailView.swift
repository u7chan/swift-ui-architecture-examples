//
//  GithubDetailView.swift
//  Tca
//
//  Created by unagami on 2023/02/03.
//

import SwiftUI

struct GithubDetailView: View {
    private let searchItem: SearchItem

    init(searchItem: SearchItem) {
        self.searchItem = searchItem
    }

    var body: some View {
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
    }
}

struct GithubDetailView_Previews: PreviewProvider {
    static var previews: some View {
        GithubDetailView(searchItem: SearchItem(id: 1,
                                                name: "Dummy",
                                                language: "Swift",
                                                stargazers_count: 1,
                                                watchers_count: 10))
    }
}

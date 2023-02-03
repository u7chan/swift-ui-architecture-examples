//
//  GithubSearchResultView.swift
//  TCA
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
        Text(searchItems.map{ $0.toString()}.joined(separator: "\n" ))
    }
}

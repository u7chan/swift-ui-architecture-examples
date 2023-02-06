//
//  GithubSearchResultViewModel.swift
//  Mvvm
//
//  Created by unagami on 2023/02/06.
//

import Foundation

final class GithubSearchResultViewModel: ObservableObject {
    @Published var searchItems: [SearchItem] = []
}

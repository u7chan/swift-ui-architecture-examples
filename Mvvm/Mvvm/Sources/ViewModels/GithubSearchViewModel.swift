//
//  GithubSearchViewModel.swift
//  Mvvm
//
//  Created by unagami on 2023/02/06.
//

import Foundation

final class GithubSearchViewModel: ObservableObject {

    @Published var isNavigation = false
    @Published var inputText = ""

    @Published private (set) var loading = false
    @Published private (set) var noSearchResult = false
    @Published private (set) var invalidInput = false
    @Published private (set) var searchItems: [SearchItem] = []

    func onSubmit() {
        let srcInputText = inputText.trimmingCharacters(in: .whitespaces)
        invalidInput = srcInputText.isEmpty || githubUserNameValidator(srcInputText)
        if invalidInput {
            return
        }
        loading = true
        GithubAPI.searchRepositories(srcInputText) {
            self.loading = false
            self.noSearchResult = $0.isEmpty
            if $0.isEmpty {
                return
            }
            self.searchItems = $0
            self.isNavigation = true
        }
    }

}

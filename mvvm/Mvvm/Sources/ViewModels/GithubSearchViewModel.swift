//
//  GithubSearchViewModel.swift
//  Mvvm
//
//  Created by unagami on 2023/02/06.
//

import Combine
import Dispatch

final class GithubSearchViewModel: ObservableObject {
    var inputText = ""

    @Published var isNavigation = false
    @Published private(set) var loading = false
    @Published private(set) var noSearchResult = false
    @Published private(set) var invalidInput = false

    private var cancellable = [AnyCancellable]()
    private let searchItemRepository: SearchItemRepository

    init(searchItemRepository: SearchItemRepository = DI.singleton.searchItemRepository) {
        self.searchItemRepository = searchItemRepository
    }

    func onSubmit() {
        let srcInputText = inputText.trimmingCharacters(in: .whitespaces)
        invalidInput = srcInputText.isEmpty || githubUserNameValidator(srcInputText)
        if invalidInput {
            return
        }
        loading = true
        GithubAPI.searchRepositories(srcInputText)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .finished:
                    // NOP
                    break
                case let .failure(error):
                    print("[ERROR] \(error)")
                }
            } receiveValue: { items in
                self.loading = false
                self.noSearchResult = items.isEmpty
                if items.isEmpty {
                    return
                }
                self.searchItemRepository.postSearchItems(items: items)
                self.isNavigation = true
            }.store(in: &cancellable)
    }
}

//
//  GithubSearchResultViewModel.swift
//  Mvvm
//
//  Created by unagami on 2023/02/06.
//

import Combine

final class GithubSearchResultViewModel: ObservableObject {
    @Published var searchItems: [SearchItem] = []
    @Published var shouldNavigate = false

    private var cancellable = [AnyCancellable]()
    private let searchItemRepository: SearchItemRepository

    init(searchItemRepository: SearchItemRepository = DI.singleton.searchItemRepository) {
        self.searchItemRepository = searchItemRepository
        self.searchItemRepository.fetchSearchItems()
            .sink { completion in
                switch completion {
                case .finished:
                    // NOP
                    break
                case let .failure(error):
                    print("[ERROR] \(error)")
                }
            } receiveValue: { items in
                self.searchItems = items
            }.store(in: &cancellable)
    }

    func onRowTapped(item: SearchItem) {
        searchItemRepository.postSearchItem(item: item)
        shouldNavigate = true
    }
}

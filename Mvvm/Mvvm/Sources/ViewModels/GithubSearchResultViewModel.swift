//
//  GithubSearchResultViewModel.swift
//  Mvvm
//
//  Created by unagami on 2023/02/06.
//

import Combine

final class GithubSearchResultViewModel: ObservableObject {
    @Published var searchItems: [SearchItem] = []

    private var cancellable = [AnyCancellable]()

    init(searchItemRepository: SearchItemRepository = DI.singleton.searchItemRepository) {
        searchItemRepository.fetchSearchItem()
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
    
}

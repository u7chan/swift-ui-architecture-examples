//
//  GithubDetailViewModel.swift
//  Mvvm
//
//  Created by unagami on 2023/02/06.
//

import Combine
import Dispatch

final class GithubDetailViewModel: ObservableObject {
    @Published var searchItem: SearchItem?

    private var cancellable = [AnyCancellable]()
    private let searchItemRepository: SearchItemRepository

    init(searchItemRepository: SearchItemRepository = DI.singleton.searchItemRepository) {
        self.searchItemRepository = searchItemRepository
    }

    func fetch() {
        searchItemRepository.fetchSearchItem()
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .finished:
                    // NOP
                    break
                case let .failure(error):
                    print("[ERROR] \(error)")
                }
            } receiveValue: { item in
                self.searchItem = item
            }.store(in: &cancellable)
    }
}

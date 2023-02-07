//
//  GithubSearchResultViewModel.swift
//  Mvvm
//
//  Created by unagami on 2023/02/06.
//

import Combine
import Dispatch
import Foundation

final class GithubSearchResultViewModel: ObservableObject {
    @Published var searchItems: [SearchItem] = []
    @Published var shouldNavigate = false

    private(set) var objectWillChange = ObservableObjectPublisher()

    private var cancellable = [AnyCancellable]()
    private let searchItemRepository: SearchItemRepository

    init(searchItemRepository: SearchItemRepository = DI.singleton.searchItemRepository) {
        self.searchItemRepository = searchItemRepository
    }

    func fetch() {
        self.searchItemRepository.fetchSearchItems()
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
                print("receive ==> \(items.count)")
                self.searchItems = items
                self.objectWillChange.send()
            }.store(in: &cancellable)
    }

    func rowTapped(item: SearchItem) {
        searchItemRepository.postSearchItem(item: item)
        shouldNavigate.toggle()
        self.objectWillChange.send()
    }
}

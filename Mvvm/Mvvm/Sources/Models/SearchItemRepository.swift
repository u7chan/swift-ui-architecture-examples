//
//  SearchItemRepository.swift
//  Mvvm
//
//  Created by unagami on 2023/02/06.
//

import Combine

enum SearchItemRepositoryError: Error {
    case uninitialized
}

protocol SearchItemRepository {
    func fetchSearchItems() -> AnyPublisher<[SearchItem], SearchItemRepositoryError>
    func postSearchItems(items: [SearchItem])
    func fetchSearchItem() -> AnyPublisher<SearchItem, SearchItemRepositoryError>
    func postSearchItem(item: SearchItem)
}

final class SearchItemRepositoryImpl: SearchItemRepository {
    private var cacheItems: [SearchItem] = []
    private var cacheItem: SearchItem?

    func fetchSearchItems() -> AnyPublisher<[SearchItem], SearchItemRepositoryError> {
        return Future<[SearchItem], SearchItemRepositoryError> { promise in
            promise(.success(self.cacheItems))
        }.eraseToAnyPublisher()
    }

    func postSearchItems(items: [SearchItem]) {
        cacheItems = items
    }

    func fetchSearchItem() -> AnyPublisher<SearchItem, SearchItemRepositoryError> {
        return Future<SearchItem, SearchItemRepositoryError> { promise in
            guard let cacheItem = self.cacheItem else {
                promise(.failure(.uninitialized))
                return
            }
            promise(.success(cacheItem))
        }.eraseToAnyPublisher()
    }

    func postSearchItem(item: SearchItem) {
        cacheItem = item
    }
}

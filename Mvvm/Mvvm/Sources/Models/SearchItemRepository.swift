//
//  SearchItemRepository.swift
//  Mvvm
//
//  Created by unagami on 2023/02/06.
//

import Combine

enum SearchItemRepositoryError: Error {
    case unknown
}

protocol SearchItemRepository {
    func fetchSearchItem() -> AnyPublisher<[SearchItem], SearchItemRepositoryError>
    func postSearchItem(items: [SearchItem])
}

final class SearchItemRepositoryImpl: SearchItemRepository {
    private var cacheitems: [SearchItem] = []

    func fetchSearchItem() -> AnyPublisher<[SearchItem], SearchItemRepositoryError> {
        return Future<[SearchItem], SearchItemRepositoryError> { promise in
            promise(.success(self.cacheitems))
        }.eraseToAnyPublisher()
    }

    func postSearchItem(items: [SearchItem]) {
        cacheitems = items
    }
}

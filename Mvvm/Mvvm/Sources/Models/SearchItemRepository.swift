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
}

final class SearchItemRepositoryImpl: SearchItemRepository {
    func fetchSearchItem() -> AnyPublisher<[SearchItem], SearchItemRepositoryError> {
        return Future<[SearchItem], SearchItemRepositoryError> { promise in
            promise(.success([]))
        }.eraseToAnyPublisher()
    }
}

//
//  DI.swift
//  Mvvm
//
//  Created by unagami on 2023/02/06.
//

import Foundation

class DI {
    static let singleton = DI()

    let searchItemRepository: SearchItemRepository
    private init() {
        searchItemRepository = SearchItemRepositoryImpl()
    }
}

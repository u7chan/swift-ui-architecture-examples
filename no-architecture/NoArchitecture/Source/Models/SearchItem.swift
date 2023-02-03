//
//  SearchItem.swift
//  NoArchitecture
//
//  Created by unagami on 2023/02/04.
//

import Foundation

struct SearchItem: Decodable {
    let id: Int
    let name: String
    let language: String?
    let stargazers_count: Int
    let watchers_count: Int
}


extension SearchItem {
    func toString() -> String {
        return "id=\(id),name=\(name),language=\(language ?? "nil"),stargazers_count=\(stargazers_count),watchers_count=\(watchers_count)"
    }
}

//
//  GithubAPI.swift
//  Models
//
//  Created by unagami on 2023/02/04.
//

import Combine
import Foundation

struct GithubAPIError: Error, Equatable {}

enum GithubAPI {
    static func searchRepositories(_ searchText: String) -> AnyPublisher<[SearchItem], GithubAPIError> {
        let url = "https://api.github.com/users/\(searchText)/repos?per_page=100&page=1&sort=created&direction=desc"
        return URLSession.shared.dataTaskPublisher(for: URL(string: url)!)
            .tryMap { data, _ in try [SearchItem].tryDecode(json: data) }
            .mapError { _ in GithubAPIError() }
            .eraseToAnyPublisher()
    }
}

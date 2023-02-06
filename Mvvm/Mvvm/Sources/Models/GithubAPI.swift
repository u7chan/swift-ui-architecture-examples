//
//  GithubAPI.swift
//  Models
//
//  Created by unagami on 2023/02/04.
//

import Foundation

struct GithubAPI {
    static func searchRepositories(_ searchText: String, _ complete: @escaping ([SearchItem]) -> Void) {
        let rawUrl = "https://api.github.com/users/\(searchText)/repos?per_page=100&page=1&sort=created&direction=desc"
        guard let url = URL(string: rawUrl) else { fatalError("missing URL") }
        let urlRequest = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            if let error = error {
                print("URLSession:error \(error)")
                return
            }
            guard let response = response as? HTTPURLResponse, let data = data else { return }
            DispatchQueue.main.async {
                if response.statusCode != 200 {
                    complete([])
                    return
                }
                complete([SearchItem].decode(json: data) ?? [])
            }
        }
        task.resume()
    }
}

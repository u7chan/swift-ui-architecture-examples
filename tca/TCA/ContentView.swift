//
//  ContentView.swift
//  TCA
//
//  Created by unagami on 2023/02/02.
//

import SwiftUI

struct ContentView: View {
    
    @State var text: String = ""
    @State var loading: Bool = false

    var body: some View {
        VStack {
            if loading {
                ProgressView()
            } else {
                Image("icon-github")
            }
            VStack(alignment: .leading) {
                HStack {
                    Image(systemName: "magnifyingglass")
                    TextField("Search...", text: $text)
                        .onSubmit {
                            loading = true
                            searchRepositories(text) { repositories in
                                loading = false
                                print("#repositories: \(repositories.map { $0.toString() })")
                            }
                        }
                        .autocapitalization(.none)
                        .keyboardType(.asciiCapable)
                        .submitLabel(.done)
                }
                .textFieldStyle(RoundedBorderTextFieldStyle())
            }.padding()
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

private func searchRepositories(_ searchText: String, _ complete: @escaping ([GithubRepository]) -> Void) {
    let rawUrl = "https://api.github.com/users/\(searchText)/repos?per_page=100&page=1&sort=created&direction=desc"
    guard let url = URL(string: rawUrl) else { fatalError("missing URL") }
    let urlRequest = URLRequest(url: url)
    let task = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
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
            complete([GithubRepository].decode(json: data) ?? [])
        }
    }
    task.resume()
}

private extension Decodable {
    static func decode(json data: Data?) -> Self? {
        guard let data = data else { return nil }
        let decoder = JSONDecoder()
        return try? decoder.decode(Self.self, from: data)
    }
}

private struct GithubRepository: Decodable {
    let id: Int
    let name: String
    let language: String?
    let stargazers_count: Int
    let watchers_count: Int
}

private extension GithubRepository {
    func toString() -> String {
        return "id=\(id),name=\(name),language=\(language ?? "nil"),stargazers_count=\(stargazers_count),watchers_count=\(watchers_count)"
    }
}

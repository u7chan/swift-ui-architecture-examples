//
//  SearchReducer.swift
//  Tca
//
//  Created by unagami on 2023/02/07.
//

import Combine
import ComposableArchitecture
import Dispatch

struct SearchReducer: ReducerProtocol {
    struct State: Equatable {
        var inputText = ""
        var invalidInput = false
        var loading = false
        var noSearchResult = false
        var searchItems: [SearchItem] = []
        var isNavigation = false

        enum Route: Equatable, Hashable {
            case navigateToResult
        }
    }

    struct SearchRepositoriesRequestId: Hashable {}

    enum Action: Equatable {
        case textChanged(String)
        case searchRepositories
        case searchRepositoriesResponse(Result<[SearchItem], GithubAPIError>)
        case navigation
    }

    func reduce(into state: inout State, action: Action) -> EffectTask<Action> {
        switch action {
        case let .textChanged(inputText):
            state.inputText = inputText
            return .none

        case .searchRepositories:
            let srcInputText = state.inputText.trimmingCharacters(in: .whitespaces)
            state.invalidInput = srcInputText.isEmpty || githubUserNameValidator(srcInputText)
            if state.invalidInput {
                return .none
            }
            state.loading = true

            return GithubAPI.searchRepositories(srcInputText)
                .receive(on: DispatchQueue.main.eraseToAnyScheduler())
                .catchToEffect()
                .map(Action.searchRepositoriesResponse)
                .cancellable(id: SearchRepositoriesRequestId())

        case let .searchRepositoriesResponse(.success(items)):
            state.loading = false
            state.searchItems = items
            return .send(.navigation)

        case .searchRepositoriesResponse(.failure):
            state.loading = false
            return .none

        case .navigation:
            state.isNavigation.toggle()
            return .none
        }
    }
}

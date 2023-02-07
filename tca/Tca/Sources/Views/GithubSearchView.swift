//
//  GithubSearchView.swift
//  Tca
//
//  Created by unagami on 2023/02/02.
//

import ComposableArchitecture
import SwiftUI

struct GithubSearchView: View {
    let store: StoreOf<SearchReducer>

    init(store: StoreOf<SearchReducer> = Store(initialState: SearchReducer.State(), reducer: SearchReducer())) {
        self.store = store
    }

    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            VStack {
                if viewStore.loading {
                    ProgressView()
                } else {
                    Image("GithubIcon")
                }
                HStack {
                    Image(systemName: "magnifyingglass")
                    TextField("Search...", text: viewStore.binding(get: \.inputText, send: SearchReducer.Action.textChanged))
                        .onSubmit {
                            viewStore.send(SearchReducer.Action.searchRepositories)
                        }
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .autocapitalization(.none)
                        .keyboardType(.asciiCapable)
                        .submitLabel(.done)
                }
                .padding()
                if viewStore.invalidInput {
                    Text("Invalid username")
                        .foregroundColor(Color.red)
                }
                if viewStore.noSearchResult {
                    Text("Not found.")
                }
            }
            .modifier(FullFrameModifier())
            .padding()
            .background(Color("Background"))
            .navigationDestination(isPresented: viewStore.binding(get: \.isNavigation, send: SearchReducer.Action.navigation), destination: {
                GithubSearchResultView(searchItems: viewStore.searchItems)
            })
        }
    }
}

struct GithubSearchView_Previews: PreviewProvider {
    static var previews: some View {
        GithubSearchView()
    }
}

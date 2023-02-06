//
//  GithubDetailViewModel.swift
//  Mvvm
//
//  Created by unagami on 2023/02/06.
//

import Dispatch
import Foundation

final class GithubDetailViewModel: ObservableObject {
    @Published var text = ""

    init() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.text = "Hello"
        }
    }
}

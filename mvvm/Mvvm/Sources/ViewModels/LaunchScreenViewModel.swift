//
//  LaunchScreenViewModel.swift
//  Mvvm
//
//  Created by unagami on 2023/02/06.
//

import Combine
import Dispatch

final class LaunchScreenViewModel: ObservableObject {
    @Published var shouldNavigate = false

    func delayNavigation() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.shouldNavigate = true
        }
    }
}

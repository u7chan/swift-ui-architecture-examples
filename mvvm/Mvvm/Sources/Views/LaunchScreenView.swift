//
//  LaunchScreenView.swift
//  NoArchitecture
//
//  Created by unagami on 2023/02/03.
//

import SwiftUI

struct LaunchScreenView: View {
    @StateObject private var viewModel = LaunchScreenViewModel()

    var body: some View {
        ZStack {
            Text("Example App")
                .onAppear {
                    viewModel.delayNavigation()
                }
                .navigationDestination(isPresented: $viewModel.shouldNavigate) {
                    GithubSearchView()
                        .navigationBarBackButtonHidden(true)
                }
        }
        .modifier(FullFrameModifier())
        .background(Color("Background"))
    }
}

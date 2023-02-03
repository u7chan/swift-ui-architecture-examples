//
//  LaunchScreenView.swift
//  TCA
//
//  Created by unagami on 2023/02/03.
//

import SwiftUI

struct LaunchScreenView: View {

    @State private (set) var isNavigation = false

    var body: some View {
        Text("Example")
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    isNavigation = true
                }
            }.navigationDestination(isPresented: $isNavigation) {
                GithubSearchView()
                    .navigationBarBackButtonHidden(true)
            }
    }
}

//
//  LaunchScreenView.swift
//  NoArchitecture
//
//  Created by unagami on 2023/02/03.
//

import SwiftUI

struct LaunchScreenView: View {
    @State private var isNavigation = false

    var body: some View {
        ZStack {
            Text("Example App")
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        isNavigation = true
                    }
                }
                .navigationDestination(isPresented: $isNavigation) {
                    GithubSearchView()
                        .navigationBarBackButtonHidden(true)
                }
        }
        .modifier(FullFrameModifier())
        .background(Color("Background"))
    }
}

//
//  LaunchScreenView.swift
//  Tca
//
//  Created by unagami on 2023/02/03.
//

import SwiftUI

struct LaunchScreenView: View {
    @State private var shouldNavigate = false

    var body: some View {
        ZStack {
            Text("Example App")
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        shouldNavigate = true
                    }
                }
                .navigationDestination(isPresented: $shouldNavigate) {
                    GithubSearchView()
                        .navigationBarBackButtonHidden(true)
                }
        }
        .modifier(FullFrameModifier())
        .background(Color("Background"))
    }
}

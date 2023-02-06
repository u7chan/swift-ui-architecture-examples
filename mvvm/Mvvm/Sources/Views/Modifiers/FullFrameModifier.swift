//
//  FullFrameModifier.swift
//  NoArchitecture
//
//  Created by unagami on 2023/02/05.
//

import SwiftUI

struct FullFrameModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(
                minWidth: 0,
                maxWidth: .infinity,
                minHeight: 0,
                maxHeight: .infinity,
                alignment: .center
            )
    }
}

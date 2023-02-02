//
//  ContentView.swift
//  TCA
//
//  Created by unagami on 2023/02/02.
//

import SwiftUI

struct ContentView: View {
    
    @State var text: String = ""

    var body: some View {
        VStack {
            Image("icon-github")
            VStack(alignment: .leading) {
                HStack {
                    Image(systemName: "magnifyingglass")
                    TextField("Search...", text: $text)
                        .onSubmit {
                            print("#Submit: \(text)")
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

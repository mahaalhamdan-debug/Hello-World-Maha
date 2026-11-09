//
//  ContentView.swift
//  Hello World, Maha
//
//  Created by Maha Alhamdan on 29/05/1448 AH.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
    }
}

#Preview {
    ContentView()
}

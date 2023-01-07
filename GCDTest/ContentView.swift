//
//  ContentView.swift
//  GCDTest
//
//  Created by Lee Yen Lin on 2023/1/7.
//

import SwiftUI

struct ContentView: View {
    let data = RunGcd()
    var body: some View {
        VStack {
            Button {
                data.gcdSync()
            } label: {
                Text("Sync")
            }
            .padding(16)

            Button {
                data.gcdAsync()
            } label: {
                Text("Async")
            }
            .padding(16)

            Button {
                data.gcdAsyncBlock()
            } label: {
                Text("Async Block")
            }
            .padding(16)

            Button {
                data.gcdAsyncConcurrent()
            } label: {
                Text("Async Concurrent")
            }
            .padding(16)
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

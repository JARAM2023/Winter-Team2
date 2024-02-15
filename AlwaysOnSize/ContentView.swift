//
//  ContentView.swift
//  AlwaysOnSize
//
//  Created by 최영우 on 2024. 2. 14..
//

import SwiftUI

struct ContentView: View {
    @State var name : String  = ""
    var storage : String = getFreeSizeAsString()
    var size : String = findFileSize()
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text(storage)
            Text(size)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}



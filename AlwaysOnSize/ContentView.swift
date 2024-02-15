//
//  ContentView.swift
//  AlwaysOnSize
//
//  Created by 최영우 on 2024. 2. 14..
//

import SwiftUI

struct ContentView: View {
    @State var name : String  = ""
    @State var storage : String = getFreeSizeAsString()
    var size : [String] = findFileSize()
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text(storage)
            Text(size[0])
        }
        .task {
            let timer = Timer.scheduledTimer(withTimeInterval: 3, repeats: true) { (_) in
                Text(storage)
            }
            
            timer.fire()
        }
        .padding()
    }
}

#Preview {
    ContentView()
}



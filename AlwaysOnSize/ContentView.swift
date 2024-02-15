//
//  ContentView.swift
//  AlwaysOnSize
//
//  Created by 최영우 on 2024. 2. 14..
//

import SwiftUI

struct ContentView: View {
    @State private var fileInformations: [FileInformation] = []
    @State private var storage: String = ""
    @State private var size: [String] = []
    
    private let timer = Timer.publish(every: 3, on: .main, in: .common).autoconnect()
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text(storage)
            Text(size.first ?? "")
            List(fileInformations.indices, id: \.self) { index in
                Toggle(isOn: $fileInformations[index].isChecked) {
                    VStack(alignment: .leading) {
                        Text("Filename: \(fileInformations[index].fileName)")
                        Text("Filesize: \(getFormatedNumberString(size: fileInformations[index].fileSize))")
                        Text("Path: \(fileInformations[index].path)")
                    }
                }
            }
            Text("Total Checked File Size:\n \(totalCheckedFileSize(fileInformations: fileInformations)) bytes")
            Button(action: {
                deleteFiles(fileInformations: fileInformations)
                fileInformations = findFileInformations()
                storage = getFreeSizeAsString()
                size = findFileSize()
            }, label: {
                Text("Delete")
            })
            .padding()
        }
        // 초기 화면값
        .onAppear {
            fileInformations = findFileInformations()
            storage = getFreeSizeAsString()
            size = findFileSize()
        }
        // 3초마다 storage변화 확인
        .onReceive(timer) { _ in
            fileInformations = findFileInformations()
            storage = getFreeSizeAsString()
            size = findFileSize()
        }
        .padding()
    }
}

//struct ContentView: View {
//    @State var name : String  = ""
//    var storage : String = getFreeSizeAsString()
//    var size : String = findFileSize()
//    var body: some View {
//        VStack {
//            Image(systemName: "globe")
//                .imageScale(.large)
//                .foregroundStyle(.tint)
//            Text(storage)
//            Text(size)
//        }
//        .padding()
//    }
//}


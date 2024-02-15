//
//  ContentView.swift
//  AlwaysOnSize
//
//  Created by 최영우 on 2024. 2. 14..
//

import SwiftUI

struct ContentView: View {
    @State private var fileInformations: [FileInformation] = []
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
    @State var size : String = findFileSize()
    
    func updateFileInformations() {
        fileInformations = findFileInformations()
    }
    
    var body: some View {
        List(fileInformations.indices, id: \.self) { index in
                    // 각 파일 정보에 대한 Checkbox를 생성합니다.
                    Toggle(isOn: $fileInformations[index].isChecked) {
                        VStack(alignment: .leading) {
                            Text("Filename: \(fileInformations[index].fileName)")
                            Text("Filesize: \(getFormatedNumberString(size: fileInformations[index].fileSize))")
                            Text("Path: \(fileInformations[index].path)")
                        }
                    }
                }
        .onAppear {
            self.fileInformations = findFileInformations()
        }
        .padding()
        HStack(){
            VStack(alignment: .leading) {
                Image(systemName: "globe")
                    .imageScale(.large)
                    .foregroundStyle(.tint)
                Text(storage)
                Text(size)
            }
            Text("Total Checked File Size:\n \(totalCheckedFileSize(fileInformations: fileInformations)) bytes")
            Button(action: {
                deleteFiles(fileInformations: fileInformations)
                updateFileInformations()
                storage = getFreeSizeAsString()
                size = findFileSize()
            }, label: {
                Text("Delete")
            })
            .padding()
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

#Preview {
    ContentView()
}



//
//  AlwaysOnSizeApp.swift
//  AlwaysOnSize
//
//  Created by 최영우 on 2024. 2. 14..
//

import SwiftUI
import CoreServices

@main
struct AlwaysOnSizeApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

func getFormatedNumberString(size: Double) -> String {

    var varsize : Double = size
    if (varsize) / 1024 < 1 {
        return String(format: "%.1fByte", varsize)
    }
    varsize /= 1024
    if varsize / 1024 < 1 {
        return String(format: "%.1fKB", varsize)
    }
    varsize /= 1024
    if varsize / 1024 < 1 {
        return String(format: "%.1fMB", varsize)
    }
    varsize /= 1024
    
  
    return String(format: "%.1fGB", varsize)
}


func getFreeSizeAsString() -> String {
    
    let documentDirectoryPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
    var freeSize: Double? // Byte단위
    do {
        let attributes = try FileManager.default.attributesOfFileSystem(forPath: documentDirectoryPath.last! as String)
        freeSize = attributes[FileAttributeKey.systemFreeSize] as? Double
    } catch {
        print(error)
    }

    var freeSizeAsDouble: Double = freeSize as? Double ?? 0
    return getFormatedNumberString(size: freeSize!)
}


func findFileSize() -> String {
    let filePath = try? FileManager.default.contentsOfDirectory(at: .downloadsDirectory, includingPropertiesForKeys: [.fileSizeKey])

    var fileSize : Double = 0

    do {
        //return [FileAttributeKey : Any]
        for file in filePath! {
            print(file)

            let attr = try FileManager.default.attributesOfItem(atPath: file.path)
            fileSize = attr[FileAttributeKey.size] as! Double
            
            //if you convert to NSDictionary, you can get file size old way as well.
            let dict = attr as NSDictionary
            fileSize = Double(dict.fileSize())
            print(getFormatedNumberString(size: fileSize))
        }
    } catch {
        print("Error: \(error)")
    }
    return getFormatedNumberString(size: fileSize)
}

struct FileInformation {
    var fileName: String
    var fileSize: Double
    var path: String
    var isChecked: Bool = false // Checkbox의 상태를 나타내는 속성
}

func findFileInformations() -> [FileInformation] {
    var fileInformations: [FileInformation] = []

    if let filePaths = try? FileManager.default.contentsOfDirectory(at: .downloadsDirectory, includingPropertiesForKeys: [.fileSizeKey]) {
        for filePath in filePaths {
            do {
                let attr = try FileManager.default.attributesOfItem(atPath: filePath.path)
                let fileSize = attr[FileAttributeKey.size] as? Double ?? 0
                let fileName = filePath.lastPathComponent // 옵셔널 체이닝을 사용하여 안전하게 파일 이름을 가져옵니다.
                let path = filePath.path
                
                fileInformations.append(FileInformation(fileName: fileName, fileSize: fileSize, path: path))
            } catch {
                print("Error: \(error)")
            }
        }
    } else {
        print("Failed to get contents of directory.")
    }

    return fileInformations
}

func totalCheckedFileSize(fileInformations: [FileInformation]) -> Double {
    var totalSize: Double = 0
    for fileInfo in fileInformations {
        if fileInfo.isChecked {
            totalSize += fileInfo.fileSize
        }
    }
    return totalSize
}

func deleteFile(atPath path: String, filename: String) -> Bool {
    let fileManager = FileManager.default
    let filePath = path

    do {
        // 파일이 존재하는지 확인합니다.
        if fileManager.fileExists(atPath: filePath) {
            // 파일을 삭제합니다.
            try fileManager.removeItem(atPath: filePath)
            print("File deleted successfully at path: \(filePath)")
            return true
        } else {
            print("File does not exist at path: \(filePath)")
            return false
        }
    } catch {
        print("Error deleting file: \(error)")
        return false
    }
}

func deleteFiles(fileInformations: [FileInformation]) {
    for fileInfo in fileInformations {
        if fileInfo.isChecked {
            _ = deleteFile(atPath: fileInfo.path, filename: fileInfo.fileName)
        }
    }
}



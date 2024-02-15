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


func findFileSize() -> [String] {
    let filePath = try? FileManager.default.contentsOfDirectory(at: .downloadsDirectory, includingPropertiesForKeys: [.fileSizeKey])

    var fileSize : Double = 0
    var dic : [String:Double] = [:]
    var dicarr : [String] = []
    do {
        //return [FileAttributeKey : Any]
        for file in filePath! {

            let attr = try FileManager.default.attributesOfItem(atPath: file.path)
            fileSize = attr[FileAttributeKey.size] as! Double
            
            //if you convert to NSDictionary, you can get file size old way as well.
            let dict = attr as NSDictionary
            fileSize = Double(dict.fileSize())
            dic.updateValue(fileSize, forKey: file.path)
        }
    } catch {
        print("Error: \(error)")
    }
    var sortdic = dic.sorted { (first, second) in
        return first.value > second.value
        
    }
    for i in sortdic {
        dicarr.append(String(i.value))
        print(i.value)
    }
    return dicarr
}



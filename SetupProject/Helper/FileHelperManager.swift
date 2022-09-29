//
//  FileHelperManager.swift
//  PhotoVaultKiInternal
//
//  Created by Sunil Zalavadiya on 25/05/21.
//  Copyright © 2021 Kartum Infotech. All rights reserved.
//

import Foundation

class FileHelperManager {
    static func urlInDocumentsDirectory(forPath path: String) -> URL {
        return documentDirectoryPath().appendingPathComponent(path)
    }
    
    static func cacheDirectoryPath() -> URL {
        let cacheDirectory = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask)[0]
        _ = createDirectoryIfNotExists(directoryUrl: cacheDirectory)
        return cacheDirectory
    }
    
    static func documentDirectoryPath() -> URL {
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        _ = createDirectoryIfNotExists(directoryUrl: documentsDirectory)
        return documentsDirectory
    }
    
    static func temporaryDirectoryPath() -> URL {
        let temporaryDirectory = FileManager.default.temporaryDirectory
        _ = createDirectoryIfNotExists(directoryUrl: temporaryDirectory)
        return temporaryDirectory
    }
    
    static func applicationSupportDirectoryPath() -> URL {
        let directory = FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask)[0]
        _ = createDirectoryIfNotExists(directoryUrl: directory)
        return directory
    }
    
    static func isFileExistsAtPath(fileURL: URL) -> Bool {
        if FileManager.default.fileExists(atPath: fileURL.path) {
            return true
        }
        return false
    }
    
    static func createDirectoryIfNotExists(withName name:String) -> (Bool, Error?)  {
        let directoryUrl = self.documentDirectoryPath().appendingPathComponent(name)
        if FileManager.default.fileExists(atPath: directoryUrl.path) {
            return (true, nil)
        }
        do {
            try FileManager.default.createDirectory(at: directoryUrl, withIntermediateDirectories: true, attributes: nil)
            return (true, nil)
        } catch  {
            return (false, error)
        }
    }
    
    static func createDirectoryIfNotExists(directoryUrl: URL) -> (Bool, Error?)  {
        if FileManager.default.fileExists(atPath: directoryUrl.path) {
            return (true, nil)
        }
        do {
            try FileManager.default.createDirectory(at: directoryUrl, withIntermediateDirectories: true, attributes: nil)
            return (true, nil)
        } catch  {
            return (false, error)
        }
    }
    
    static func deleteFileAtPath(fileURL: URL) -> Bool {
        do {
            if isFileExistsAtPath(fileURL: fileURL) && !fileURL.absoluteString.fileExtension().isEmpty {
                
                print("file exist")
                /// try to delete the old generated video
                try FileManager.default.removeItem(at: fileURL)
                
                return true
            } else {
                return true
            }
        } catch {
            print("error = ", error)
            return false
        }
    }
    
    static func deleteFileAtPaths(fileURLs: [URL]) {
        for fileUrl in fileURLs
        {
            _ = deleteFileAtPath(fileURL: fileUrl)
        }
    }
    
    static func fetchAllFilesFrom(directoryURL: URL) -> [URL] {
        do {
            var arrFiles = try FileManager.default.contentsOfDirectory(atPath: directoryURL.path)
            arrFiles.sort(by: <)
            return arrFiles.map { URL(fileURLWithPath: directoryURL.appendingPathComponent($0).path) }
        } catch {
            print("fetchAllFilesFrom error = ", error)
        }
        return []
    }
    
    static func getAllFilesFromDirectory(direcotryURL: URL) -> [URL] {
        do {
            let arrURLs = try FileManager.default.contentsOfDirectory(at: direcotryURL, includingPropertiesForKeys: nil, options: [.skipsHiddenFiles, .skipsSubdirectoryDescendants, .skipsSubdirectoryDescendants])
            return arrURLs
        } catch let error {
            print(error.localizedDescription)
        }
        
        return []
    }
    
    static func getFileModificationDate(url: URL) -> Date? {
        do {
            let attr = try FileManager.default.attributesOfItem(atPath: url.path)
            return attr[FileAttributeKey.modificationDate] as? Date
        } catch {
            return nil
        }
    }
    
    static func getFileCreationDate(url: URL) -> Date? {
        do {
            let attr = try FileManager.default.attributesOfItem(atPath: url.path)
            return attr[FileAttributeKey.creationDate] as? Date
        } catch {
            return nil
        }
    }
    
}

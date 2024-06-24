//
//  FileManager+Ext.swift
//  Sample
//
//  Created by Arvind on 24/06/24.
//

import UIKit
import UniformTypeIdentifiers

extension FileManager {
    
    // MARK: - Create Folder
    static func createFolder(folder: SDCFolderName...) -> URL? {
        let fileManager = FileManager.default
        if var documentDirectoryUrl = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first {
            
            folder.forEach { folder in
                documentDirectoryUrl = documentDirectoryUrl.appendingPathComponent(folder.name)
            }
            
            if !fileManager.fileExists(atPath: documentDirectoryUrl.path) {
                do {
                    try fileManager.createDirectory(atPath: documentDirectoryUrl.path, withIntermediateDirectories: true, attributes: nil)
                    
                    return documentDirectoryUrl
                } catch let folderError {
                    print("Error Creating Folder: \(folderError.localizedDescription)")
                    
                }
            } else {
                return documentDirectoryUrl
                
            }
        }
        return nil
    }
    
    // MARK: - Exists Folder
    static func existFolder(folder: SDCFolderName...) -> URL? {
        let fileManager = FileManager.default
        if var documentDirectoryUrl = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first {
            
            folder.forEach { folder in
                documentDirectoryUrl = documentDirectoryUrl.appendingPathComponent(folder.name)
            }
            
            return fileManager.fileExists(atPath: documentDirectoryUrl.path) ? documentDirectoryUrl : nil
        }
        
        return nil
    }
    
    // MARK: - Exists File
    static func existFile(folder: SDCFolderName..., fileName: String) -> URL? {
        let fileManager = FileManager.default
        if var documentDirectoryUrl = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first {
            
            folder.forEach { folder in
                documentDirectoryUrl = documentDirectoryUrl.appendingPathComponent(folder.name)
            }
            
            documentDirectoryUrl = documentDirectoryUrl.appendingPathComponent(fileName)
            return fileManager.fileExists(atPath: documentDirectoryUrl.path) ? documentDirectoryUrl : nil
        }
        
        return nil
    }
    
    @discardableResult
    static func saveFileToFolder(folder: SDCFolderName, file: Any?, fileName: String) -> URL? {
        if let createFolderUrl = createFolder(folder: folder) {
            do {
                var rawData: Data?
                if let image = file as? UIImage, let imageData = image.jpegData(compressionQuality: 1.0) {
                    rawData = imageData
                }
                
                if let url = file as? URL {
                    rawData = try Data(contentsOf: url)
                }
                
                if let data = file as? Data {
                    rawData = data
                }
                
                if let data = file as? String {
                    rawData = data.data(using: .utf8)
                }
                
                guard let rawData = rawData else { return nil }
                let fileUrl = createFolderUrl.appendingPathComponent(fileName)
                try rawData.write(to: fileUrl, options: .atomicWrite)
                DLog("File Stored: \(fileUrl)")
                
                return fileUrl
            } catch let saveError {
                DLog("File Save Error: \(saveError)")
                
                return nil
            }
        }
        
        return nil
    }
    
    static func folderSize(folderPath: URL) -> String? {
        do {
            let contents = try FileManager.default.contentsOfDirectory(at: folderPath,
                                                                       includingPropertiesForKeys: nil,
                                                                       options: .skipsHiddenFiles).sorted { $0.path < $1.path }
            
            var folderSize: Int64 = 0
            for content in contents {
                do {
                    let fileAttributes = try FileManager.default.attributesOfItem(atPath: content.path(percentEncoded: false))
                    folderSize += fileAttributes[FileAttributeKey.size] as? Int64 ?? 0
                    
                } catch _ {
                    continue
                    
                }
            }
            
            print("Folder Size: ", folderSize)
            
            return folderSize.converByteToSize
        } catch let error {
            DLog(error.localizedDescription)
            return nil
        }
    }
    
    @discardableResult
    static func deleteFolder(folderUrl: URL) -> Bool {
        let fileManager = FileManager.default
        
        if fileManager.fileExists(atPath: folderUrl.path) {
            do {
                DLog("Deleting: \(folderUrl)")
                try FileManager.default.removeItem(at: folderUrl)
                
                return true
            } catch {
                DLog("Could not delete file: \(error)")
                return false
            }
        }
        
        return false
    }
}

// MARK: - MimeType || File Size
extension URL {
    var urlMimeType: String {
        if let mimeType = UTType(filenameExtension: self.pathExtension)?.preferredMIMEType {
            
            return mimeType
        } else {
            
            return "application/octet-stream"
        }
    }
    
    var fileSize: Int64 {
        do {
            let fileManager = FileManager.default
            let fileAttributes = try fileManager.attributesOfItem(atPath: self.path)

            return fileAttributes[FileAttributeKey.size] as? Int64 ?? 0
            
        } catch _ {
            return 0
        }
    }
    
    var attributes: [FileAttributeKey : Any]? {
        do {
            return try FileManager.default.attributesOfItem(atPath: path(percentEncoded: false))
            
        } catch {
            print("FileAttribute error: \(error)")
        }
        
        return nil
    }
}

// MARK: - Convert filesize to MB
extension Int64 {
    var converByteToSize: String {
        let formatter: ByteCountFormatter = ByteCountFormatter()
        formatter.allowedUnits = .useAll
        formatter.countStyle = .file
        formatter.includesUnit = true
        formatter.isAdaptive = true

        return formatter.string(fromByteCount: self)
    }
}

enum SDCFolderName {
    case upload
    case pdf
    case user
    
    var name: String {
        switch self {
        case .upload: return "Upload"
        case .pdf: return "Pdf"
        case .user: return "User"
        }
    }
}

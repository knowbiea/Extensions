# Extensions

Swift Extensions are a powerful tool that lets you add new functionality to existing building blocks of your code, like classes, structures, enumerations, and even protocols.

## FileManager Extension Features

- Create Folder
- Folder Exist
- Save File to Folder
- File Exist
- Folder Size
- Delete Folder
- Mime Type
- File Size
- File Attributes
- Convert Byte To Size

## Usage

- Create Folder
    ```swift
    if let createFolderUrl = FileManager.createFolder(folder: .user) { print("Create Folder Url: ", createFolderUrl) }
    ```

- Folder Exist
    ```swift
    if let existFolderUrl = FileManager.existFolder(folder: .user) { print("Exist Folder Url: ", existFolderUrl) }
    ```

- Save File to Folder
    ```swift
    let sampleCSV = "name,age,city\nAlice,30,New York\nBob,25,Los Angeles\nCharlie,40,Chicago"
    if let savedFile = FileManager.saveFileToFolder(folder: .user, file:sampleCSV, fileName: "sample.csv") {
        print("Saved File to Folder: ", savedFile)
    }
    ```

- File Exist
    ```swift
    if let existFile = FileManager.existFile(folder: .user, fileName: "sample.csv") {
        print("Exist File: ", existFile)
    }
    ```
    
- Folder Size
    ```swift
    if let createFolderUrl = FileManager.createFolder(folder: .user), let folderSize = FileManager.folderSize(folderPath: createFolderUrl) {
        print("Exist Folder Url: ", folderSize)
    }
    ```
    
- Delete Folder
    ```swift
    if let folderUrl = FileManager.createFolder(folder: .user) {
        FileManager.deleteFolder(folderUrl: folderUrl)
    }
    ```
    
- Mime Type
    ```swift
    if let existFile = FileManager.existFile(folder: .user, fileName: "sample.csv") {
        print("Mime Type: ", existFile.urlMimeType)
    }
    ```
    
- File Size
    ```swift
    if let existFile = FileManager.existFile(folder: .user, fileName: "sample.csv") {
        print("File Size in Bytes: ", existFile.fileSize)
    }
    ```
    
- File Attributes
    ```swift
    if let existFile = FileManager.existFile(folder: .user, fileName: "sample.csv") {
        print("File Attributes: ", existFile.attributes)
    }
    ```
    
- Convert Byte To Size
    ```swift
    if let existFile = FileManager.existFile(folder: .user, fileName: "sample.csv") {
        print("Convert Bytes to Size: ", existFile.fileSize.converByteToSize)
    }
    ```

## Maintainer ✨

**Extensions** is built with 🧡 by [Arvind Yadav](https://github.com/knowbiea).

Your support and feedback are valuable for maintaining and improving the extension.

<a href="https://buymeacoffee.com/knowbiea" target="_blank"><img src="assets/bmc.png" alt="logo" width="150"></a>

<a href="https://buymeacoffee.com/knowbiea" target="_blank"><img src="assets/bmcButton.png" alt="Buy Me A Coffee" style="height: 60px !important;width: 217px !important;" ></a>

---

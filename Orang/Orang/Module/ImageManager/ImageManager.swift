//
//  ImageManager.swift
//  Orang
//
//  Created by yeoni on 2023/10/02.
//

import UIKit

class ImageManager {
    
    static let shared = ImageManager()
    
    private init() { }
    
    enum DirectoryName: String {
        case profile
    }
    
    let fileManager = FileManager.default
    
    
    enum FileURLCase {
        case directory, fileURL
    }
    
    func createURL(URLCase: FileURLCase, directoryName: DirectoryName, identifier: String) -> (URL, String) {
        let documentURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
        let directoryURL = documentURL.appendingPathComponent(directoryName.rawValue)
        var imageName = "\(directoryName.rawValue)_\(identifier).jpg"
        let fileURL = directoryURL.appendingPathComponent(imageName)
        switch URLCase {
        case .directory:
            return (directoryURL, imageName)
        case .fileURL:
            return (fileURL, imageName)
        }
    }
    
    
    func makeDirectory(directoryName: DirectoryName) {
        
        let (directoryURL, _) = createURL(URLCase: .directory, directoryName: directoryName, identifier: "")
        
        if fileManager.fileExists(atPath: directoryURL.path) { return }
        
        do {
            try fileManager.createDirectory(at: directoryURL, withIntermediateDirectories: false, attributes: nil)
        } catch let error {
            print("directory Error: \(error.localizedDescription)")
        }
    }
    
    func saveImageToDirectory(directoryName: DirectoryName, identifier: String, image: UIImage?) -> Bool {
        let (fileURL, imageName) = createURL(URLCase: .fileURL, directoryName: directoryName, identifier: identifier)
        guard let image else { return false }
        
        do {
            if let imageData = image.jpegData(compressionQuality: 0.3) {
                try imageData.write(to: fileURL)
            }
            return true
        } catch {
            print(error.localizedDescription)
            return false
        }
    }
    
    func editImageToDirectory(directoryName: DirectoryName, identifier: String, image: UIImage?) -> Bool {
        
        let (fileURL, imageName) = createURL(URLCase: .fileURL, directoryName: directoryName, identifier: identifier)
        
        do {
            if let imageData = image?.jpegData(compressionQuality: 0.3) {
                try imageData.write(to: fileURL)
                print("Image edited at: \(fileURL)")
            }
            return true
        } catch let error {
            print("Failed to save image: \(error.localizedDescription)")
            return false
        }
    }
    
    func loadImageFromDirectory(directoryName: DirectoryName, with identifier: String) -> UIImage? {
        let (fileURL, _) = createURL(URLCase: .directory, directoryName: directoryName, identifier: identifier)
        
        guard fileManager.fileExists(atPath: fileURL.path) else { return nil }
        
        return UIImage(contentsOfFile: fileURL.path)
    }
    
    func removeImageFromDirectory(directoryName: DirectoryName, identifier: String) -> Bool {
        let (fileURL, _) = createURL(URLCase: .fileURL, directoryName: directoryName, identifier: identifier)
        
        do {
            if fileManager.fileExists(atPath: fileURL.path) {
                try fileManager.removeItem(at: fileURL)
            }
            return true
        } catch let error {
            print("Failed to delete file: \(error.localizedDescription)")
            return false
        }
    }
}

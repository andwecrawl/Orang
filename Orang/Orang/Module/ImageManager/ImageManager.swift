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
    
    func makeDirectory(directoryName: DirectoryName) {
        
        let documentURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
        let directoryURL = documentURL.appendingPathComponent(directoryName.rawValue)
        
        do {
            try fileManager.createDirectory(at: directoryURL, withIntermediateDirectories: false, attributes: nil)
        } catch let error {
            print("directory Error: \(error.localizedDescription)")
        }
    }
    
    func createFileURL(directoryName: DirectoryName, identifier: String) -> URL {
        let documentURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
        let directoryURL = documentURL.appendingPathComponent(directoryName.rawValue)
        var imageName = "\(directoryName.rawValue)_\(identifier)"
        let fileURL = directoryURL.appendingPathComponent(identifier, conformingTo: .jpeg)
        return fileURL
    }
    
    func saveImageToDirectory(directoryName: DirectoryName, identifier: String, image: UIImage?) {
        
        let fileURL = createFileURL(directoryName: directoryName, identifier: identifier)
        
        do {
            if let imageData = image?.jpegData(compressionQuality: 0.3) {
                try imageData.write(to: fileURL)
                print("Image saved at: \(fileURL)")
            }
        } catch let error {
            print("Failed to save image: \(error.localizedDescription)")
        }
    }
    
    func loadImageFromDirectory(directoryName: DirectoryName, with identifier: String) -> UIImage? {
        let fileURL = createFileURL(directoryName: directoryName, identifier: identifier)
        
        guard fileManager.fileExists(atPath: fileURL.path) else { return nil }
        
        return UIImage(contentsOfFile: fileURL.path)
    }
    
    func removeImageFromDirectory(directoryName: DirectoryName, identifier: String) {
        let fileURL = createFileURL(directoryName: directoryName, identifier: identifier)
        
        do {
            if fileManager.fileExists(atPath: fileURL.path) {
                try fileManager.removeItem(at: fileURL)
            }
        } catch let error {
            print("Failed to delete file: \(error.localizedDescription)")
        }
    }
}

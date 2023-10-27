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
        case diaries
        case dailyRecords
        case medicalRecords
    }
    
    let fileManager = FileManager.default
    
    
    enum FileURLCase {
        case directory, fileURL
    }
    
    func createURL(URLCase: FileURLCase, directoryName: DirectoryName, identifier: String) -> (URL, String) {
        let documentURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
        let directoryURL = documentURL.appendingPathComponent(directoryName.rawValue)
        let imageName = "\(identifier).jpeg"
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
        makeDirectory(directoryName: directoryName)
        
        let (fileURL, _) = createURL(URLCase: .fileURL, directoryName: directoryName, identifier: identifier)
        
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
        let (fileURL, _) = createURL(URLCase: .fileURL, directoryName: directoryName, identifier: identifier)
        
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
        let (fileURL, _) = createURL(URLCase: .fileURL, directoryName: directoryName, identifier: identifier)
        
        if fileManager.fileExists(atPath: fileURL.path) {
            return UIImage(contentsOfFile: fileURL.path)
        } else {
            print("못찾겟다")
            return nil
        }
    }
    
    func removeImageFromDirectory(directoryName: DirectoryName, identifier: String) {
        let (fileURL, _) = createURL(URLCase: .fileURL, directoryName: directoryName, identifier: identifier)
        
        do {
            if fileManager.fileExists(atPath: fileURL.path) {
                try fileManager.removeItem(at: fileURL)
            }
        } catch let error {
            print("Failed to delete file: \(error.localizedDescription)")
        }
    }
    
    func makeImageString(directoryName: DirectoryName, createDate: Date, images: [UIImage], completionHandler: @escaping (([String]) -> ()), errorHandler: @escaping () -> ()) {
        
        var imageIdentifiers: [String] = []
        // photo 추가
        for index in images.indices {
            let identifier = "\(createDate)\(index)"
            imageIdentifiers.append(identifier)
            if !ImageManager.shared.saveImageToDirectory(directoryName: directoryName, identifier: identifier, image: images[index]) {
                errorHandler()
                return
            }
        }
        completionHandler(imageIdentifiers)
    }
    
}

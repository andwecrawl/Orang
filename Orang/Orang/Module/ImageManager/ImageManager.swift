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
        
        // 실제 파일 이름
        let directoryURL = documentURL.appendingPathComponent(directoryName.rawValue)
        
        do {
            try fileManager.createDirectory(at: directoryURL, withIntermediateDirectories: false, attributes: nil)
        } catch let error {
            print("directory Error: \(error.localizedDescription)")
        }
    }
    
    func saveImageToDirectory(directoryName: DirectoryName, identifier: String, image: UIImage?) {
        
        let documentURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
        
        // 저장할 directoryURL 설정
        let directoryURL = documentURL.appendingPathComponent(directoryName.rawValue)
        
        var imageName = "\(directoryName.rawValue)_\(identifier)"
        
        // 이미지 이름 & 최종 경로 설정
        let fileURL = directoryURL.appendingPathComponent(imageName, conformingTo: .jpeg)
        
        print(fileURL)
        
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
        let documentURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
        let directoryURL = documentURL.appendingPathComponent(directoryName.rawValue)
        let fileURL = directoryURL.appendingPathComponent(identifier, conformingTo: .jpeg)
        
        guard fileManager.fileExists(atPath: fileURL.path) else { return nil }
        
        return UIImage(contentsOfFile: fileURL.path)
    }
    
    func removeImageFromDirectory(directoryName: DirectoryName, identifier: String) {
        let documentURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
        let directoryURL = documentURL.appendingPathComponent(directoryName.rawValue)
        let imageName = "\(directoryName.rawValue)_\(identifier)"
        let fileURL = directoryURL.appendingPathComponent(imageName, conformingTo: .jpeg)
        
        do {
            if fileManager.fileExists(atPath: fileURL.path) {
                try fileManager.removeItem(at: fileURL)
            }
        } catch let error {
            print("Failed to delete file: \(error.localizedDescription)")
        }
    }
}

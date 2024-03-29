//
//  DiaryDelegateProtocol.swift
//  Orang
//
//  Created by yeoni on 2023/10/12.
//

import Foundation
import PhotosUI

protocol AddDelegate {
    func openPhotoAlbum()
    func takePhoto()
    func selectFile()
}

protocol DeleteDelegate {
    func deleteImages(image: UIImage)
}

//
//  UserData+.swift
//  Orang
//
//  Created by yeoni on 2/24/24.
//

import UIKit

func getDeviceOS() -> String {
    return UIDevice.current.systemVersion
}

// Device Identifier 찾기
func getDeviceIdentifier() -> String {
    var systemInfo = utsname()
    uname(&systemInfo)
    let machineMirror = Mirror(reflecting: systemInfo.machine)
    let identifier = machineMirror.children.reduce("") { identifier, element in
        guard let value = element.value as? Int8, value != 0 else { return identifier }
        return identifier + String(UnicodeScalar(UInt8(value)))
    }
    
    return identifier
}

// 현재 버전 가져오기
func getCurrentVersion() -> String {
    guard let dictionary = Bundle.main.infoDictionary,
          let version = dictionary["CFBundleShortVersionString"] as? String else { return "" }
    return version
}

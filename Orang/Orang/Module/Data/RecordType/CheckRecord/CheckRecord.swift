//
//  CheckRecord.swift
//  Orang
//
//  Created by yeoni on 2023/10/14.
//

import Foundation

struct CheckRecord<T: CheckProtocol> {
    var type: T
    var title: String
    var subtitle: String
    var ischecked: Bool
    
    init(type: T) {
        self.type = type
        self.title = type.title
        self.subtitle = type.subtitle
        self.ischecked = false
    }
}

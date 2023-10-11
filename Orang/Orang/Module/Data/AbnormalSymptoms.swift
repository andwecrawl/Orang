//
//  AbnormalSymptoms.swift
//  Orang
//
//  Created by yeoni on 2023/10/11.
//

import Foundation

struct AbnormalSymptoms {
    var type: AbnormalSymptomsType
    var title: String
    var subtitle: String
    var ischecked: Bool
    
    init(type: AbnormalSymptomsType) {
        self.type = type
        self.title = type.title
        self.subtitle = type.subtitle
        self.ischecked = false
    }
}

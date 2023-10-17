//
//  MedicalRecordType.swift
//  Orang
//
//  Created by yeoni on 2023/10/17.
//

import Foundation
import RealmSwift

enum MedicalRecordType: String, PersistableEnum {
    case treatmentRecord
    case vaccine
}

enum VaccineType: Int, PersistableEnum {
    case monthly
    case yearly
    case basicPreventive
    case custom
}

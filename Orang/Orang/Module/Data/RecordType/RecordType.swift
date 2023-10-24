//
//  Record.swift
//  Orang
//
//  Created by yeoni on 2023/10/10.
//

import UIKit
import RealmSwift

enum RecordType: Int, PersistableEnum {
    case diary
    case weight
    case snack
    case pooPee
    case abnormalSymptoms
    case vaccine
    case medicalHistory
    
    var recordDescriptions: String {
        switch self {
        case .diary:
            return "diaryRecordDescriptions".localized()
        case .weight:
            return "weightRecordDescriptions".localized()
        case .snack:
            return "snackRecordDescriptions".localized()
        case .pooPee:
            return "peepooRecordDescriptions".localized()
        case .abnormalSymptoms:
            return "symptomsRecordDescriptions".localized()
        case .vaccine:
            return "vaccineRecordDescriptions".localized()
        case .medicalHistory:
            return "medicalHistoryRecordDescriptions".localized()
        }
    }
    
    var image: UIImage? {
        switch self {
            
        case .diary:
            return UIImage(systemName: Design.image.diary)
        case .weight:
            return UIImage(systemName: Design.image.weight)
        case .snack:
            return UIImage(systemName: Design.image.snack)
        case .pooPee:
            return UIImage(systemName: Design.image.peePoo)
        case .abnormalSymptoms:
            return UIImage(systemName: Design.image.abnormalSymptoms)
        case .vaccine:
            return UIImage(systemName: Design.image.vaccine)
        case .medicalHistory:
            return UIImage(systemName: Design.image.medicalHistory)
        }
    }
}


enum pukeColor: String, PersistableEnum {
    case clear // 투명한 구토
    case withBubble // 흰색 거품이 섞인 구토
    case yellow // 노란색 구토
    case green // 공복 / 푸른 색
    case gray // 음식이 섞인 구토
    case black // 검정색 구토
    case pink // 분홍색 구토
    case red // 빨간 구토
    case etc
    
    var color: UIColor {
        switch self {
        case .clear:
            return .white
        case .withBubble:
            return .white
        case .yellow:
            return .systemYellow
        case .green:
            return .systemGreen
        case .gray:
            return .systemGray
        case .black:
            return .black
        case .pink:
            return .systemPink
        case .red:
            return .systemRed
        case .etc:
            return .white
        }
    }
}

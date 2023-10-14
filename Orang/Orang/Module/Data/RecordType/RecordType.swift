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

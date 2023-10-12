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

enum PooColor: String, PersistableEnum {
    case brown
    case black
    case red
    case orange
    case gray
    case yellow
    case green
    case dotted
    case none
    
    var color: UIColor {
        switch self {
        case .brown:
            return .systemBrown
        case .black:
            return .black
        case .red:
            return .systemRed
        case .orange:
            return .systemOrange
        case .gray:
            return .systemGray
        case .yellow:
            return .systemYellow
        case .green:
            return .systemGreen
        case .dotted:
            return .white
        case .none:
            return .white
        }
    }
}


enum PooForm: String, PersistableEnum {
    case normal, hard, mud, water, mucus // 점액
}

enum PeeColor: String, PersistableEnum {
    case yello, orange, yellow, brown, lightYellow
}

enum AbnormalSymptomsType: String, CaseIterable, PersistableEnum {
    case weiredSkin // 피부가 이상하다
    case weiredEyes // 눈이 이상하다
    case weiredNose // 코가 이상하다
    case weiredEear
    case hardToBreath // 호흡을 괴로워한다
    case puke // 구토
    case caught // 기침을 계속 한다
    case convulsion // 경련
    case walkingWeired // 걷는 모습이 이상하다
    case diarrhea // 설사
    case bloodyStool // 혈변
    case others
    
    var title: String {
        return "\(self.rawValue)Title".localized()
    }
    var subtitle: String {
        return self.rawValue.localized()
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

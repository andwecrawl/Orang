//
//  AbnormalSymptoms.swift
//  Orang
//
//  Created by yeoni on 2023/10/11.
//

import Foundation
import RealmSwift

enum AbnormalSymptomsType: String, CheckProtocol, CaseIterable, PersistableEnum {
    case weiredSkin // 피부가 이상하다
    case weiredEyes // 눈이 이상하다
    case weiredNose // 코가 이상하다
    case weiredEear
    case hardToBreath // 호흡을 괴로워한다
    case puke // 구토
    case caught // 기침을 계속 한다
    case convulsion // 경련
    case walkingWeired // 걷는 모습이 이상하다
    case decreaseInActivity // 활동량이 줄다
    case loseWeight // 체중이 줄다
    case haveAFever // 열이 있어요
    case abdominalDistention // 복부 팽만
    case lossHair // 탈모
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

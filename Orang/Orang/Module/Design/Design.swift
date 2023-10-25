//
//  ColorSet.swift
//  Orang
//
//  Created by yeoni on 2023/09/30.
//

import UIKit

class Design {
    enum image {
        // 자잘한 이미지들
        static let bg1 = "California"
        static let bg2 = "Ronchi"
        
        static let poo = "poo"
        
        static let diary = ""
        static let weight = UIImage(named: "weightB")!.withTintColor(Design.Color.tintColor, renderingMode: .alwaysTemplate).resized(to: CGSize(width: 40, height: 40))
        static let snack = UIImage(named: "snackB")!.withTintColor(Design.Color.tintColor, renderingMode: .alwaysTemplate).resized(to: CGSize(width: 40, height: 40))
        static let peePoo = UIImage(named: "padB")!.withTintColor(Design.Color.tintColor, renderingMode: .alwaysTemplate).resized(to: CGSize(width: 40, height: 40))
        static let abnormalSymptoms = UIImage(named: "warningB")!.withTintColor(Design.Color.tintColor, renderingMode: .alwaysTemplate).resized(to: CGSize(width: 40, height: 40))
        static let vaccine = UIImage(named: "vaccineB")!.withTintColor(Design.Color.tintColor, renderingMode: .alwaysTemplate).resized(to: CGSize(width: 40, height: 40))
        static let medicalHistory = UIImage(named: "medicalRecordB")!.withTintColor(Design.Color.tintColor, renderingMode: .alwaysTemplate).resized(to: CGSize(width: 30, height: 40))
        
        static let totalVC = UIImage(named: "total")!.withTintColor(Design.Color.tintColor, renderingMode: .alwaysTemplate).resized(to: CGSize(width: 30, height: 30))
        static let alertVC = UIImage(named: "alert")!.withTintColor(Design.Color.tintColor, renderingMode: .alwaysTemplate).resized(to: CGSize(width: 30, height: 30))
        static let recordVC = UIImage(named: "record")!.withTintColor(Design.Color.tintColor, renderingMode: .alwaysTemplate).resized(to: CGSize(width: 30, height: 30))
        static let profileVC =  UIImage(named: "setting")!.withTintColor(Design.Color.tintColor, renderingMode: .alwaysTemplate).resized(to: CGSize(width: 30, height: 30))
    }
    
    enum Color {
        static let background = UIColor(named: "background")!
        static let border = UIColor.systemGray
        static let halfGray = UIColor.systemGray4.withAlphaComponent(0.8)
        static let todaysColor = UIColor.systemGray.withAlphaComponent(0.4)
        static let content = UIColor(named: "contentColor")!
        static let tintColor = UIColor(named: "tintColor")!
        static let buttonBackground = UIColor(named: "buttonBackground")!
        
        static let diary = UIColor(named: "diary")!
        static let daily = UIColor(named: "daily")!
        static let medical = UIColor(named: "medical")!
        static let temp = UIColor(named: "temp")!
    }
    
    enum FontSize: CGFloat {
        case small = 12
        case medium = 14
        case large = 16
        case extraLarge = 18
    }
    
    enum Font: String {
        case scdreamLight = "S-CoreDream-3Light"
        case scdreamRegular = "S-CoreDream-4Regular"
        case scdreamMedium = "S-CoreDream-5Medium"
        case scdreamBold = "S-CoreDream-6Bold"
        case scdreamExBold = "S-CoreDream-7ExtraBold"
        case leeseoyun = "LeeSeoyun"
        case changwon = "ChangwonDangamAsac"
        
        /// 아이폰 작은 글씨(size: 12)
        var smallFont: UIFont {
            return UIFont(name: self.rawValue, size: FontSize.small.rawValue)!
        }
        
        var midFont: UIFont {
            return UIFont(name: self.rawValue, size: FontSize.medium.rawValue)!
        }
        
        var largeFont: UIFont {
            return UIFont(name: self.rawValue, size: FontSize.large.rawValue)!
        }
        
        var exlargeFont: UIFont {
            return UIFont(name: self.rawValue, size: FontSize.extraLarge.rawValue)!
        }
        
        func getFonts(size: CGFloat) -> UIFont {
            return UIFont(name: self.rawValue, size: size)!
        }
    }
    
    enum FontsWeight {
        case light, medium, bold
    }
}

//
//  moveToFirstScene.swift
//  Orang
//
//  Created by yeoni on 2023/10/17.
//

import UIKit
import Toast

protocol MoveToFirstScene {
    func moveToFirstScene()
}

extension MoveToFirstScene {
    func moveToFirstScene() {
        // 이전에 쌓였던 화면이 clear => 새로 진입
        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        let SceneDelegate = windowScene?.delegate as? SceneDelegate
        
        let tabBar = UITabBarController()
        
        let totalNav = UINavigationController(rootViewController: TotalViewController())
        totalNav.tabBarItem = UITabBarItem(title: "totalNavigationTitle".localized(), image: Design.image.totalVC, tag: 0)
        
//        let alertNav = UINavigationController(rootViewController: AlertViewController())
//        alertNav.tabBarItem = UITabBarItem(title: "AlertNavigationTitle".localized(), image: Design.image.alertVC, tag: 0)
        
        let recordNav = UINavigationController(rootViewController: RecordViewController())
        recordNav.tabBarItem = UITabBarItem(title: "recordNavigationTitle".localized(), image: Design.image.recordVC, tag: 1)
        
        let profileNav = UINavigationController(rootViewController: ProfileViewController())
        profileNav.tabBarItem = UITabBarItem(title: "ProfileNavigationTitle".localized(), image: Design.image.profileVC, tag: 2)
        
        tabBar.setViewControllers([totalNav, recordNav, profileNav], animated: true)
        
        UIView.transition(with: SceneDelegate?.window ?? UIWindow(), duration: 0.3, options: .transitionCrossDissolve, animations: {
            SceneDelegate?.window?.rootViewController = tabBar
        }) { (completed) in
            if completed {
                SceneDelegate?.window?.makeKeyAndVisible()
            }
        }
    }
}

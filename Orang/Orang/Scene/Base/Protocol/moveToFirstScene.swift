//
//  moveToFirstScene.swift
//  Orang
//
//  Created by yeoni on 2023/10/17.
//

import UIKit

protocol MoveToFirstScene {
    func moveToFirstScene()
}

extension MoveToFirstScene {
    func moveToFirstScene() {
        // 이전에 쌓였던 화면이 clear => 새로 진입
        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        let SceneDelegate = windowScene?.delegate as? SceneDelegate
        
        let tabBar = UITabBarController()
        
        let alertNav = UINavigationController(rootViewController: AlertViewController())
        alertNav.tabBarItem = UITabBarItem(title: "일정 관리", image: UIImage(systemName: "alarm"), tag: 0)
        
        let recordNav = UINavigationController(rootViewController: RecordViewController())
        recordNav.tabBarItem = UITabBarItem(title: "기록하기", image: UIImage(systemName: "pencil.and.outline"), tag: 0)
        
        let profileNav = UINavigationController(rootViewController: ProfileViewController())
        profileNav.tabBarItem = UITabBarItem(title: "아이 설정", image: UIImage(systemName: "pawprint.circle.fill"), tag: 0)
        
        tabBar.setViewControllers([alertNav, recordNav, profileNav], animated: true)
        
        SceneDelegate?.window?.rootViewController = tabBar
        SceneDelegate?.window?.makeKeyAndVisible()
    }
}
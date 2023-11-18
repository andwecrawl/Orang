# Orang
![image](https://github.com/andwecrawl/Orang/assets/120160532/11f884a9-c978-4a0b-85e6-34c3596f689a)
<br>
<br><br>
## 한 줄 소개
반려동물의 생활을 기록할 수 있는 서비스 
<br>
<br>
<br>
## 서비스 특징
- 다양한 종류의 동물의 프로필을 저장할 수 있다.
- 반려동물과의 추억과 아이의 다양한 기록을 저장할 수 있다.
	- 일상 기록: 일기처럼 제목, 내용, 사진으로 기록 가능
	- 생활 기록: 몸무게, 간식, 대소변, 이상 증상 기록 가능
	- 진료 기록: 동물별 예방 접종 기록, 진료 내역 기록 가능
- 작성했던 기록을 한 번에 모아보고, 차트를 통하여 변화를 관찰할 수 있다.
<br><br><br>
## 링크
[🔗 앱 스토어 바로 가기](https://apps.apple.com/kr/app/%EC%98%A4%EB%9E%91-%EC%98%A4%EB%8A%98%EB%8F%84-%EC%82%AC%EB%9E%91%ED%95%B4/id6470393264﻿)
<br>
[🔗 소개 노션 링크 바로 가기](https://www.notion.so/andwecrawl/Orang-c700c6ff259d4ebc943ed534ea6e143d?pvs=4)
<br>
<br><br><br>
## 개발 환경
<ul>
  <li>참여 인원: 개인</li>
  <li>개발 환경: Xcode 15 / iOS 15 이상 / swift 5.8.1</li>
  <li>개발 기간: 2023년 9월 25일~10월 27일</li>
<details>
<summary>진행 내역 상세 보기</summary>
<div markdown="1">
  <br>
  <table style="width:100%">
    <tr><th>진행 사항</th><th>진행 기간</th><th>세부 내역</th></tr>
    <tr><td>기획 및 디자인, 프로젝트 초기 세팅</td><td>23.09.25~23.10.01</td><td>이터레이션 내부 계획 수립, 기존 앱 분석, 프로젝트 내 데이터 구조화, 기초 UI 구성</td></tr>
    <tr><td>프로필 탭 구현, Realm 도입</td><td>23.10.02~23.10.08</td><td>프로필 화면 UI 및 기능 구성, Realm 도입 및 데이터 스키마 구상</td></tr>
    <tr><td>기록탭 구현 및 세부적인 기능 구현</td><td>23.10.09~23.10.15</td><td>DB 테이블 정규화, 기록 탭 뷰 구현</td></tr>
    <tr><td>모아보기 탭 구현, launchScreen Animation 구현, 버그 수정</td><td>23.10.16~23.10.22</td><td>FSCalendar 구현, 타이머를 이용한 animation 구현, 자잘한 버그 수정</td></tr>
    <tr><td>앱 출시 준비, 심사</td><td>23.10.22~23.10.24</td><td>목업 이미지 준비, 앱 설명 작성, 개인정보 처리방침 준비</td></tr>
    <tr><td>Reject 처리</td><td>23.10.25~23.10.27</td><td>설명 Notion 작성 및 버그 수정</td></tr></table></li></ul>
    
</div>
</details>
</ul>
<br><br>

## 사용한 기술
<ul><li><code>UIKit</code>, <code>SnapKit</code>, <code>Realm</code>, <code>Toast</code>, <code>FSCalendar</code>, <code>PhotosUI</code></li>
	<li><code>PropertyWrapper, UserDefaults</code></li>
    <li><code>Firebase</code></li>
  <ul>
    <li><code>Push Notification</code></li>
    <li><code>Crashlytics</code></li>
  </ul><li><code>MVC</code>, <code>MVVM</code>, <code>Singleton</code>, <code>Repository</code>, <code>Observable</code></li></ul></ul>
    <br><br>

## 주요 기능
- **Localization**을 사용하여 다국어를 지원합니다. (영어, 한국어)
- **Repository Pattern을 사용**하여 Realm 저장 시 **데이터를 추상화하여 일관된 인터페이스로 데이터를 요청**합니다.
- firebase의 Analytics, Crashlytics를 활용해 사용자의 정보를 받아 앱 기능을 개선해나가고 있습니다.
- **접근제어자와 `final` Keyword**를 적극적으로 사용하여 **성능 최적화**를 달성했습니다.
- `protocol`과 `extension` 활용하여 **코드의 재사용성과 활용성**을 높였습니다.
- 대부분의 String 값을 **열거형 타입으로 미리 정의**하여 **humanError를 최소화**하고, **컴파일 최적화**를 위해 노력했습니다.
- 기존의 `MVC` 패턴에서 **ViewController의 의존성을 최소화**하고 **반복 사용하는 객체 모듈**화를 위해 `MVVM` 패턴으로 리팩토링 중에 있습니다.

    <br><br>

## TroubleShooting
### 1. 첫 화면으로 전환하는 코드가 반복됨 -> protocol과 Extension을 이용한 모듈화로 코드 재사용성과 유지보수성을 높임
```swift
	  protocol MoveToFirstScene {
	      func moveToFirstScene()
	  }
```
```swift
	  extension MoveToFirstScene {
	      func moveToFirstScene() {
	          let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
	          let SceneDelegate = windowScene?.delegate as? SceneDelegate
	          
	          let tabBar = UITabBarController()
	          
	          let totalNav = UINavigationController(rootViewController: TotalViewController())
	          totalNav.tabBarItem = UITabBarItem(title: "totalNavigationTitle".localized(), image: Design.image.totalVC, tag: 0)
	          
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
```
<br><br>
### 2. 다른 enum들을 같은 cell에 사용해야 함 -> protocol과 generic을 이용하여 추상화 / 일반화하여 사용함
```swift
	  protocol CheckProtocol {
	      var title: String { get }
	      var subtitle: String { get }
	  }
```
```swift
	  struct CheckRecord<T: CheckProtocol>: Equatable {
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
	      
	      static func == (lhs: CheckRecord<T>, rhs: CheckRecord<T>) -> Bool {
	          if lhs.title == rhs.title && lhs.subtitle == rhs.subtitle &&
	              lhs.ischecked && rhs.ischecked {
	              return true
	          } else {
	              return false
	          }
	      }
	  }
```
<br><br>
### 3. 관계형 데이터베이스를 기반으로 데이터 정규화
| 초기 table | 최종 table |
| ------ | ------ |
![image](https://github.com/andwecrawl/Orang/assets/120160532/559e585f-1218-4147-a82d-4809ccd5be13) |![image](https://github.com/andwecrawl/Orang/assets/120160532/03912fad-c905-4eba-8fc3-94e78bb7f5a7)


<br><br>

## 회고
[🔗 자세한 회고 바로 가기](https://dk308c.tistory.com/50)
- 기획/개발 명세서를 작성하는 것부터 시작하여 UI를 그리고 기능을 얹어 출시까지 **하나의 앱이 만들어지는 모든 과정**을 다룰 수 있었다.
- **사용자의 입장**에서 원활한 이용과 자연스러운 **앱의 사용 흐름에 대해 고민**할 수 있었다.
- **짧은 기간에 많은 View**를 다루면서 CodebaseUI 구성에 능숙해졌다.
- 비교적 복잡한 Database를 구성하고 **Realm을 활용**하는 방법을 배울 수 있었다.
- **enum과 접근제어자를 활용**하여 **성능 최적화**를 달성했다.
- **protocol과 extension, generic을 활용**하여 자주 반복되는 코드를 **모듈화**하려고 노력했다.
- 시간상 row한 값으로 나타낸 코드들을 추후 조금 더 추상화하여 리팩토링하고 싶다.
<br><br><br>

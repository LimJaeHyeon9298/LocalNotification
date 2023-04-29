//
//  SceneDelegate.swift
//  LocalNotification
//
//  Created by 임재현 on 2023/04/29.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let _ = (scene as? UIWindowScene) else { return }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
        
        //알림으로 뱃지가 보여진후, 뱃지의 숫자를 없애주는 처리
        UIApplication.shared.applicationIconBadgeNumber = 0
    }

    func sceneWillResignActive(_ scene: UIScene) {
       
        //앱이 백그라운드모드나 전화받는 모드가 될때 알림을 전송
        
        UNUserNotificationCenter.current().getNotificationSettings { settings in // 앱의 알람 설정 상태 확인
                   print("Notification")
                   
                   if settings.authorizationStatus == UNAuthorizationStatus.authorized {
                       // setting이 알람을 받는다고 한 상태가 권한을 받은 상태라면
                       
                       // 1. 발송 내용 정의
                       let nContent = UNMutableNotificationContent()
                       nContent.badge = 1
                       nContent.title = "로컬 알람 메세지"
                       nContent.subtitle = "준비된 내용이 아주 많아요! 얼른 다시 앱을 열어주세요."
                       nContent.body = "다시 들어와!"
                       nContent.sound = .default
                       nContent.userInfo = ["name":"홍길동"]
                       
                       // 2. 발송 조건 정의
                       let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
                       
                       // 3. 알림 요청 생성
                       let request = UNNotificationRequest(identifier: "wakeup", content: nContent, trigger: trigger)
                       
                       // 4. 노티피케이션 센터에 등록
                       UNUserNotificationCenter.current().add(request) { err in
                           print("complete")
                       }
                   } else {
                       print("알림설정 X")
                   }
               }
               
           }
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }





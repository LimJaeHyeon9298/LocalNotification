//
//  ViewController.swift
//  LocalNotification
//
//  Created by 임재현 on 2023/04/29.
//

import UIKit
import UserNotifications

class ViewController: UIViewController {

    private let button:UIButton = {
        let button = UIButton()
        button.setTitle("알림버튼", for: .normal)
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .lightGray
        return button
    }()
    
    private let datePicker:UIDatePicker = {
        let picker = UIDatePicker()
        picker.preferredDatePickerStyle = .wheels
        picker.datePickerMode = .time
        picker.locale = Locale(identifier: "ko-KR")
        picker.timeZone = .autoupdatingCurrent
        picker.addTarget(self, action: #selector(timeChanged), for: .valueChanged)
        return picker
    }()
    
    private let selectTimeLabel:UILabel = {
        let label = UILabel()
        label.text = "시간을 선택해주세요"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = .black
        return label
    }()
    
    private let selectTimeButton:UIButton = {
        let button = UIButton()
        button.setTitle("시간알람", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .lightGray
        button.addTarget(self, action: #selector(timeButtonTapped), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configUI()
    }

    func configUI(){
        view.addSubview(button)
        button.centerX(inView: view,topAnchor: view.safeAreaLayoutGuide.topAnchor,paddingTop: 30)
        button.setDimensions(width: 100, height: 50)
        
        view.addSubview(datePicker)
        datePicker.anchor(top: button.bottomAnchor,left: view.leftAnchor,right: view.rightAnchor,paddingTop: 50,paddingLeft: 30,paddingRight: 30,height: 200)
        datePicker.backgroundColor = .lightGray
        
        view.addSubview(selectTimeLabel)
        selectTimeLabel.anchor(top: datePicker.bottomAnchor)
        selectTimeLabel.centerX(inView: view)
        
        view.addSubview(selectTimeButton)
        selectTimeButton.anchor(top: selectTimeLabel.bottomAnchor,paddingTop: 50)
        selectTimeButton.centerX(inView: view)
        selectTimeButton.setDimensions(width: 100, height: 50)
        
    }
    
    
    func alert() {
        
        //알림 내용 설정(보낼 알림 설정)
        let content = UNMutableNotificationContent()
        content.title = "Hello!"
        content.body = "Hello_message_body"
        content.sound = .default
        content.badge = 1
        content.userInfo = ["name":"Jake"]
        
        // 알림버튼이 눌리면 몇초안에 알림이 실행될지
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 10, repeats: false)
        //알림 ycjd
        let request = UNNotificationRequest(identifier: "FiveSecond", content: content, trigger: trigger)
        // Schedule the notification.
        let center = UNUserNotificationCenter.current()
        center.add(request) { (error : Error?) in
             if let error = error {
                 print("Debug: Error is \(error.localizedDescription)")
             } else {
                 print("Notification request added successfully")
             }
        }
    }
    @objc func buttonTapped(){
        
       alert()
        print("알림버튼 전송")
    }
    
    @objc func timeChanged() {
        //        selectTimeLabel.text = datePicker.date
        
        let formatter = DateFormatter()
        
        formatter.dateFormat = "a hh:mm "
        formatter.amSymbol = "AM"
        formatter.pmSymbol = "PM"
        let msg = formatter.string(from: datePicker.date)
        selectTimeLabel.text = msg
        print("hi\(msg)")
    }
    
    @objc func timeButtonTapped() {
        
        print("알림버튼 전송")
        
        let content = UNMutableNotificationContent()
        content.title = "정해진 시간이 되었습니다"
        content.body = "해야할 일을 완료했나요?"
        content.sound = .default
        content.badge = 1
        
        let component = Calendar.current.dateComponents([.hour, .minute], from:datePicker.date)
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: component, repeats: true)
        
        let request = UNNotificationRequest(identifier:"times", content: content, trigger: trigger)
        let center = UNUserNotificationCenter.current()
        center.add(request, withCompletionHandler: nil)
        
        
    }
    
    
}


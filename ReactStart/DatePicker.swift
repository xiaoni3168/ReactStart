//
//  DatePicker.swift
//  ReactStart
//
//  Created by 倪瑞 on 2016/10/25.
//  Copyright © 2016年 倪瑞. All rights reserved.
//

import Foundation
import UIKit
import WebKit

class DatePicker: UIViewController, UIActionSheetDelegate {
    var datePicker: UIDatePicker = UIDatePicker()
    var alertView: UIView! = UIView()
    var mainView: UIView!
    var webView: WKWebView!
    var callbackFunc: String! = ""
    
    init(mainView: UIView, webView: WKWebView) {
        super.init(nibName: "datePicker", bundle: nil)
        self.mainView = mainView
        self.webView = webView
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    func openDatePicker(initialDate: Int, mode: String, callback: String) {
        let screen: UIScreen = UIScreen.main
        let devicebounds: CGRect = screen.bounds
        let deviceWidth: CGFloat = devicebounds.width
        let deviceHeight: CGFloat = devicebounds.height
        let viewColor: UIColor = UIColor(white: 0, alpha: 0.6)
        
        alertView = UIView(frame: devicebounds)
        alertView.backgroundColor = viewColor
        alertView.isUserInteractionEnabled = true
        
        let selectButton: UIButton = createButton(title: "确定", x: 0, y: 0, width: 50, height: 35, target: self, action: #selector(DatePicker.selectDateAction))
        let cancelButton: UIButton = createButton(title: "取消", x: deviceWidth - 50, y: 0, width: 50, height: 35, target: self, action: #selector(DatePicker.cancelDateAction))
        
        let panel: UIView = UIView(frame: CGRect(x: 0, y: deviceHeight - 251, width: deviceWidth, height: 35))
        panel.backgroundColor = UIColor.white
        panel.addSubview(selectButton)
        panel.addSubview(cancelButton)
        
        if(mode == "DATE") {
            datePicker.datePickerMode = .date
        } else if(mode == "TIME") {
            datePicker.datePickerMode = .time
        } else if(mode == "DATE_AND_TIME") {
            datePicker.datePickerMode = .dateAndTime
        }
        let initalInterval = TimeInterval(CGFloat(initialDate)/1000)
        datePicker.date = NSDate(timeIntervalSince1970: initalInterval) as Date
        datePicker.backgroundColor = UIColor.white
        datePicker.frame = CGRect(x: 0, y: deviceHeight - 216, width: deviceWidth, height: 216)
        
        alertView.addSubview(datePicker)
//        alertView.addSubview(selectButton)
//        alertView.addSubview(cancelButton)
        alertView.addSubview(panel)
        
        let appLoadIn: CATransition = CATransition()
        appLoadIn.duration = 0.5
        appLoadIn.type = kCATransitionFade
        appLoadIn.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        
        
        self.mainView.layer.add(appLoadIn, forKey: kCATransitionFade)
        self.mainView.addSubview(alertView)
        
        callbackFunc = callback
    }
    
    func selectDateAction() {
        let dateInterval: String = self.dateInterval(date: datePicker.date)
        let realCallback: String = self.callbackFunc + "('" + dateInterval + "')";
        self.webView.evaluateJavaScript(realCallback, completionHandler: nil)
        print(dateInterval)
        alertView.removeFromSuperview()
    }
    
    func cancelDateAction() {
        alertView.removeFromSuperview()
    }
    
    func dateInterval(date: Date) -> String {
        print(date)
        
        return String(Int(date.timeIntervalSince1970 * 1000))
    }
    
    func createButton(title: String!, x: CGFloat, y: CGFloat, width: CGFloat, height: CGFloat, target: AnyObject!, action: Selector) -> UIButton {
        let buttonRect: CGRect = CGRect(x: x, y: y, width: width, height: height)
        let button: UIButton = UIButton(type: .system)
        
        button.setTitle(title, for: UIControlState.normal)
        button.frame = buttonRect
        button.backgroundColor = UIColor.white
        button.addTarget(target, action: action, for: UIControlEvents.touchUpInside)
        
        return button
    }
}

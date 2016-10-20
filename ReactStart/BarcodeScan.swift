//
//  BarcodeScan.swift
//  ReactStart
//
//  Created by 倪瑞 on 2016/10/16.
//  Copyright © 2016年 倪瑞. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation

@available(iOS 8.0, *)
class RootViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate, UIAlertViewDelegate {
    var scanReactView: UIView!
    var backButton: UIButton!
    var scanLine: UIImageView!
    var introduction: UILabel!
    var device: AVCaptureDevice!
    var input: AVCaptureDeviceInput!
    var output: AVCaptureMetadataOutput!
    var session: AVCaptureSession!
    var preview: AVCaptureVideoPreviewLayer!
    var timer: Timer!
    var num: Float!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        do {
            self.device = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeVideo)
            self.input = try AVCaptureDeviceInput(device: device)
            
            self.output = AVCaptureMetadataOutput()
            output.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            
            self.session = AVCaptureSession()
            if UIScreen.main.bounds.size.height < 500 {
                self.session.sessionPreset = AVCaptureSessionPreset640x480
            } else {
                self.session.sessionPreset = AVCaptureSessionPresetHigh
            }
            
            self.session.addInput(self.input)
            self.session.addOutput(self.output)
            
            // 扫码类型
            self.output.metadataObjectTypes = [AVMetadataObjectTypeQRCode]
            
            let windowSize: CGSize = UIScreen.main.bounds.size
            let scanSize: CGSize = CGSize(width: windowSize.width * 3 / 4, height: windowSize.width * 3 / 4)
            var scanRect: CGRect = CGRect(x: (windowSize.width - scanSize.width) / 2, y: (windowSize.height - scanSize.height) / 2, width: scanSize.width, height: scanSize.height)
            scanRect = CGRect(x: scanRect.origin.y / windowSize.height, y: scanRect.origin.x / windowSize.width, width: scanRect.size.height / windowSize.height, height: scanRect.size.width / windowSize.width)
            self.output.rectOfInterest = scanRect
            
            self.preview = AVCaptureVideoPreviewLayer(session: self.session)
            self.preview.videoGravity = AVLayerVideoGravityResizeAspectFill
            self.preview.frame = UIScreen.main.bounds
            self.view.layer.insertSublayer(self.preview, at: 0)
            
            // 扫描区域
            self.scanReactView = UIView()
            self.view.addSubview(self.scanReactView)
            self.scanReactView.frame = CGRect(x: 0, y: 0, width: 200, height: 200)
            self.scanReactView.center = CGPoint(x: UIScreen.main.bounds.midX, y: UIScreen.main.bounds.midY)
            self.scanReactView.backgroundColor = UIColor(patternImage: UIImage(named: "scanView@2x")!)
            
            // 扫描线
            self.scanLine = UIImageView(image: UIImage(named: "scanLine@2x"))
            self.view.addSubview(scanLine)
            self.scanLine.frame = CGRect(x: 0, y: 0, width: 200, height: 2)
            self.scanLine.center = CGPoint(x: UIScreen.main.bounds.midX, y: UIScreen.main.bounds.midY)
            
            // 扫描线动画
            num = 0
            timer = Timer.scheduledTimer(timeInterval: 0.02, target: self, selector: #selector(RootViewController.upToDownAnimate), userInfo: nil, repeats: true)
            
            // 帮助标签
            introduction = UILabel()
            self.view.addSubview(introduction)
            introduction.text = "请将二维码/条形码置于矩形方框内，并保持摄像头离图片15-20cm左右，系统将会自动识别。"
            introduction.textAlignment = NSTextAlignment.center
            introduction.font = UIFont.boldSystemFont(ofSize: 12)
            introduction.textColor = UIColor.white
            introduction.numberOfLines = 2
            introduction.frame = CGRect(x: 0, y: 0, width: 280, height: 40)
            introduction.center = CGPoint(x: UIScreen.main.bounds.midX, y: 100)
            
            // 返回
            self.backButton = UIButton()
            self.view.addSubview(self.backButton)
            self.backButton.frame = CGRect(x: 20, y: 20, width: 50, height: 50)
            self.backButton.backgroundColor = UIColor.black
            self.backButton.layer.cornerRadius = 25
            self.backButton.layer.opacity = 0.5
            self.backButton.setImage(UIImage(named: "back@2x"), for: UIControlState.normal)
            self.backButton.imageView?.contentMode = UIViewContentMode.scaleAspectFit
            self.backButton.addTarget(self, action: #selector(RootViewController.backAction(sender:)), for: UIControlEvents.touchUpInside)
            
            self.session.startRunning()
            
            do {
                try self.device!.lockForConfiguration()
            } catch _ {
                NSLog("Error: lockForConfiguration.")
            }
            
            self.device!.videoZoomFactor = 1.5
            self.device!.unlockForConfiguration()
        } catch _ as NSError {
            let authStatus = AVCaptureDevice.authorizationStatus(forMediaType: AVMediaTypeAudio)
            if (authStatus == AVAuthorizationStatus.denied || authStatus == AVAuthorizationStatus.restricted) {
                let settingButton: String? = UIApplicationOpenSettingsURLString != "" ? "设置" : nil
                let remindAlert = UIAlertView(title: "React", message: "访问相机已被拒绝，请在\"设置-隐私-相机\"选项中允许本程序访问您的相机", delegate: self, cancelButtonTitle: "确定", otherButtonTitles: settingButton!)
                remindAlert.show()
            }
        }
    }
    
    private func captureOutput(captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [AnyObject]!, fromConnection connection: AVCaptureConnection!) {
        var stringValue:String?
        
        if metadataObjects.count > 0 {
            let metadataObject = metadataObjects[0] as! AVMetadataMachineReadableCodeObject
            stringValue = metadataObject.stringValue
            
            if stringValue != nil {
                self.session.stopRunning()
            }
        }
        self.session.stopRunning()
        
        self.dismiss(animated: true) { () -> Void in
            print(stringValue!)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func backAction(sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func upToDownAnimate() {
        num! += 1
        scanLine.center = CGPoint(x: UIScreen.main.bounds.midX, y: CGFloat.init(num) + UIScreen.main.bounds.midY - 100)
        if num > 200 {
            num = 0
            scanLine.center = CGPoint(x: UIScreen.main.bounds.midX, y: UIScreen.main.bounds.midY - 100)
        }
    }
    
    private func alertView(alertView: UIAlertView, clickedButtonAtIndex buttonIndex: Int) {
        if(buttonIndex == 1) {
            UIApplication.shared.openURL(NSURL(string: UIApplicationOpenSettingsURLString)! as URL)
        }
        self.dismiss(animated: true, completion: nil)
    }
}

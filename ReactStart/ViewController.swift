//
//  ViewController.swift
//  ReactStart
//
//  Created by 倪瑞 on 16/10/8.
//  Copyright © 2016年 倪瑞. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController, WKUIDelegate, WKNavigationDelegate, WKScriptMessageHandler, UIAlertViewDelegate {
    var navItem: UINavigationItem!
    var webView: WKWebView!
    var goBack: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let navBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.maxX, height: 70))
        navBar.barStyle = UIBarStyle.default
        view.addSubview(navBar)
        
        goBack = UIBarButtonItem(title: "返回", style: UIBarButtonItemStyle.plain, target: self, action: #selector(ViewController.gbAction(sender:)))
        
        navItem = UINavigationItem()
        navItem.setLeftBarButton(goBack, animated: true)
        navBar.pushItem(navItem, animated: true)
        
        let userController = WKUserContentController()
        userController.add(self, name: "showAlertDialog")
        userController.add(self, name: "setNavigationBar")
        let config = WKWebViewConfiguration()
        config.userContentController = userController
        webView = WKWebView(frame: CGRect(x: 0, y: 70, width: UIScreen.main.bounds.maxX, height: UIScreen.main.bounds.maxY - 70), configuration: config)
        webView.navigationDelegate = self
        
        let bundlePath = Bundle.main.path(forResource: "h5", ofType: "bundle")
        let h5bundle = Bundle.init(path: bundlePath!)
        let htmlpath = h5bundle?.path(forResource: "__build__/app/DemoApp/index", ofType: "html")
        let baseUrl = URL(fileURLWithPath: htmlpath!, isDirectory: false)
        do {
            let html = try String(contentsOfFile: htmlpath!, encoding: String.Encoding.utf8)
            webView.loadHTMLString(html, baseURL: baseUrl)
        } catch {}
        view.addSubview(webView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        print("start")
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        print("start 1")
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        decisionHandler(.allow)
        print("start 2")
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        if(navigationAction.navigationType == .linkActivated) {
            decisionHandler(.cancel)
        } else {
            decisionHandler(.allow)
        }
        print(navigationAction.request.url)
    }
    
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        if(message.name == "showAlertDialog") {
            if let dic = message.body as? NSDictionary {
                let alert = UIAlertView(title: (dic["title"] as? String)!, message: (dic["message"] as? String)!, delegate: self, cancelButtonTitle: "cancel", otherButtonTitles: "hehe", "haha")
                alert.show()
            }
        }
        if(message.name == "setNavigationBar") {
            print(message.body)
            if let dic = message.body as? NSDictionary {
                let options = dic["options"] as! NSDictionary;
                navItem.title = options["title"] as? String
            }
        }
    }
    
    func alertView(_ alertView: UIAlertView, clickedButtonAt buttonIndex: Int) {
        print(buttonIndex)
    }
    
    func gbAction(sender: AnyObject) {
        print("go back")
        webView.goBack()
    }
}


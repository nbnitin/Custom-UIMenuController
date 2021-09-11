//
//  WebViewViewController.swift
//  CustomUIMenuController
//
//  Created by Nitin Bhatia on 9/11/21.
//

import UIKit
import WebKit

class WebViewViewController: UIViewController {
    
    @IBOutlet var webView: WKWebView!
    
    //variables
    var customMenuView : CustomMenuView! = CustomMenuView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //setting custom view and menu notification and webview 
        NotificationCenter.default.addObserver(self, selector: #selector(menuWillBeShown), name: UIMenuController.willShowMenuNotification, object: nil)
        let urlRequest = URLRequest(url: URL(string: "https://www.w3schools.com/html/html_intro.asp")!)
        webView.load(urlRequest)
        customMenuView.delegate = self
    }
    
    //MARK: remove custom menu
    func removeCustomMenu(){
        webView.scrollView.subviews.first?.resignFirstResponder()
        customMenuView.removeFromSuperview()
    }

    //MARK: menu will be shown notification function
    @objc func menuWillBeShown(){
        let frame = UIMenuController.shared.menuFrame
        customMenuView.frame = frame
        //customMenuView.frame.origin.y -= AppUtility.isPad() ? MARGIN_CUSTOM_VIEW_IPAD : MARGIN_CUSTOM_VIEW_IPHONE
        self.view.addSubview(customMenuView)
        
        //hiding default menu by inheriting the default menu controller
        DispatchQueue.main.async {
            FileJustToOverrideMenuController.shared.setMenuVisible(true, animated: true)
            UIMenuController.shared.setMenuVisible(false, animated: false)
        }
        let script = "window.getSelection().toString()"
        webView.evaluateJavaScript(script) { selectedString, error in
            self.customMenuView.str = selectedString as? String
        }
    }
}

//MARK: custom menu view delegates functions
extension WebViewViewController: CustomMenuViewDelegate {
    func didCopyButtonPressed(str:String?) {
        UIPasteboard.general.string = str ?? ""
        removeCustomMenu()
    }
    
    func didExploreButtonPressed(str:String?) {
        removeCustomMenu()
    }
    
    func didDefineButtonPressed(str:String?) {
        removeCustomMenu()
    }
}

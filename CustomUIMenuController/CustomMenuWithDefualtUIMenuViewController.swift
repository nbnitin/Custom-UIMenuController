//
//  CustomMenuWithDefualtUIMenuViewController.swift
//  CustomUIMenuController
//
//  Created by Nitin Bhatia on 9/11/21.
//

import UIKit

class CustomMenuWithDefualtUIMenuViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        enableCustomMenu()
        // Do any additional setup after loading the view.
    }
    
    func disableCustomMenu() {
           UIMenuController.shared.menuItems = nil
       }

    func enableCustomMenu() {
        becomeFirstResponder()
        let lookup = UIMenuItem(title: "Get Info", action: #selector(runGrok))
        
        
        UIMenuController.shared.menuItems = [lookup]
        
        
        (NSClassFromString("UICalloutBarButton")! as! UIButton.Type).appearance().setTitleColor(UIColor.red, for: UIControl.State.normal)
        
        (NSClassFromString("UICalloutBarButton")! as! UIButton.Type).appearance().backgroundColor = .black
        
        
        
    }
    
//    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
//        return (action == #selector(copy(_:)))
//    }
//
    @objc func runGrok() {
        print("i m in")
        
    }
    
}

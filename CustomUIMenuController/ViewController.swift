//
//  ViewController.swift
//  CustomUIMenuController
//
//  Created by Nitin Bhatia on 9/11/21.
//

import UIKit

class ViewController: UIViewController {
    
    //variables
    var customMenuView : CustomMenuView! = CustomMenuView()
    
    //outlets
    @IBOutlet var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //setting up custom menu and menu notification and text view
        NotificationCenter.default.addObserver(self, selector: #selector(menuWillBeShown), name: UIMenuController.willShowMenuNotification, object: nil)
        customMenuView.delegate = self
        textView.isEditable = false
        textView.delegate = self
    }

    //MARK: remove custom menu
    func removeCustomMenu(){
        textView.selectedTextRange = nil
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
        if let range = textView.selectedTextRange {
            customMenuView.str  = textView.text(in: range)
        }
    }
}

extension ViewController:UIScrollViewDelegate,UITextViewDelegate {
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        removeCustomMenu()
    }
}

//MARK: custom menu view delegates functions
extension ViewController: CustomMenuViewDelegate {
    func didCopyButtonPressed(str:String?) {
        UIPasteboard.general.string = str ?? ""
        removeCustomMenu()
    }
    
    func didExploreButtonPressed(str:String?) {
        removeCustomMenu()
    }
    
    func didDefineButtonPressed(str:String?) {
        let sb = UIStoryboard(name: "DescriptionPopUp", bundle: nil)
        let destination = sb.instantiateInitialViewController() as? ShowMeaningOfWordViewController
        destination?.titleLableText = str ?? ""
        self.addChild(destination!)
        self.view.addSubview(destination!.view)
        destination!.didMove(toParent: self)
        
        removeCustomMenu()
    }
}

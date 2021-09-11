//
//  PdfViewController.swift
//  CustomUIMenuController
//
//  Created by Nitin Bhatia on 9/11/21.
//

import UIKit
import PDFKit

class PdfViewController: UIViewController {
    
    //variables
    var pdfView : PDFView!
    var customMenuView : CustomMenuView! = CustomMenuView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //setting custom view and menu notification
        NotificationCenter.default.addObserver(self, selector: #selector(menuWillBeShown), name: UIMenuController.willShowMenuNotification, object: nil)
        customMenuView.delegate = self
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        //adding pdfview
        pdfView = PDFView(frame: self.view.frame)
        let gest = UITapGestureRecognizer(target: self, action: #selector(removeCustomMenu))
        pdfView.addGestureRecognizer(gest)
        let gest2 = UITapGestureRecognizer(target: self, action: #selector(tapGesture(_:)))
        gest2.numberOfTapsRequired = 2
        self.pdfView.addGestureRecognizer(gest2)
        guard let path = Bundle.main.url(forResource: "sample", withExtension: "pdf") else { return }
        
        if let document = PDFDocument(url: path) {
            pdfView.document = document
            pdfView.displayMode = .singlePageContinuous
            pdfView.autoScales = true
            pdfView.displayDirection = .vertical
            self.view.addSubview(pdfView)
        }
    }
    
    //MARK: remove custom menu
    @objc func removeCustomMenu(){
        pdfView.clearSelection()
        customMenuView.removeFromSuperview()
    }
    
    //MARK: menu will be shown notification function
    @objc func menuWillBeShown(){
        let frame = UIMenuController.shared.menuFrame
        customMenuView.frame = frame
        customMenuView.frame.origin.y = customMenuView.frame.origin.y < 80 ? customMenuView.frame.origin.y + 10 : customMenuView.frame.origin.y - 10
        self.view.addSubview(customMenuView)
        
        //hiding default menu by inheriting the default menu controller
        DispatchQueue.main.async {
            FileJustToOverrideMenuController.shared.setMenuVisible(true, animated: true)
            UIMenuController.shared.setMenuVisible(false, animated: false)
        }
        customMenuView.str = pdfView.currentSelection?.string ?? ""
    }
    
    @objc func tapGesture(_ gestureRecognizer: UITapGestureRecognizer) {
            let point = gestureRecognizer.location(in: pdfView)
            if let page = pdfView.page(for: point, nearest: false) {
                //convert point from pdfView coordinate system to page coordinate system
                let convertedPoint = pdfView.convert(point, to: page)

                //ensure that there is no link/url at this point
                if page.annotation(at: convertedPoint) == nil {
                    //get word at this point
                    if let selection = page.selectionForWord(at: convertedPoint) {
                        if let wordTouched = selection.string {
                            print(wordTouched)
                        }
                    }
                }
            }
    }
}

//MARK: custom menu view delegates functions
extension PdfViewController: CustomMenuViewDelegate {
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

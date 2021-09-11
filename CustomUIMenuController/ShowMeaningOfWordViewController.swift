//
//  ShowMeaningOfWordViewController.swift
//
//  Created by Nitin Bhatia on 9/10/21.
//  Copyright © 2021. All rights reserved.
//

import UIKit
import AVFoundation

extension UIView{
    func beizerRound(corners:UIRectCorner,size:CGSize=CGSize(width: 100, height: 100)){
        let rectShape = CAShapeLayer()
        rectShape.bounds = self.frame
        rectShape.position = self.center
        rectShape.path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: size).cgPath
        rectShape.name = "roundedShape"
        self.layer.mask = rectShape
    }
    
    func removeBeizerRound(){
        self.layer.mask.map({
            if $0.name == "roundedShape" {
                $0.removeFromSuperlayer()
            }
        })
    }
}

protocol ShowMeaningOfWordDisplayLogic: class {
    func displayData(description:String)
}

let INNERVIEW_TOP_CONSTRAINT_CONSTANT_INITIAL_IPAD :CGFloat = 22
let INNERVIEW_TOP_CONSTRAINT_CONSTANT_INITIAL_IPHONE :CGFloat  = 22
let INNERVIEW_TOP_CONSTRAINT_CONSTANT_AFTER_RESPONSE_IPAD :CGFloat = 44
let INNERVIEW_TOP_CONSTRAINT_CONSTANT_AFTER_RESPONSE_IPHONE :CGFloat = 22
let CONTAINER_HEIGHT_INITIAL_CONSTANT_IPAD :CGFloat = 100
let CONTAINER_HEIGHT_INITIAL_CONSTANT_IPHONE :CGFloat = 75
let INNERVIEW_BOTTOM_CONSTRAINT_CONSTANT_INITIAL_IPHONE : CGFloat = 0
let INNERVIEW_BOTTOM_CONSTRAINT_CONSTANT_INITIAL_IPAD : CGFloat = 60
let INNERVIEW_BOTTOM_CONSTRAINT_CONSTANT_AFTER_RESPONSE_IPHONE : CGFloat = 30
let INNERVIEW_BOTTOM_CONSTRAINT_CONSTANT_AFTER_RESPONSE_IPAD : CGFloat = 60

class ShowMeaningOfWordViewController: UIViewController,ShowMeaningOfWordDisplayLogic {
    
    //outlets
    @IBOutlet var innerViewBottomConstraint: NSLayoutConstraint!
    @IBOutlet var closeButton: UIButton!
    @IBOutlet var listenImageView: UIImageView!
    @IBOutlet var speakerButton: UIButton!
    @IBOutlet var innerViewTopConstraint: NSLayoutConstraint!
    @IBOutlet var containerHeightConstraint: NSLayoutConstraint!
    @IBOutlet var container: UIView!
    @IBOutlet var descriptionTextView: UITextView!
    @IBOutlet var titleLabel: UILabel!
    
   //variables
    var titleLableText : String!

    // MARK: Object lifecycle
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup() {
        let viewController = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setInitialConstraintConstant()
        titleLabel.text = titleLableText
    }
    
    //MARK: setting up initial constraints for container and inner view
    private func setInitialConstraintConstant(){
        containerHeightConstraint.constant = UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.pad ? CONTAINER_HEIGHT_INITIAL_CONSTANT_IPAD : CONTAINER_HEIGHT_INITIAL_CONSTANT_IPHONE
        innerViewTopConstraint.constant = UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.pad ? INNERVIEW_TOP_CONSTRAINT_CONSTANT_INITIAL_IPAD : INNERVIEW_TOP_CONSTRAINT_CONSTANT_INITIAL_IPHONE
        innerViewBottomConstraint.constant = UIDevice.current.userInterfaceIdiom ==  UIUserInterfaceIdiom.pad ? INNERVIEW_BOTTOM_CONSTRAINT_CONSTANT_INITIAL_IPAD : INNERVIEW_BOTTOM_CONSTRAINT_CONSTANT_INITIAL_IPHONE
    }
    
    //MARK: setting up  constraints for container and inner view after getting api response
    private func setAfterResponseConstraintConstant(){
        containerHeightConstraint.constant = (self.view.frame.height * 42.4) / 100
        innerViewTopConstraint.constant = UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.pad ? INNERVIEW_TOP_CONSTRAINT_CONSTANT_AFTER_RESPONSE_IPAD : INNERVIEW_TOP_CONSTRAINT_CONSTANT_AFTER_RESPONSE_IPHONE
        innerViewBottomConstraint.constant = UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.pad ? INNERVIEW_BOTTOM_CONSTRAINT_CONSTANT_AFTER_RESPONSE_IPAD : INNERVIEW_BOTTOM_CONSTRAINT_CONSTANT_AFTER_RESPONSE_IPHONE
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
            self.descriptionTextView.text = "This is a small demonstration .pdf file"
            self.descriptionTextView.text! += "- just for use in the Virtual Mechanics tutorials. More text. And more text. And more text. And more text. And more text. And more text. And more text. And more text. And more text. And more text. And more text. Boring, zzzzz. And more text. And more text. And"
            self.descriptionTextView.text! += "more text. And more text. And more text. And more text. And more text. And more text. And more text. And more text. And more text. And more text. And more text. And more text. And more text. And more text. Even more. Continued on page 2 ..."
            self.setAfterResponseConstraintConstant()
        })
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        container.beizerRound(corners: [.topLeft,.topRight],size:CGSize(width: 50, height: 50))
    }
    
    //MARK: displaying data with animation
    func displayData(description: String) {
        descriptionTextView.text = description
        setAfterResponseConstraintConstant()
        UIView.animate(withDuration: 0.4, animations: {
            self.view.layoutIfNeeded()
        })
    }
    
    //MARK: close button action
    @IBAction func closeButtonAction(_ sender: Any) {
        containerHeightConstraint.constant = 0
        UIView.animate(withDuration: 0.4, animations: {
            self.view.layoutIfNeeded()
        })
    }
}



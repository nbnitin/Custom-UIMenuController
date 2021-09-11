//
//  CustomMenuController.swift
//
//  Created by Nitin Bhatia on 9/9/21.
//  Copyright © 2021. All rights reserved.
//

import UIKit

protocol CustomMenuViewDelegate{
    func didCopyButtonPressed(str:String?)
    func didExploreButtonPressed(str:String?)
    func didDefineButtonPressed(str:String?)
}

class CustomMenuView : UIView {
    
    //outlet
    @IBOutlet var contentView: UIView!
    @IBOutlet var btnCopy: UIButton!
    @IBOutlet var btnDefine: UIButton!
    @IBOutlet var btnExplore: UIButton!
    
    //variable
    var delegate : CustomMenuViewDelegate?
    var str : String?
    
    override init(frame:CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit(){
        Bundle.main.loadNibNamed("CustomMenuView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight,.flexibleWidth]
        contentView.backgroundColor = UIColor(red: 51/255, green: 51/255, blue: 51/255, alpha: 1)
        contentView.layer.cornerRadius = 5
    }
   
    @IBAction func copyButtonAction(_ sender: Any) {
        delegate?.didCopyButtonPressed(str: str)
    }
    
    @IBAction func defineButtonAction(_ sender: Any) {
        delegate?.didDefineButtonPressed(str: str)
    }
    
    @IBAction func exploreButtonAction(_ sender: Any) {
        delegate?.didExploreButtonPressed(str: str)
    }
}

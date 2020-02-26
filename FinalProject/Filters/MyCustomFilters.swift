//
//  MyCustomFilters.swift
//  FinalProject
//
//  Created by Дмитрий Яковлев on 23.02.2020.
//  Copyright © 2020 Дмитрий Яковлев. All rights reserved.
//

import UIKit

class MyCustomFilters: UIView {
    
    
    private var nameLabel : UILabel?
    private var mySwitch : UISwitch?
    
    weak var delegate : FilterListUpdatingDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder:coder)
        setup()
    }
    
    private func setup(){
        
        nameLabel = UILabel(frame: CGRect(x: 5,y: 0,width: bounds.width - 40,height: 40))
        mySwitch = UISwitch(frame: CGRect(x: bounds.width - 40,y: 5,width: 40,height: 40))
        
        mySwitch?.addTarget(self, action: #selector(onUniverseSwitchValueChenged), for: .valueChanged)
        nameLabel?.textColor = UIColor.systemGray
        nameLabel?.numberOfLines = 0
        nameLabel?.lineBreakMode = .byWordWrapping
        nameLabel?.textAlignment = .left
        if nameLabel != nil , mySwitch != nil{
        addSubview(nameLabel!)
        addSubview(mySwitch!)
        }
    }
    
    func configure(text: String, isOn: Bool){
        nameLabel?.text = text
        mySwitch?.isOn = isOn
    }
    
    
    @objc private func onUniverseSwitchValueChenged(sender:UISwitch){
        
        delegate?.updateList(isOn: mySwitch!.isOn, filter: nameLabel?.text! ?? "")
    }
    
    
}

//
//  Filter.swift
//  FinalProject
//
//  Created by Дмитрий Яковлев on 23.02.2020.
//  Copyright © 2020 Дмитрий Яковлев. All rights reserved.
//

import Foundation


class Filter{
    private var text: String
    private var isOn: Bool
    
    init(text: String, isOn:Bool){
        self.text = text
        self.isOn = isOn
    }
    func getText()->String{
        return text
    }
    func getIsOn()->Bool{
        return isOn
    }
    func setIsOn(isOn: Bool){
        self.isOn = isOn
    }

    
}

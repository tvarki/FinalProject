//
//  MonsterFilterModel.swift
//  FinalProject
//
//  Created by Дмитрий Яковлев on 23.02.2020.
//  Copyright © 2020 Дмитрий Яковлев. All rights reserved.
//

import Foundation


class MonsterFilterModel{
    
    private var allFiltersStrings: [String]// = ["aberration", "beast", "celestial", "construct", "dragon", "elemental", "fey", "fiend", "giant", "humanoid", "monstrosity", "ooze", "plant", "swarm of tiny beasts", "undead"]
    
    
    private var allFilters: [Filter] = []
    
    init(allFiltersStrings: [String], list: [String]){
        self.allFiltersStrings = allFiltersStrings
        self.allFiltersStrings.forEach{ fltr in
            var tmp : Bool = false
            if list.contains(fltr){
                    tmp = true
            }else{
                tmp = false
            }
            allFilters.append(Filter(text: fltr,isOn: tmp))
        }
    }
    
    func getList()->[Filter]{
        return allFilters
    }
    
    func changeFilter(filter: String, isOn: Bool){
        allFilters.forEach{ fltr in
            if filter == fltr.getText(){
                fltr.setIsOn(isOn: isOn)
            }
        }
    }
    
}

//
//  Filters.swift
//  FinalProject
//
//  Created by Дмитрий Яковлев on 22.02.2020.
//  Copyright © 2020 Дмитрий Яковлев. All rights reserved.
//

import UIKit


protocol FilterListUpdatingDelegate: AnyObject{
    func updateList(isOn: Bool,filter: String)
}



class FiltersViewController: UIViewController {
    
    
    weak var delegate : setFilterListDelegate?
    public var allFiltersStrings: [String] = []
    
    public var myFilters: [String] = []
    
    private var monsterFilterModel : MonsterFilterModel?
    
    private var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var yTmp = 0
        let scrollView = UIScrollView(frame: view.bounds)
        monsterFilterModel = MonsterFilterModel(allFiltersStrings:allFiltersStrings,  list: myFilters)
        let allFilters = monsterFilterModel?.getList()
        allFilters!.forEach{fltr in
            let mySwitch = MyCustomFilters(frame: CGRect(x: 10, y:  yTmp,width: Int(view.bounds.width) - 30 , height: 40))
            mySwitch.delegate = self
            mySwitch.configure(text: fltr.getText(), isOn: fltr.getIsOn())
            scrollView.addSubview(mySwitch)
            yTmp += 40
        }
        scrollView.contentSize = CGSize(width: Int(view.bounds.width) - 10,height: (allFilters!.count)*40)
        
        view.addSubview(scrollView)
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        if self.isMovingFromParent {
            
            var tmp = monsterFilterModel?.getList()
            var list:[String] = []
            tmp?.forEach{ fltr in
                if fltr.getIsOn(){
                    list.append(fltr.getText())
                }
            }
            delegate?.updateList(list: list)
            
        }
    }
    
}




extension FiltersViewController: FilterListUpdatingDelegate{
    func updateList(isOn: Bool, filter: String) {
        monsterFilterModel?.changeFilter(filter: filter, isOn: isOn)
       // print("\(isOn) \(filter)" )
    }
}

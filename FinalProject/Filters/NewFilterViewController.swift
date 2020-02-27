//
//  NewFilterViewController.swift
//  FinalProject
//
//  Created by Дмитрий Яковлев on 27.02.2020.
//  Copyright © 2020 Дмитрий Яковлев. All rights reserved.
//

import UIKit



class NewFilterViewController: UIViewController {
    
    weak var delegate: SetFilterListDelegate?
    
    @IBOutlet weak var typePicker: UIPickerView!
    
    @IBOutlet weak var filterCollectionView: UIView!
    private var typesCollectionViewCOntroller : MyChildFilterViewController?
        
    var currentActiveTypeFilter:[String] = []
    var allTypeFiltersStrings: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTypesCollectionContentView()
        typePicker.dataSource = self
        typePicker.delegate = self
        // Do any additional setup after loading the view.
    }
    
    
    func configureTypesCollectionContentView(){
        guard let locationController = children.first as? MyChildFilterViewController else  {
            fatalError("Check storyboard for missing MyTestChildViewController")
        }
        typesCollectionViewCOntroller = locationController
        typesCollectionViewCOntroller?.monsterFilters = currentActiveTypeFilter
        typesCollectionViewCOntroller?.delegate = self
        setupViewVisibility()
    }
    
    func setupViewVisibility(){
        if typesCollectionViewCOntroller?.getCount() ?? 0 > 0 {
            filterCollectionView.isHidden = false
        }
        else{
            filterCollectionView.isHidden = true
        }
    }
    
    
    @IBAction func addButtonClick(_ sender: UIButton) {
        let index: Int = typePicker.selectedRow(inComponent: 0)
        let type = allTypeFiltersStrings[index]
        guard let tmp = typesCollectionViewCOntroller?.getList() else{return}
        guard !tmp.contains(type) else {
            makeAlert(title: "Warning", text: "Filter already contain \(type)")
            return
        }
        typesCollectionViewCOntroller?.addType(type:type)
        //                allTypeFiltersStrings.remove(at: tmp)
        setupViewVisibility()
        print(type)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
           super.viewWillDisappear(animated)
           if self.isMovingFromParent {
              guard let tmp = typesCollectionViewCOntroller?.getList() else{return}
               delegate?.updateList(list: tmp)
           }
       }
    
    
}

extension NewFilterViewController: UIPickerViewDelegate{
    
}

extension NewFilterViewController: UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return allTypeFiltersStrings.count
    
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        guard allTypeFiltersStrings.count > 0 else {return nil}
        return allTypeFiltersStrings[row]
    }
    
}

extension NewFilterViewController : FilterTyped{
    func tap(type:String) {
        //        allTypeFiltersStrings.append(type)
        setupViewVisibility()
    }
    
}

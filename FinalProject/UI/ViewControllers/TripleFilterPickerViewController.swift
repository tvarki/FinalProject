//
//  TripleFilterPickerViewController.swift
//  FinalProject
//
//  Created by Дмитрий Яковлев on 27.02.2020.
//  Copyright © 2020 Дмитрий Яковлев. All rights reserved.
//

import UIKit

class TripleFilterPickerViewController: UIViewController {
    @IBOutlet var singleFiltrTitle: UILabel!
    @IBOutlet var filterCollectionView: UIView!
    @IBOutlet var typePicker: UIPickerView!

    var firstArray: [String] = []
    var secondArray: [String] = []
    var thirdArray: [String] = []

    private var typesCollectionViewCOntroller: MyChildFilterViewController?

    private var typesSecond: SingleFilterPickerViewController?

    var currentActiveTypeFilter: [String] = []
    var allTypeFiltersStrings: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        configureTypesCollectionContentView()
        typePicker.dataSource = self
        typePicker.delegate = self

        // Do any additional setup after loading the view.
    }

    @IBAction func addButtonClick(_: UIButton) {
        var tmpValue = ""
        var index: Int = typePicker.selectedRow(inComponent: 0)
        tmpValue += firstArray[index]
        index = typePicker.selectedRow(inComponent: 1)
        tmpValue += secondArray[index]
        index = typePicker.selectedRow(inComponent: 2)
        tmpValue += thirdArray[index]

        guard let tmp = typesCollectionViewCOntroller?.getList() else { return }
        guard !tmp.contains(tmpValue) else {
            makeAlert(title: "Warning", text: "Filter already contain \(tmpValue)")
            return
        }

        typesCollectionViewCOntroller?.addType(type: tmpValue)
        //                allTypeFiltersStrings.remove(at: tmp)
        setupViewVisibility()
        print(tmpValue)
    }

    func setTitle(title: String) {
        singleFiltrTitle.text = title
    }

    func getList() -> [String]? {
        return typesCollectionViewCOntroller?.getList()
    }

    func configureTypesCollectionContentView() {
        guard let locationController = children.first as? MyChildFilterViewController else {
            fatalError("Check storyboard for missing MyChildFilterViewController")
        }
        typesCollectionViewCOntroller = locationController
        typesCollectionViewCOntroller?.monsterFilters = currentActiveTypeFilter
        typesCollectionViewCOntroller?.delegate = self
        setupViewVisibility()
    }

    func setupViewVisibility() {
        if typesCollectionViewCOntroller?.getCount() ?? 0 > 0 {
            filterCollectionView.isHidden = false
        } else {
            filterCollectionView.isHidden = true
        }
    }
}

extension TripleFilterPickerViewController: UIPickerViewDelegate {}

extension TripleFilterPickerViewController: UIPickerViewDataSource {
    func numberOfComponents(in _: UIPickerView) -> Int {
        return 3
    }

    func pickerView(_: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        var tmp = 0
        switch component {
        case 0:
            tmp = firstArray.count
        case 1:
            tmp = secondArray.count
        case 2:
            tmp = thirdArray.count
        default:
            tmp = 1
        }
        return tmp
    }

    func pickerView(_: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        guard allTypeFiltersStrings.count > 0 else { return nil }
        var tmp = ""
        switch component {
        case 0:
            tmp = firstArray[row]
        case 1:
            tmp = secondArray[row]
        case 2:
            tmp = thirdArray[row]
        default:
            tmp = ""
        }

        return tmp
//        return allTypeFiltersStrings[row]
    }
}

extension TripleFilterPickerViewController: FilterTyped {
    func tap(type _: String) {
        //        allTypeFiltersStrings.append(type)
        setupViewVisibility()
    }
}

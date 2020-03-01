//
//  SingleFilterPickerViewController.swift
//  Pods-FinalProject
//
//  Created by Дмитрий Яковлев on 27.02.2020.
//

import UIKit

class SingleFilterPickerViewController: UIViewController {
    @IBOutlet var singleFiltrTitle: UILabel!
    @IBOutlet var filterCollectionView: UIView!
    @IBOutlet var typePicker: UIPickerView!

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
        let index: Int = typePicker.selectedRow(inComponent: 0)
        let type = allTypeFiltersStrings[index]
        guard let tmp = typesCollectionViewCOntroller?.getList() else { return }
        guard !tmp.contains(type) else {
            makeAlert(title: "Warning", text: "Filter already contain \(type)")
            return
        }
        typesCollectionViewCOntroller?.addType(type: type)
        //                allTypeFiltersStrings.remove(at: tmp)
        setupViewVisibility()
        print(type)
    }

    func getList() -> [String]? {
        return typesCollectionViewCOntroller?.getList()
    }

    func configureTypesCollectionContentView() {
        guard let locationController = children.first as? MyChildFilterViewController else {
            fatalError("Check storyboard for missing MyTestChildViewController")
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

extension SingleFilterPickerViewController: UIPickerViewDelegate {}

extension SingleFilterPickerViewController: UIPickerViewDataSource {
    func numberOfComponents(in _: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_: UIPickerView, numberOfRowsInComponent _: Int) -> Int {
        return allTypeFiltersStrings.count
    }

    func pickerView(_: UIPickerView, titleForRow row: Int, forComponent _: Int) -> String? {
        guard allTypeFiltersStrings.count > 0 else { return nil }
        return allTypeFiltersStrings[row]
    }
}

extension SingleFilterPickerViewController: FilterTyped {
    func tap(type _: String) {
        //        allTypeFiltersStrings.append(type)
        setupViewVisibility()
    }
}

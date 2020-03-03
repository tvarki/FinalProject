//
//  QuickSearchPickerView.swift
//  FinalProject
//
//  Created by Дмитрий Яковлев on 02.03.2020.
//  Copyright © 2020 Дмитрий Яковлев. All rights reserved.
//

import UIKit

protocol QuickSearchValueChanged: AnyObject {
    func updatePickerViewValue(value: String)
}

class QuickSearchPickerView: UIViewController {
    var list: [String]?
    weak var delegate: QuickSearchValueChanged?
    var defaultItem: String?

    @IBOutlet var pv: UIPickerView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    func setup() {
        pv.dataSource = self
        pv.delegate = self
    }
}

extension QuickSearchPickerView: UIPickerViewDelegate {
    func pickerView(_: UIPickerView, didSelectRow row: Int, inComponent _: Int) {
        delegate?.updatePickerViewValue(value: list?[row] ?? "")
    }
}

extension QuickSearchPickerView: UIPickerViewDataSource {
    func numberOfComponents(in _: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_: UIPickerView, numberOfRowsInComponent _: Int) -> Int {
        return list?.count ?? 0
    }

    func pickerView(_: UIPickerView, titleForRow row: Int, forComponent _: Int) -> String? {
        guard let list = list else { return "" }
        return list[row]
    }
}

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

    private var typesSecond: SingleFilterPickerViewController?
    private var typesThird: TripleFilterPickerViewController?

    let cellID = "MonsterTypeCell"
    @IBOutlet var testCollectionView: UICollectionView!

    var currentActiveTypeFilter: [String] = []
    var allTypeFiltersStrings: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        testCollectionView.delegate = self
        testCollectionView.dataSource = self
        testCollectionView.register(UINib(nibName: cellID, bundle: nil), forCellWithReuseIdentifier: cellID)
        testCollectionView.allowsMultipleSelection = true
        configure()
        // Do any additional setup after loading the view.
    }

    func configure() {
        guard let locationController = children.first as? SingleFilterPickerViewController else {
            fatalError("Check storyboard for missing SingleFilterPickerViewController")
        }
        typesSecond = locationController
        typesSecond?.currentActiveTypeFilter = currentActiveTypeFilter
        typesSecond?.allTypeFiltersStrings = allTypeFiltersStrings

        guard let tmp = children.last as? TripleFilterPickerViewController else {
            fatalError("Check storyboard for missing TripleFilterPickerViewController")
        }
        typesThird = tmp

        typesThird?.setTitle(title: "Challenge Rating")

        typesThird?.firstArray = ["CRating"]
        typesThird?.secondArray = ["<", "<=", "=", ">=", ">"]
        typesThird?.thirdArray = ["0", "1/8", "1/4", "1/2", "1", "2", "3", "4", "5", "6", "7", "8",
                                  "9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20",
                                  "21", "22", "23", "24", "25", "26", "27", "28", "29", "30"]

        typesThird?.currentActiveTypeFilter = currentActiveTypeFilter
        typesThird?.allTypeFiltersStrings = allTypeFiltersStrings

//        typesSecond?.delegate = self
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if isMovingFromParent {
            guard let tmp = typesSecond?.getList() else { return }

//              guard let tmp = typesCollectionViewCOntroller?.getList()
            delegate?.updateList(list: tmp)
        }
    }
}

extension NewFilterViewController: UICollectionViewDelegate {}

extension NewFilterViewController: UICollectionViewDataSource {
    func collectionView(_: UICollectionView, numberOfItemsInSection _: Int) -> Int {
        return allTypeFiltersStrings.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath)
            as? MonsterTypeCell else { return UICollectionViewCell() }

        cell.setup(type: allTypeFiltersStrings[indexPath.row])
//        cell.setup(monster: mtArray[indexPath.row])
        cell.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tap(_:))))
        return cell
    }

    @objc func tap(_ sender: UITapGestureRecognizer) {
        let location = sender.location(in: testCollectionView)
        guard let indexPath = testCollectionView.indexPathForItem(at: location) else { return }

        guard let tmp = testCollectionView.cellForItem(at: indexPath) as? MonsterTypeCell else { return }
        tmp.mySelect()
        testCollectionView.selectItem(at: indexPath, animated: true, scrollPosition: .bottom)
    }
}

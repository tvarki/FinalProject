//
//  MyTestChildViewController.swift
//  FinalProject
//
//  Created by Дмитрий Яковлев on 27.02.2020.
//  Copyright © 2020 Дмитрий Яковлев. All rights reserved.
//

import UIKit

protocol FilterTyped: AnyObject {
    func tap(type: String)
}

class MyChildFilterViewController: UIViewController {
    @IBOutlet var cv: UICollectionView!
    @IBOutlet var myView: UIView!

    weak var delegate: FilterTyped?

    override func viewDidLoad() {
        super.viewDidLoad()

        cv.dataSource = self
        cv.register(UINib(nibName: cellID, bundle: nil), forCellWithReuseIdentifier: cellID)
    }

    var filters: [String]?
    let cellID = "MonsterTypeCell"

    func reloadData() {
        cv.reloadData()
    }

    func getCount() -> Int {
        return filters?.count ?? 0
    }

    func getList() -> [String] {
        return filters ?? []
    }

    func addType(type: String) {
        filters?.append(type)
        cv.reloadData()
    }
}

extension MyChildFilterViewController: UICollectionViewDelegate {}

extension MyChildFilterViewController: UICollectionViewDataSource {
    func collectionView(_: UICollectionView, numberOfItemsInSection _: Int) -> Int {
        guard let monsterFilters = filters else { return 0 }
        return monsterFilters.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath)
            as? MonsterTypeCell else { return UICollectionViewCell() }

        guard let filters = filters else { return UICollectionViewCell() }

        cell.setup(type: filters[indexPath.row])
        cell.setSelected()
        cell.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tap(_:))))
        return cell
    }

    @objc func tap(_ sender: UITapGestureRecognizer) {
        guard filters != nil else { return }
        let location = sender.location(in: cv)
        guard let indexPath = cv.indexPathForItem(at: location) else { return }
        let type = filters![indexPath.row]
        filters!.remove(at: indexPath.row)

        cv.reloadData()
        delegate?.tap(type: type)
    }
}

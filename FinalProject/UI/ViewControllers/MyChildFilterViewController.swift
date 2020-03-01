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

    var monsterFilters: [String]?
    let cellID = "MonsterTypeCell"

    func reloadData() {
        cv.reloadData()
    }

    func getCount() -> Int {
        return monsterFilters?.count ?? 0
    }

    func getList() -> [String] {
        return monsterFilters ?? []
    }

    func addType(type: String) {
        monsterFilters?.append(type)
        cv.reloadData()
    }
}

extension MyChildFilterViewController: UICollectionViewDelegate {}

extension MyChildFilterViewController: UICollectionViewDataSource {
    func collectionView(_: UICollectionView, numberOfItemsInSection _: Int) -> Int {
        guard let monsterFilters = monsterFilters else { return 0 }
        return monsterFilters.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath)
            as? MonsterTypeCell else { return UICollectionViewCell() }

        guard let monsterFilters = monsterFilters else { return UICollectionViewCell() }

        cell.setup(type: monsterFilters[indexPath.row])
        cell.setSelected()
//        cell.setup(monster: mtArray[indexPath.row])
        cell.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tap(_:))))
        return cell
    }

    @objc func tap(_ sender: UITapGestureRecognizer) {
        guard monsterFilters != nil else { return }
        let location = sender.location(in: cv)
        guard let indexPath = cv.indexPathForItem(at: location) else { return }
        let type = monsterFilters![indexPath.row]
        monsterFilters!.remove(at: indexPath.row)

        cv.reloadData()
        delegate?.tap(type: type)
    }
}

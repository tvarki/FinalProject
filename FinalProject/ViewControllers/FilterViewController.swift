//
//  FilterViewController.swift
//  FinalProject
//
//  Created by Дмитрий Яковлев on 28.02.2020.
//  Copyright © 2020 Дмитрий Яковлев. All rights reserved.
//

import UIKit

class FilterViewController: UIViewController {
    weak var delegate: SetFilterListDelegate?

    @IBOutlet var hintLabel: UILabel!
    let cellID = "MonsterTypeCell"
    @IBOutlet var miHintVIew: UIView!

    var currentActiveTypeFilter: [String] = []
    var allTypeFiltersStrings: [String] = []

    @IBOutlet var testCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        // Do any additional setup after loading the view.
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if isMovingFromParent {
            guard let cells = testCollectionView.visibleCells as? [MonsterTypeCell] else { return }
            var tmp: [String] = []
            for cell in cells where cell.mySelected {
                tmp.append(cell.getText())
            }
            delegate?.updateList(list: tmp)
        }
    }

    override func viewWillTransition(to _: CGSize, with _: UIViewControllerTransitionCoordinator) {
//        hintLabel.layer.removeAllAnimations()
//        startBasicAnimation()
    }

    func configure() {
        testCollectionView.delegate = self
        testCollectionView.dataSource = self
        testCollectionView.register(UINib(nibName: cellID, bundle: nil), forCellWithReuseIdentifier: cellID)
        testCollectionView.allowsMultipleSelection = true
        hintLabel.layer.cornerRadius = 5
        hintLabel.layer.masksToBounds = true
        startBasicAnimation()
    }

    func startBasicAnimation() {
        let positionAnimation = CABasicAnimation(keyPath: "position")
        let startPosition = hintLabel.layer.position

        positionAnimation.fromValue = CGPoint(x: 55, y: startPosition.y)
        positionAnimation.toValue = CGPoint(x: miHintVIew.frame.width - 55, y: startPosition.y)
        positionAnimation.duration = 4.5
        positionAnimation.autoreverses = true
        positionAnimation.repeatCount = .infinity
        hintLabel.layer.add(positionAnimation, forKey: "animatePosition")

        //        someView.layer.position = CGPoint(x: startPosition.x, y: startPosition.y + 250)
    }
}

extension FilterViewController: UICollectionViewDelegate {}

extension FilterViewController: UICollectionViewDataSource {
    func collectionView(_: UICollectionView, numberOfItemsInSection _: Int) -> Int {
        return allTypeFiltersStrings.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath)
            as? MonsterTypeCell else { return UICollectionViewCell() }

        if currentActiveTypeFilter.contains(allTypeFiltersStrings[indexPath.row]) {
            cell.mySelect()
        }
        cell.setup(type: allTypeFiltersStrings[indexPath.row])
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

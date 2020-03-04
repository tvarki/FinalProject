//
//  MyAbilityScoreViewController.swift
//  FinalProject
//
//  Created by Дмитрий Яковлев on 04.03.2020.
//  Copyright © 2020 Дмитрий Яковлев. All rights reserved.
//

import UIKit

class MyAbilityScoreViewController: UIViewController {
    @IBOutlet var myAbilityScoreCollectionView: UICollectionView!

    var abilityScores: [AbilityScore] = []
    let cellID = "AbilityScoreCollectionViewCell"

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        // Do any additional setup after loading the view.
    }

    func setup() {
        myAbilityScoreCollectionView.delegate = self
        myAbilityScoreCollectionView.dataSource = self
        myAbilityScoreCollectionView.register(UINib(nibName: cellID, bundle: nil), forCellWithReuseIdentifier: cellID)

        myAbilityScoreCollectionView.backgroundColor = .systemGray
    }
}

extension MyAbilityScoreViewController: UICollectionViewDelegate {}

extension MyAbilityScoreViewController: UICollectionViewDataSource {
    func collectionView(_: UICollectionView, numberOfItemsInSection _: Int) -> Int {
        abilityScores.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath)
            as? AbilityScoreCollectionViewCell else { return UICollectionViewCell() }

        cell.setParams(aScore: abilityScores[indexPath.row].name, value: abilityScores[indexPath.row].value)
        return cell
    }
}

extension MyAbilityScoreViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_: UICollectionView, layout _: UICollectionViewLayout, sizeForItemAt _: IndexPath) -> CGSize {
        let tmp = (myAbilityScoreCollectionView.frame.width - 24) / 3
        return (CGSize(width: tmp, height: 82))
    }
}

//
//  MyMonsterDetailViewController.swift
//  FinalProject
//
//  Created by Дмитрий Яковлев on 04.03.2020.
//  Copyright © 2020 Дмитрий Яковлев. All rights reserved.
//

import UIKit

class MyMonsterDetailViewController: UIViewController {
    var abilityScoreViewController: MyAbilityScoreViewController?

    @IBOutlet var monsterName: UILabel!
    @IBOutlet var monsterSize: UILabel!

    @IBOutlet var monsterType: UILabel!

    @IBOutlet var monsterHP: UILabel!
    @IBOutlet var monsterAC: UILabel!
    @IBOutlet var monsterSpeed: UILabel!

    var mstrName = ""
    var mstrSize = ""
    var mstrType = ""
    var mstrHP = ""
    var mstrAC = ""
    var mstrDesc = ""
    var mstrSpeed = ""
    var aScore: [AbilityScore] = []

    @IBOutlet var monsterDescription: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        // Do any additional setup after loading the view.
    }

    open override var shouldAutorotate: Bool {
        return false
    }

    override func viewWillAppear(_: Bool) {
        monsterName.text = mstrName
        monsterSize.attributedText = "📏 Size: \(mstrSize.firstUppercased)".toAttributedText(align: "left")
        monsterType.attributedText = "📌 Type: \(mstrType.firstUppercased)".toAttributedText(align: "left")
        monsterHP.attributedText = "🩸 HP: \(mstrHP)".toAttributedText(align: "left")
        monsterAC.attributedText = "🛡 AC: \(mstrAC)".toAttributedText(align: "left")
        monsterDescription.attributedText = mstrDesc.toAttributedText()
        monsterSpeed.attributedText = mstrSpeed.toAttributedText()
        abilityScoreViewController?.abilityScores = aScore
    }

    func setup() {
        configureContentView()
    }

    func setMonster(monster: MonsterItem) {
        mstrName = monster.name
        mstrSize = monster.size.makeBold()
        mstrType = monster.type.makeBold()
        mstrHP = "\(String(monster.hit_points).makeBold().addLineBreaker())🎲(\(monster.hit_dice))"
        mstrAC = "\(monster.armor_class)".makeBold()
        mstrDesc = "\(monster.getDescription())"
        mstrSpeed = monster.speed.toString()

        aScore = [AbilityScore(name: "Str", value: monster.strength),
                  AbilityScore(name: "Dex", value: monster.dexterity),
                  AbilityScore(name: "Con", value: monster.constitution),
                  AbilityScore(name: "Int", value: monster.intelligence),
                  AbilityScore(name: "Wis", value: monster.wisdom),
                  AbilityScore(name: "Char", value: monster.charisma)]
    }

    func configureContentView() {
        guard let locationController = children.first as? MyAbilityScoreViewController else {
            fatalError("Check storyboard for missing MyAbilityScoreViewController")
        }
        abilityScoreViewController = locationController

//        let tmp: [AbilityScore] = [AbilityScore(name: "Str", value: "20 (+5)"),
//                                   AbilityScore(name: "Dex", value: "20 (+5)"),
//                                   AbilityScore(name: "Con", value: "20 (+5)"),
//                                   AbilityScore(name: "Int", value: "20 (+5)"),
//                                   AbilityScore(name: "Wis", value: "20 (+5)"),
//                                   AbilityScore(name: "Char", value: "20 (+5)")]
//
//        abilityScoreViewController?.abilityScores = tmp
    }
}

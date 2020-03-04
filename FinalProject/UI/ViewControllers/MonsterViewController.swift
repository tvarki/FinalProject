//
//  ViewController.swift
//  FinalProject
//
//  Created by Дмитрий Яковлев on 17.01.2020.
//  Copyright © 2020 Дмитрий Яковлев. All rights reserved.
//

import UIKit

protocol SetFilterListDelegate: AnyObject {
    func updateList(list: [String])
}

class MonsterViewController: UIViewController {
    @IBOutlet var filtersCollection: UIView!
    @IBOutlet var qSearchPicker: UIView!

    var typesCollectionViewCOntroller: MyChildFilterViewController?
    var quickSearchPickerView: QuickSearchPickerView?
    var searchBar: UISearchBar?
    private let refreshControl = UIRefreshControl()
    let cellID = "MonsterTypeCell"
    var isSearching = false

    var searchingParametr: EnumMonsterParametrs = EnumMonsterParametrs(rawValue: EnumMonsterParametrs.getArray()[0]) ?? .other

    var monsterFilters: [String] = []

    let monsterService = MonsterViewModel()

    @IBOutlet var tablePickerValue: UISegmentedControl!

    @IBOutlet var monsterTableVIew: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    @IBAction func tablePickerValueChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            monsterService.switchToFavorite(isTrue: false)
        case 1:
            monsterService.switchToFavorite(isTrue: true)
        default:
            monsterService.switchToFavorite(isTrue: false)
        }
        search(str: searchBar?.text ?? "", filterList: monsterFilters, params: searchingParametr)
        monsterTableVIew.reloadData()
    }

    override func viewWillAppear(_: Bool) {
        search(str: searchBar?.text ?? "", filterList: monsterFilters, params: searchingParametr)
        setupViewVisibility()
    }

    @IBAction func filtersButtonPressed(_: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let viewController = storyboard.instantiateViewController(
            withIdentifier: "FilterViewController") as? FilterViewController
        //            withIdentifier: "NewFilterViewController") as? NewFilterViewController
        else { return }

        viewController.allTypeFiltersStrings = monsterService.getAllMonsterTypes()
        viewController.currentActiveTypeFilter = typesCollectionViewCOntroller?.getList() ?? []
        viewController.delegate = self
        navigationController?.pushViewController(viewController, animated: true)
    }

    func setup() {
        configureContentView()
        configure2ContentView()
        monsterService.delegate = self
        configurePullToRefresh()
        monsterTableVIew.delegate = self
        monsterTableVIew.dataSource = self

        monsterTableVIew.keyboardDismissMode = .onDrag

        searchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: monsterTableVIew.frame.size.width, height: 44.0))
        monsterTableVIew.tableHeaderView = searchBar
        searchBar?.delegate = self
        monsterService.switchToFavorite(isTrue: false)
    }

    func configureContentView() {
        guard let locationController = children.first as? MyChildFilterViewController else {
            fatalError("Check storyboard for missing MyChildFilterViewController")
        }
        typesCollectionViewCOntroller = locationController

        typesCollectionViewCOntroller?.delegate = self
        setupViewVisibility()
    }

    func configure2ContentView() {
        guard let locationController = children.last as? QuickSearchPickerView else {
            fatalError("Check storyboard for missing QuickSearchPickerView")
        }
        quickSearchPickerView = locationController
        let tmp = monsterService.getParamsArray()
        quickSearchPickerView?.list = tmp

        quickSearchPickerView?.delegate = self
    }

    private func configurePullToRefresh() {
        refreshControl.tintColor = UIColor.blue
        refreshControl.attributedTitle = NSAttributedString(string: "Downloading...")
        if #available(iOS 10.0, *) {
            monsterTableVIew.refreshControl = refreshControl
        } else {
            monsterTableVIew.addSubview(refreshControl)
        }
        refreshControl.addTarget(self, action: #selector(refreshData(_:)), for: .valueChanged)
    }

    @objc private func refreshData(_: UIRefreshControl) {
        if monsterFilters.count == 0 {
            //            monsterService.clearMonstersArray()
            monsterService.deleteAll()
            monsterTableVIew.reloadData()
            monsterService.updatePostsFromInternet()
        } else {
            refreshControl.endRefreshing()
            makeAlert(title: "Attention", text: "Cant reload data while filters is active.")
        }
    }
}

extension MonsterViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        guard let cell = tableView.cellForRow(at: indexPath) else { return }
        guard let tmp = cell.textLabel?.text else { return }

        let item = monsterService.getPost(name: tmp)
        guard item != nil else { return }

        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let viewController = storyboard.instantiateViewController(
            withIdentifier: "MyMonsterDetailViewController") as? MyMonsterDetailViewController
        else { return }

        viewController.setMonster(monster: item!)
        navigationController?.pushViewController(viewController, animated: true)

        //        makeAlert(title: monsterService.getName(of: indexPath.row), text: item?.toString() ?? "")
    }

    // MARK: - Swipe(right) action

    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let cell = tableView.cellForRow(at: indexPath)
        let actionSettings = createTypeActionSettings(cell: cell!, toDo: .checkUncheck)

        let action = UIContextualAction(style: .normal, title: actionSettings.title) { _, _, completionHandler in

            tableView.beginUpdates()
            cell?.accessoryType = actionSettings.aType

            self.checkUncheck(type: actionSettings.aType, indexPath: indexPath)
            completionHandler(true)
            tableView.endUpdates()
        }
        action.backgroundColor = actionSettings.bColor
        let configuration = UISwipeActionsConfiguration(actions: [action])
        return configuration
    }

    func checkUncheck(type: UITableViewCell.AccessoryType, indexPath: IndexPath) {
        if type == .checkmark {
            monsterService.setFaforite(forIndex: indexPath.row, value: true)
        } else {
            monsterService.setFaforite(forIndex: indexPath.row, value: false)
            if tablePickerValue.selectedSegmentIndex == 1 {
                monsterTableVIew.beginUpdates()
                monsterService.deleteFromFavorite(index: indexPath.row)

                monsterTableVIew.deleteRows(at: [indexPath], with: .automatic)
                monsterTableVIew.endUpdates()
            }
        }
    }

    private func createTypeActionSettings(cell: UITableViewCell, toDo: CellActions) -> CellActionSettings {
        var settings: CellActionSettings

        switch toDo {
        case .delete:
            settings = CellActionSettings(initTitle: "Удалить", initColor: UIColor.red, initAType: .none)
        case .deleteAll:
            settings = CellActionSettings(initTitle: "Очистить таблицу", initColor: UIColor.purple, initAType: .none)
        case .checkUncheck:
            if cell.accessoryType == UITableViewCell.AccessoryType.none {
                settings = CellActionSettings(initTitle: "To Favorite", initColor: UIColor.systemIndigo, initAType: .checkmark)
            } else {
                settings = CellActionSettings(initTitle: "From Favorite", initColor: UIColor.gray, initAType: .none)
            }
        }
        return settings
    }
}

extension MonsterViewController: UITableViewDataSource {
    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        //        let tmp =  postModel.getAllPosts(ofType: SwiftClassFactory.getDBMonsterClass())
        return monsterService.getCount()
    }

    func tableView(_: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = monsterTableVIew.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as UITableViewCell

        let post = monsterService.getPost(index: indexPath.row)

        //        qSearchPicker.isHidden = true

        if post.isFavorite {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        cell.textLabel?.text = monsterService.getName(of: indexPath.row)
        cell.detailTextLabel?.text = monsterService.getDetail(of: indexPath.row)

        if indexPath.row == monsterService.getGlobalCount() - 1, tablePickerValue.selectedSegmentIndex == 0 {
            monsterService.dawnloadNext()
        }

        return cell
    }
}

extension MonsterViewController: UISearchBarDelegate {
    func searchBar(_: UISearchBar, textDidChange searchText: String) {
        search(str: searchText, filterList: monsterFilters, params: searchingParametr)
    }

    func search(str: String, filterList: [String], params: EnumMonsterParametrs) {
        monsterService.setEMParams(value: params)
        monsterService.searchChanged(str: str, filterList: filterList, params: searchingParametr)
        monsterTableVIew.reloadData()
    }
}

extension MonsterViewController: ModelUpdating {
    func showError(error: String) {
        refreshControl.endRefreshing()
        makeAlert(title: "Attention", text: "Error while work with network \n \(error)")

        //        monsterService.updateFromDB()
        monsterTableVIew.reloadData()
    }

    func updateModel() {
        refreshControl.endRefreshing()
        monsterTableVIew.reloadData()
    }
}

extension MonsterViewController: SetFilterListDelegate {
    func updateList(list: [String]) {
        monsterFilters = list
        typesCollectionViewCOntroller?.filters = list
        typesCollectionViewCOntroller?.reloadData()
    }
}

extension UIViewController {
    struct CellActionSettings {
        var title: String // "Check"
        var bColor: UIColor
        var aType: UITableViewCell.AccessoryType

        init(initTitle: String, initColor: UIColor, initAType: UITableViewCell.AccessoryType) {
            title = initTitle
            bColor = initColor
            aType = initAType
        }
    }

    enum CellActions {
        case delete
        case deleteAll
        case checkUncheck
    }
}

extension MonsterViewController: FilterTyped {
    func tap(type _: String) {
        search(str: searchBar?.text ?? "", filterList: typesCollectionViewCOntroller?.getList() ?? [], params: searchingParametr)
        setupViewVisibility()
    }

    func setupViewVisibility() {
        if typesCollectionViewCOntroller?.getCount() ?? 0 > 0 {
            filtersCollection.isHidden = false
        } else {
            filtersCollection.isHidden = true
        }
    }
}

extension MonsterViewController: QuickSearchValueChanged {
    func updatePickerViewValue(value: String) {
        searchingParametr = EnumMonsterParametrs(rawValue: value) ?? .other
        searchBar?.text = ""
        search(str: searchBar?.text ?? "", filterList: monsterFilters, params: searchingParametr)
    }
}

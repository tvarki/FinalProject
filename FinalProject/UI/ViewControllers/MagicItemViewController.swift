//
//  MagicItemViewController.swift
//  FinalProject
//
//  Created by Дмитрий Яковлев on 02.03.2020.
//  Copyright © 2020 Дмитрий Яковлев. All rights reserved.
//

import UIKit

class MagicItemViewController: UIViewController {
    @IBOutlet var favoriteSegmentController: UISegmentedControl!

    @IBOutlet var magicItemUITable: UITableView!

    @IBOutlet var filterView: UIView!

    @IBOutlet var pickerView: UIView!
    var magicItemFilters: [String] = []

    private let refreshControl = UIRefreshControl()

    var typesCollectionViewCOntroller: MyChildFilterViewController?

    var magicItemViewModel = MagicItemViewModel()

    var searchBar: UISearchBar?

    var quickSearchPickerView: QuickSearchPickerView?

    var searchingParametr: EnumMagicItemParams = EnumMagicItemParams(rawValue: EnumMagicItemParams.getArray()[0]) ?? .other

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }

    override func viewWillAppear(_: Bool) {
        magicItemFilters = typesCollectionViewCOntroller?.getList() ?? []
        search(str: searchBar?.text ?? "", filterList: magicItemFilters, params: searchingParametr)
        setupViewVisibility()
    }

    @IBAction func filtersClicked(_: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let viewController = storyboard.instantiateViewController(
            withIdentifier: "FilterViewController") as? FilterViewController
        //            withIdentifier: "NewFilterViewController") as? NewFilterViewController
        else { return }

        viewController.allTypeFiltersStrings = magicItemViewModel.getAllMonsterTypes()
        viewController.currentActiveTypeFilter = typesCollectionViewCOntroller?.getList() ?? []
        viewController.delegate = self
        navigationController?.pushViewController(viewController, animated: true)
    }

    @IBAction func favoriteSegmentControllerValueChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            magicItemViewModel.switchToFavorite(isTrue: false)
        case 1:
            magicItemViewModel.switchToFavorite(isTrue: true)
        default:
            magicItemViewModel.switchToFavorite(isTrue: false)
        }
        search(str: searchBar?.text ?? "", filterList: magicItemFilters, params: searchingParametr)
        magicItemUITable.reloadData()
    }

    func configure() {
        configureContentView()
        configure2ContentView()
        magicItemViewModel.delegate = self

        magicItemUITable.keyboardDismissMode = .onDrag

        configurePullToRefresh()
        magicItemUITable.delegate = self
        magicItemUITable.dataSource = self
        searchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: magicItemUITable.frame.size.width, height: 44.0))
        magicItemUITable.tableHeaderView = searchBar
        searchBar?.delegate = self
        magicItemViewModel.switchToFavorite(isTrue: false)
    }

    private func configurePullToRefresh() {
        refreshControl.tintColor = UIColor.blue
        refreshControl.attributedTitle = NSAttributedString(string: "Downloading...")
        if #available(iOS 10.0, *) {
            magicItemUITable.refreshControl = refreshControl
        } else {
            magicItemUITable.addSubview(refreshControl)
        }
        refreshControl.addTarget(self, action: #selector(refreshData(_:)), for: .valueChanged)
    }

    @objc private func refreshData(_: UIRefreshControl) {
        if magicItemFilters.count == 0 {
            magicItemViewModel.deleteAll()
            magicItemUITable.reloadData()
            magicItemViewModel.updatePostsFromInternet()
        } else {
            refreshControl.endRefreshing()
            makeAlert(title: "Attention", text: "Cant reload data while filters is active.")
        }
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
        let tmp = magicItemViewModel.getParamsArray()
        quickSearchPickerView?.list = tmp

        quickSearchPickerView?.delegate = self
    }
}

extension MagicItemViewController: FilterTyped {
    func tap(type _: String?) {
        search(str: searchBar?.text ?? "", filterList: typesCollectionViewCOntroller?.getList() ?? [], params: searchingParametr)
        setupViewVisibility()
    }

    func setupViewVisibility() {
        if typesCollectionViewCOntroller?.getCount() ?? 0 > 0 {
            filterView.isHidden = false
        } else {
            filterView.isHidden = true
        }
    }
}

extension MagicItemViewController: UISearchBarDelegate {
    func searchBar(_: UISearchBar, textDidChange searchText: String) {
        search(str: searchText, filterList: magicItemFilters, params: searchingParametr)
    }

    func search(str: String, filterList: [String], params: EnumMagicItemParams) {
        magicItemViewModel.setEMParams(value: params)
        magicItemViewModel.searchChanged(str: str, filterList: filterList)
        magicItemUITable.reloadData()
    }
}

extension MagicItemViewController: ModelUpdating {
    func showError(error: String) {
        refreshControl.endRefreshing()
        makeAlert(title: "Attention", text: "Error while work with network \n \(error)")

//        monsterService.updateFromDB()
        magicItemUITable.reloadData()
    }

    func updateModel() {
        refreshControl.endRefreshing()
        magicItemUITable.reloadData()
    }
}

extension MagicItemViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        guard let cell = tableView.cellForRow(at: indexPath) else { return }
        guard let tmp = cell.textLabel?.text else { return }

        let item = magicItemViewModel.getPost(name: tmp)
        makeAlert(title: magicItemViewModel.getName(of: indexPath.row), text: item?.toString() ?? "")
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
            magicItemViewModel.setFaforite(forIndex: indexPath.row, value: true)
        } else {
            magicItemViewModel.setFaforite(forIndex: indexPath.row, value: false)
            if favoriteSegmentController.selectedSegmentIndex == 1 {
                magicItemUITable.beginUpdates()
                magicItemViewModel.deleteFromFavorite(index: indexPath.row)

                magicItemUITable.deleteRows(at: [indexPath], with: .automatic)
                magicItemUITable.endUpdates()
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

extension MagicItemViewController: UITableViewDataSource {
    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        //        let tmp =  postModel.getAllPosts(ofType: SwiftClassFactory.getDBMonsterClass())
        return magicItemViewModel.getCount()
    }

    func tableView(_: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = magicItemUITable.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as UITableViewCell

        let post = magicItemViewModel.getPost(index: indexPath.row)
        if post.isFavorite {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        cell.textLabel?.text = magicItemViewModel.getName(of: indexPath.row)
        cell.detailTextLabel?.text = magicItemViewModel.getDetail(of: indexPath.row)

        if indexPath.row == magicItemViewModel.getGlobalCount() - 1, favoriteSegmentController.selectedSegmentIndex == 0 {
            magicItemViewModel.dawnloadNext()
        }

        return cell
    }
}

extension MagicItemViewController: SetFilterListDelegate {
    func updateList(list: [String]) {
        magicItemFilters = list
        typesCollectionViewCOntroller?.filters = list
        typesCollectionViewCOntroller?.reloadData()
    }
}

extension MagicItemViewController: QuickSearchValueChanged {
    func updatePickerViewValue(value: String) {
        searchingParametr = EnumMagicItemParams(rawValue: value) ?? .other
        searchBar?.text = ""
        search(str: searchBar?.text ?? "", filterList: magicItemFilters, params: searchingParametr)
    }
}

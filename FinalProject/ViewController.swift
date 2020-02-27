//
//  ViewController.swift
//  FinalProject
//
//  Created by Дмитрий Яковлев on 17.01.2020.
//  Copyright © 2020 Дмитрий Яковлев. All rights reserved.
//

import UIKit

//enum MonsterTypeCellState{
//    case active
//    case passive
//}
//
//class MonsterType{
//    var type : String
//    var state: MonsterTypeCellState
//    init(type: String, active: MonsterTypeCellState){
//        self.type = type
//        self.state = active
//    }
//    
//}

protocol SetFilterListDelegate: AnyObject{
    func updateList(list: [String])
}

class ViewController: UIViewController {
    
    
    @IBOutlet weak var FiltersCollection: UIView!
    
    
    var typesCollectionViewCOntroller : MyChildFilterViewController?
    
    
    var searchBar : UISearchBar? = nil
    private let refreshControl = UIRefreshControl()
    
    let cellID = "MonsterTypeCell"
    
    var isSearching = false
    
    //    var mtArray:[MonsterType] = []
    
    var monsterFilters: [String] = []
    
    
    //    let reqService = RequestsService()
    //    let postModel = PostService()
    
    let monsterModel = MonsterModel()
    
    @IBOutlet weak var tablePickerValue: UISegmentedControl!
    
    @IBOutlet weak var monsterTableVIew: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
        setup()
    }
    
    
    
    @IBAction func tablePickerValueChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex{
            
        case 0:
            monsterModel.switchToFavorite(isTrue:false)
        //                    print(0)
        case 1:
            monsterModel.switchToFavorite(isTrue:true)
        //                    print(1)
        default:
            //                    print(0)
            monsterModel.switchToFavorite(isTrue:false)
            
        }
        monsterTableVIew.reloadData()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        search(str: searchBar?.text ?? "", filterList: monsterFilters)
        setupViewVisibility()
    }
    
    
    @IBAction func filtersButtonPressed(_ sender: UIButton) {
        
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let viewController = storyboard.instantiateViewController(withIdentifier: "NewFilterViewController") as? NewFilterViewController else { return }

        
        viewController.allTypeFiltersStrings = monsterModel.getAllMonsterTypes()
        viewController.currentActiveTypeFilter = typesCollectionViewCOntroller?.getList() ?? []                
        viewController.delegate = self
        navigationController?.pushViewController(viewController, animated: true)
        
        
        //        let vc = NewFilterViewController(nibName: "NewFilterViewController", bundle: nil)
        //        vc.allTypeFiltersStrings = monsterModel.getAllMonsterTypes()
        //        self.navigationController!.pushViewController(vc, animated: true)
        //
        //
        //        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        //              guard let viewController = storyboard.instantiateViewController(withIdentifier: "Filters") as? FiltersViewController else { return }
        //
        //        viewController.myFilters = typesCollectionViewCOntroller?.getList() ?? []
        //
        //        viewController.allFiltersStrings = monsterModel.getAllMonsterTypes()
        //
        //        viewController.delegate = self
        //        navigationController?.pushViewController(viewController, animated: true)
        
    }
    
    
    
    func setup(){
        
        configureContentView()
        monsterModel.delegate = self
        configurePullToRefresh()
        monsterTableVIew.delegate = self
        monsterTableVIew.dataSource = self
        
        self.searchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: monsterTableVIew.frame.size.width, height: 44.0))
        monsterTableVIew.tableHeaderView = searchBar
        searchBar?.delegate = self
        monsterModel.switchToFavorite(isTrue:false)
        
        
    }
    
    func configureContentView(){
        guard let locationController = children.first as? MyChildFilterViewController else  {
            fatalError("Check storyboard for missing MyTestChildViewController")
        }
        typesCollectionViewCOntroller = locationController
        
        typesCollectionViewCOntroller?.delegate = self
        setupViewVisibility()
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
    
    @objc private func refreshData(_ sender: UIRefreshControl) {
        if monsterFilters.count == 0{
            monsterModel.clearMonstersArray()
            monsterTableVIew.reloadData()
            monsterModel.updatePostsFromInternet()
        }else{
            refreshControl.endRefreshing()
            makeAlert(title: "Attention", text: "Cant reload data while filters is active.")
        }
    }
    
    
}

extension ViewController : UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        guard let cell = tableView.cellForRow(at: indexPath) else{return}
        guard let tmp = cell.textLabel?.text else {return}
        
        let item = monsterModel.getPost(index: tmp)
        makeAlert(title: item?.getCellData()[0] ?? "", text: item?.toString() ?? "")
        
    }
    
    //MARK:- Swipe(right) action
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let cell = tableView.cellForRow(at: indexPath)
        let actionSettings = createTypeActionSettings(cell: cell!,toDo: .checkUncheck)
        
        let action = UIContextualAction(style: .normal, title: actionSettings.title) { (action, view, completionHandler) in
            
            tableView.beginUpdates()
            cell?.accessoryType = actionSettings.aType
            
            
            self.checkUncheck(type: actionSettings.aType, indexPath: indexPath)
            completionHandler(true)
            tableView.endUpdates()
        }
        action.backgroundColor = actionSettings.bColor
        let configuration = UISwipeActionsConfiguration(actions: [ action ])
        return configuration
    }
    
    
    func checkUncheck(type : UITableViewCell.AccessoryType, indexPath:IndexPath){
        if type == .checkmark{
            monsterModel.setFaforite(forIndex: indexPath.row, value:true)
            //            self.talantModel?.getTalant(at: indexPath.row)?.setIsChecked(isChecked: true)
        }else{
            //            self.talantModel?.getTalant(at: indexPath.row)?.setIsChecked(isChecked: false)
            monsterModel.setFaforite(forIndex: indexPath.row, value:false)
            if tablePickerValue.selectedSegmentIndex == 1{
                
                
                monsterTableVIew.beginUpdates()
                monsterModel.deleteFromFavorite(index: indexPath.row)
                
                
                monsterTableVIew.deleteRows(at: [indexPath], with: .automatic)
                monsterTableVIew.endUpdates()
            }
        }
    }
    
    
    private func createTypeActionSettings(cell: UITableViewCell, toDo : cellActions) -> cellActionSettings{
        var settings : cellActionSettings
        
        switch toDo {
        case .delete:
            settings = cellActionSettings(initTitle: "Удалить", initColor: UIColor.red, initAType: .none)
        case .deleteAll:
            settings = cellActionSettings(initTitle: "Очистить таблицу", initColor: UIColor.purple, initAType: .none)
        case .checkUncheck:
            if cell.accessoryType == UITableViewCell.AccessoryType.none{
                settings = cellActionSettings(initTitle: "To Favorite", initColor: UIColor.systemIndigo, initAType: .checkmark)
            }else{
                settings = cellActionSettings(initTitle: "From Favorite", initColor: UIColor.gray, initAType: .none)
            }
        }
        return settings
    }
    
    
    
    
}

extension ViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        //        let tmp =  postModel.getAllPosts(ofType: SwiftClassFactory.getDBMonsterClass())
        let tmp =  monsterModel.getAllPosts()
        return tmp.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = monsterTableVIew.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as UITableViewCell
        let index = Int(indexPath.row)
        let items =  monsterModel.getAllPosts()
        //        print(items[index].toString())
        
        if items[index].isFavorite{
            cell.accessoryType = .checkmark
        }else{
            cell.accessoryType = .none
        }
        
        cell.textLabel?.text = items[index].getCellData()[0]
        cell.detailTextLabel?.text = items[index].getCellData()[1]
        
        return cell
    }
    
}

extension ViewController: UISearchBarDelegate{
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        search(str: searchText,filterList: monsterFilters)
    }
    
    func search(str: String,filterList: [String]){
        monsterModel.searchChanged(str: str,filterList: filterList)
        monsterTableVIew.reloadData()
    }
}

extension ViewController: ModelUpdating{
    func showError(error: String) {
        self.refreshControl.endRefreshing()
        self.makeAlert(title: "Attention", text: "Error while work with network \n \(error)")
        
        self.monsterModel.updateFromDB()
        self.monsterTableVIew.reloadData()
    }
    
    func updateModel() {
        DispatchQueue.main.async {
            self.refreshControl.endRefreshing()
            self.monsterTableVIew.reloadData()
        }
        
    }
}

extension ViewController:  SetFilterListDelegate{
    func updateList(list: [String]) {
        monsterFilters = list
        typesCollectionViewCOntroller?.monsterFilters = list
        typesCollectionViewCOntroller?.reloadData()
    }
}


extension UIViewController{
    
    struct cellActionSettings{
        var title : String //"Check"
        var bColor : UIColor
        var aType : UITableViewCell.AccessoryType
        
        init(initTitle : String , initColor : UIColor, initAType : UITableViewCell.AccessoryType){
            title = initTitle
            bColor = initColor
            aType = initAType
        }
    }
    enum cellActions{
        case delete
        case deleteAll
        case checkUncheck
    }
}


extension ViewController : FilterTyped{
    func tap(type:String) {
        search(str: searchBar?.text ?? "", filterList: typesCollectionViewCOntroller?.getList() ?? [])
        setupViewVisibility()
    }
    
    func setupViewVisibility(){
        if typesCollectionViewCOntroller?.getCount() ?? 0 > 0 {
            FiltersCollection.isHidden = false
        }
        else{
            FiltersCollection.isHidden = true
        }
    }
}

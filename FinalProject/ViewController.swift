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

protocol setFilterListDelegate: AnyObject{
    func updateList(list: [String])
}

class ViewController: UIViewController {
    
    var searchBar : UISearchBar? = nil
    private let refreshControl = UIRefreshControl()
    
    let cellID = "MonsterTypeCell"
    
    @IBOutlet weak var typesCollectionView: UICollectionView!
    
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
        setupCollectionViewVisibility()
        typesCollectionView.reloadData()
    }
    
    
    @IBAction func filtersButtonPressed(_ sender: UIButton) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
              guard let viewController = storyboard.instantiateViewController(withIdentifier: "Filters") as? FiltersViewController else { return }
                     
        viewController.myFilters = monsterFilters
        
        viewController.allFiltersStrings = monsterModel.getAllMonsterTypes()
        
        viewController.delegate = self
        navigationController?.pushViewController(viewController, animated: true)

    }
    
    
    
    func setup(){
        
        setupCollectionViewVisibility()
        monsterModel.delegate = self
        
        configurePullToRefresh()
        
        typesCollectionView.delegate = self
        typesCollectionView.dataSource = self
        
        typesCollectionView.register(UINib(nibName: cellID, bundle: nil), forCellWithReuseIdentifier: cellID)
        
        monsterTableVIew.delegate = self
        monsterTableVIew.dataSource = self
        
        self.searchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: monsterTableVIew.frame.size.width, height: 44.0))
        monsterTableVIew.tableHeaderView = searchBar
        searchBar?.delegate = self
        monsterModel.switchToFavorite(isTrue:false)

        
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
    
    func setupCollectionViewVisibility(){
        if monsterFilters.count>0{
            typesCollectionView.isHidden = false
        }
        else{
            typesCollectionView.isHidden = true
        }
    }
}

extension ViewController : UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        guard let cell = tableView.cellForRow(at: indexPath) else{return}
        guard let tmp = cell.detailTextLabel?.text else {return}
        
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


extension ViewController: UICollectionViewDelegate{

}

extension ViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return monsterFilters.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath)
            as? MonsterTypeCell else { return UICollectionViewCell() }
        cell.setup(type: monsterFilters[indexPath.row])
//        cell.setup(monster: mtArray[indexPath.row])
        cell.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tap(_:))))
        return cell
    }


    @objc func tap(_ sender: UITapGestureRecognizer) {

        let location = sender.location(in: self.typesCollectionView)
        guard let indexPath = self.typesCollectionView.indexPathForItem(at: location) else {return}

        monsterFilters.remove(at: indexPath.row)
        search(str: searchBar?.text ?? "", filterList: monsterFilters)
        setupCollectionViewVisibility()
        typesCollectionView.reloadData()

    }

}


extension ViewController:  setFilterListDelegate{
    func updateList(list: [String]) {
        monsterFilters = list
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

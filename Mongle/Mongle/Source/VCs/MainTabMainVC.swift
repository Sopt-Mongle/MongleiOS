//
//  MainTabMainVC.swift
//  Mongle
//
//  Created by 이주혁 on 2020/07/06.
//  Copyright © 2020 이주혁. All rights reserved.
//

import UIKit

class MainTabMainVC: UIViewController {
    
    //MARK:- IBOutlet
    @IBOutlet var layoutTableView: UITableView! {
        didSet {
            layoutTableView.tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0.1))
            layoutTableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 40, right: 0)
        }
    }
    @IBOutlet var shadowView: UIView!
    lazy var refreshControl = UIRefreshControl()
    var editorsTheme: [EditorPickData] = []
    var sentences: [TodaySentenceData] = []
    var curators: [MainCuratorData] = []
    var themes: [MainThemeData] = []
    var themesList: [[MainThemeData]] = [[],[],[]]
    
    // MARK:- Lifecycle Method
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        getEditorsContentsData()
        getTodaySentence()
        getCurators()
        
        getThemeList(flag: 0)
        getThemeList(flag: 1)
        getThemeList(flag: 2)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        refreshToken()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addRefreshControl()
        layoutTableView.delegate = self
        layoutTableView.dataSource = self
    }
    
    // MARK:- Custom Method
    func refreshToken(completion: (()->())? = nil) {
        if  UserDefaults.standard.string(forKey: "token") != "guest"{
            let date = Date()
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            let originDate = UserDefaults.standard.string(forKey: "tokenTime")!
            let ogD = formatter.date(from: originDate)
            let calendar = Calendar.current
            let diff = calendar.dateComponents([.minute], from: ogD!, to: date)
            
            if diff.minute! > 210  {
                guard let email = UserDefaults.standard.string(forKey: "email") else { return }
                guard let password = UserDefaults.standard.string(forKey: "password") else {return}
                SignInService.shared.signin(email: email,
                                            password: password)  { networkResult in
                    switch networkResult {
                    case .success(let token) :
                        guard let token = token as? String else { return }
                        UserDefaults.standard.set(token, forKey: "token")
                        if let comp = completion {
                            comp()
                        }
                        print("autoLogin")
                    case .requestErr(let message):
                        print("reqERR")
                    case .pathErr:
                        print("pathERR")
                    case .serverErr:
                        print("serverERR")
                    case .networkFail:
                        print("network")
                        
                    }
                }
            }
            else {
                if let comp = completion {
                    comp()
                }
            }
        }
    }
    
    func addRefreshControl() {
        if #available(iOS 10.0, *){
            self.layoutTableView.refreshControl = refreshControl
        }else{
            self.layoutTableView.addSubview(refreshControl)
        }
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
    }
    
    func setShadowState(state: Bool) {
        if state {
            shadowView.dropShadow(color: .black, offSet: CGSize(width: 0, height: 3), opacity: 0.04, radius: 6)
        }
        else {
            shadowView.dropShadow(color: .clear, offSet: CGSize(width: 0, height: 0), opacity: 1, radius: 0)
        }
    }
    
    func getThemeList(flag: Int) {
        MainService.shared.getThemeList(flag: flag){ networkResult in
            switch networkResult{
            case .success(let data):
                if let _data = data as? [MainThemeData] {
                    self.themesList[flag] = _data
                    DispatchQueue.main.async {
                        self.layoutTableView.reloadSections(IndexSet(arrayLiteral: flag + 3), with: .automatic)
                    }
                }
                
            case .requestErr(let msg):
                self.showToast(text: msg as? String ?? "")
            case .pathErr:
                self.showToast(text: "pathErr")
            case .serverErr:
                self.showToast(text: "serverErr")
            case .networkFail:
                self.showToast(text: "networkFail")
            }
        }
    }
    
    func getCurators(){
        MainService.shared.getPopularCurator { networkResult in
            switch networkResult {
            case .success(let data):
                if let _data = data as? [MainCuratorData] {
                    self.curators = _data
                }
                DispatchQueue.main.async {
                    self.layoutTableView.reloadSections(IndexSet(arrayLiteral: 2), with: .automatic)
                }
            case .requestErr(let msg):
                self.showToast(text: msg as? String ?? "")
            case .pathErr:
                break
            case .serverErr:
                break
            case .networkFail:
                break
            }
        }
    }
    
    func getTodaySentence(){
        MainService.shared.getTodaySentence { networkResult in
            switch networkResult {
            case .success(let data):
                if let _data = data as? [TodaySentenceData] {
                    self.sentences = _data
                    print(self.sentences)
                    DispatchQueue.main.async {
                        self.layoutTableView.reloadSections(IndexSet(arrayLiteral: 1), with: .automatic)
                    }
                }
            case .requestErr(let msg):
                print(msg as? String ?? "")
            case .pathErr:
                print("pathErr")
            case .serverErr:
                print("serverErr")
            case .networkFail:
                print("networkFail")
            }
        }
    }
    func getEditorsContentsData(){
        MainService.shared.getEditorsPick { networkResult in
            switch networkResult {
            case .success(let data):
                if let data_ = data as? [EditorPickData] {
                    self.editorsTheme = data_
                    DispatchQueue.main.async {
                        self.layoutTableView.reloadSections(IndexSet(arrayLiteral: 0), with: .automatic)
                    }
                }
            case .requestErr(let msg):
                self.showToast(text: msg as? String ?? "")
            case .pathErr:
                print("pathErr")
            case .serverErr:
                print("serverErr")
            case .networkFail:
                print("networkFail")
            }
        }
    }
    
    // MARK:- @objc Method
    @objc func refresh(){
        refreshToken { [weak self] in
            self?.getEditorsContentsData()
            self?.getTodaySentence()
            self?.getCurators()
            
            self?.getThemeList(flag: 0)
            self?.getThemeList(flag: 1)
            self?.getThemeList(flag: 2)
            print("asdasd")
            self?.refreshControl.endRefreshing()
        }
        
        
    }
    
    // MARK:- IBAction Method
    @IBAction func searchButton(_ sender: Any) {
        if let tabBar = self.tabBarController as? UnderTabBarController {
            if let searchVC = tabBar.viewControllers?[1] as? SearchTabMainVC{
                    searchVC.prevIdx = 0
                    tabBar.selectedIndex = 1
                
            }
        }
    }
}
// MARK:- Extension
// MARK: UITableViewDelegate
extension MainTabMainVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch section {
        case 0:
            let view = UIView()
            view.backgroundColor = .brown
            return view
        case 1:
            let view = MainTabDefaultHeaderView(frame: CGRect(x: 0, y: 0, width: 375, height: 48))
            view.setLabel(text: "오늘의 문장")
            return view
        case 2:
            let view = MainTabDefaultHeaderView(frame: CGRect(x: 0, y: 0, width: 375, height: 48))
            view.setLabel(text: "지금 인기있는 큐레이터")
            return view
        case 3:
            let view = MainTabDefaultHeaderView(frame: CGRect(x: 0, y: 0, width: 375, height: 48))
            view.setLabel(text: "오늘 가장 많이 저장된 테마")
            return view
        case 4:
            let view = MainTabDefaultHeaderView(frame: CGRect(x: 0, y: 0, width: 375, height: 48))
            view.setLabel(text: "문장을 기다리고 있는 테마")
            return view
        case 5:
            let view = MainTabDefaultHeaderView(frame: CGRect(x: 0, y: 0, width: 375, height: 48))
            view.setLabel(text: "요즘 사람들이 많이 본 테마")
            return view
        default:
            break
        }
        
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 1, 2, 3, 4, 5:
            return 22
        default:
            break
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
}

// MARK: UITableViewDataSource
extension MainTabMainVC: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 6
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: MainTabFirstTVC.identifier) as? MainTabFirstTVC else {
                return UITableViewCell()
            }
            cell.editorData = self.editorsTheme
            cell.selectedCellDelegate = {[weak self] dvc in
                self?.navigationController?.pushViewController(dvc, animated: true)
            }
            cell.mainDisplayPictureCollectionView.reloadData()
            cell.pageCollectionView.reloadData()
            return cell
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: MainTabSecondTVC.identifier) as? MainTabSecondTVC else {
                return UITableViewCell()
            }
            cell.selectSentenceDelegate = {[weak self] dvc in
                self?.navigationController?.pushViewController(dvc, animated: true)
            }
            cell.sentences = self.sentences
            cell.todaySentenceCollectionView.reloadData()
            
            return cell
        case 2:
            guard let cell = tableView.dequeueReusableCell(withIdentifier:MainTabThirdTVC.identifier) as? MainTabThirdTVC else {
                return UITableViewCell()
            }
            cell.curators = self.curators
            cell.popularCuratorCollectionView.reloadData()
            cell.cellSelectDelegate = { vc in
                self.navigationController?.pushViewController(vc, animated: true)
            }
            return cell
        case 3:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: MainTabFourthTVC.idnetifier) as? MainTabFourthTVC else {
                return UITableViewCell()
            }
            cell.selectedCell = { [weak self] vc in
                self?.navigationController?.pushViewController(vc, animated: true)
            }
            let themes = self.themesList[0]
            cell.themas = themes
            cell.popularThemaCollectionview.reloadData()
            
            return cell
        case 4:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: MainTabFourthTVC.idnetifier) as? MainTabFourthTVC else {
                return UITableViewCell()
            }
            cell.selectedCell = { [weak self] vc in
                self?.navigationController?.pushViewController(vc, animated: true)
            }
            let themes = self.themesList[1]
            cell.themas = themes
            cell.popularThemaCollectionview.reloadData()
            return cell
        case 5:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: MainTabFourthTVC.idnetifier) as? MainTabFourthTVC else {
                return UITableViewCell()
            }
            cell.selectedCell = { [weak self] vc in
                self?.navigationController?.pushViewController(vc, animated: true)
            }
            let themes = self.themesList[2]
            cell.themas = themes
            cell.popularThemaCollectionview.reloadData()
            return cell
        default:
            
            return UITableViewCell()
        }
    }
}
// MARK: UIScrollViewDelegaet
extension MainTabMainVC: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y == 0 {
            setShadowState(state: false)
        }
        else {
            setShadowState(state: true)
        }
    }
}

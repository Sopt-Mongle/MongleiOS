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
    @IBOutlet var layoutTableView: UITableView!
    
    //
    var imgString: [String] = []
    var sentence: [TodaySentenceData] = []
    var curators: [MainCuratorData] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getEditorsContentsData()
        getTodaySentence()
        getCurators()
        
        layoutTableView.delegate = self
        layoutTableView.dataSource = self
    }
    
    func getCurators(){
        MainService.shared.getPopularCurator { networkResult in
            switch networkResult {
            case .success(let data):
                if let _data = data as? [MainCuratorData] {
                    self.curators = _data
                }
                print(self.curators)
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
                    self.sentence = _data
                }
                print(self.sentence)
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
    func getEditorsContentsData(){
        MainService.shared.getEditorsPick { networkResult in
            switch networkResult {
            case .success(let data):
                if let data_ = data as? [EditorPickData] {
                    data_.forEach {
                        self.imgString.append($0.illust)
                    }
                }
                print(self.imgString)
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
}
// MARK:- Extension
// MARK: UITableViewDelegate
extension MainTabMainVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch section {
        case 0:
            let view = MainMongleHeaderView(frame: CGRect(x: 0, y: 0, width: 375, height: 58))
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
        case 0:
            return 58
        case 1, 2, 3, 4, 5:
            return 48
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
            cell.pictures = self.imgString
            return cell
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: MainTabSecondTVC.identifier) as? MainTabSecondTVC else {
                return UITableViewCell()
            }
            cell.selectSentenceDelegate = {[weak self] dvc in
                self?.navigationController?.pushViewController(dvc, animated: true)
            }
            
            return cell
        case 2:
            guard let cell = tableView.dequeueReusableCell(withIdentifier:MainTabThirdTVC.identifier) as? MainTabThirdTVC else {
                return UITableViewCell()
            }
            return cell
        case 3:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: MainTabFourthTVC.idnetifier) as? MainTabFourthTVC else {
                return UITableViewCell()
            }
            cell.selectedCell = { [weak self] vc in
                self?.navigationController?.pushViewController(vc, animated: true)
            }
            return cell
        case 4:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: MainTabFourthTVC.idnetifier) as? MainTabFourthTVC else {
                return UITableViewCell()
            }
            cell.selectedCell = { [weak self] vc in
                self?.navigationController?.pushViewController(vc, animated: true)
            }
            return cell
        case 5:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: MainTabFourthTVC.idnetifier) as? MainTabFourthTVC else {
                return UITableViewCell()
            }
            cell.selectedCell = { [weak self] vc in
                self?.navigationController?.pushViewController(vc, animated: true)
            }
            return cell
        default:
            return UITableViewCell()
        }
    }
}


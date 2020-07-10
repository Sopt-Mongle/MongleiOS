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
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        layoutTableView.delegate = self
        layoutTableView.dataSource = self
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
            
            view.delegate = { [weak self] in
                guard let dvc = UIStoryboard(name: "ThemeInfo", bundle: nil).instantiateViewController(identifier: "ThemeInfoVC") as? ThemeInfoVC else {
                    return
                }
                self?.navigationController?.pushViewController(dvc, animated: true)
//                self?.present(dvc, animated: true, completion: nil)
            }
            view.setLabel(text: "인기있는 테마")
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
        case 1, 2, 3:
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
        return 4
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
            return cell
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: MainTabSecondTVC.identifier) as? MainTabSecondTVC else {
                return UITableViewCell()
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
            return cell
        default:
            return UITableViewCell()
        }
    }
}


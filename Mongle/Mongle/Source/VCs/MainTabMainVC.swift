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

        // Do any additional setup after loading the view.
    }
    
}


// MARK:- Extension
// MARK: UITableViewDelegate
extension MainTabMainVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch section {
        case 0:
            let view = MainMongleHeaderView(frame: CGRect(x: 0, y: 0, width: 375, height: 58))
//            view.backgroundColor = .gray
            return view
        case 1:
            break
        case 2:
            break
        case 3:
            break
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
//            cell.backgroundColor = .brown
            
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
        return UITableViewCell()
    }
}


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
            break
        default:
            return UITableViewCell()
        }
        return UITableViewCell()
    }
}


//
//  MySettingVC.swift
//  Mongle
//
//  Created by 이주혁 on 2020/07/13.
//  Copyright © 2020 이주혁. All rights reserved.
//

import UIKit

class MySettingVC: UIViewController {
    
    //MARK:- IBOutlet
    @IBOutlet var settingTableview: UITableView! {
        didSet {
            settingTableview.delegate = self
            settingTableview.dataSource = self
        }
    }
    // MARK:- Property
    var settingSectionNames = ["개인 정보","문의","앱 정보"]
    var settingRowNames = [["프로필 수정", "계정 설정", "푸쉬 알림 설정"],["1:1 문의하기"],["버전 정보","개발자 정보","서비스 운영정책","개인정보 이용약관","서비스 이용약관","오픈소스 라이선스"]]
    var isPushNotificationAllowed = false
    var name = ""
    var introduce = ""
    var profileImage = ""
    var keywordIdx = 0

    
    //MARK:- Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        settingTableview.backgroundView?.backgroundColor = .blue
        
    }
    
    @IBAction func touchUpSettingButton(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}

//MARK:- Extension
//MARK: UITableViewDelegate
extension MySettingVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 35
    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if section != 2{
            let footer = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
            let separatorLine = UIView(frame:CGRect(x: 16, y: 16, width: 343, height: 1))
            footer.addSubview(separatorLine)
            separatorLine.backgroundColor = .veryLightPinkSix
            return footer
        }
        else{
            return UIView()
            
        }
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 35
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            switch indexPath.row{
            case 0:
                guard let nextVC = UIStoryboard(name: "ProfileEdit", bundle: nil).instantiateViewController(identifier: "ProfileEditVC") as? ProfileEditVC else {
                    return
                }
                self.navigationController?.pushViewController(nextVC, animated: true)
            case 1:
                guard let nextVC = UIStoryboard(name: "AccountEdit", bundle: nil).instantiateViewController(identifier: "AccountEditVC") as? AccountEditVC else {
                    return
                }
                self.navigationController?.pushViewController(nextVC, animated: true)
                
            default:
                break
            }
            
            
//        case 1:
            
            
        case 2:
            switch indexPath.row{
            case 0:
                guard let nextVC = UIStoryboard(name: "VersionInfo", bundle: nil).instantiateViewController(identifier: "VersionInfoVC") as? VersionInfoVC else {
                    return
                }
                self.navigationController?.pushViewController(nextVC, animated: true)
            
            case 1:
                guard let nextVC = UIStoryboard(name: "Mongles", bundle: nil).instantiateViewController(identifier: "MonglesVC") as? MonglesVC else {
                    return
                }
                self.navigationController?.pushViewController(nextVC, animated: true)
            default:
                break
            }
        default:
            break
        }
    }
}
//MARK: UITableViewDataSource
extension MySettingVC: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return settingSectionNames.count
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return settingSectionNames[section]
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingRowNames[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SettingTVC.identifier) as? SettingTVC else {
            return UITableViewCell()
        }
        cell.settingNameLabel.text = self.settingRowNames[indexPath.section][indexPath.row]
        cell.pushAllowBackground.alpha = 0
        cell.pushAllowButton.alpha = 0
        if indexPath.section == 0{
            if indexPath.row == 2{
                cell.cellSelectButton.alpha = 0
                cell.pushAllowBackground.alpha = 1
                cell.pushAllowButton.alpha = 1
            }
        }
        return cell
    }
}


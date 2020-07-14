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
    var settingNames = ["프로필 수정", "앱정보", "몽글즈"]
    
    //MARK:- Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        settingTableview.backgroundView?.backgroundColor = .blue
        
    }
}

//MARK:- Extension
//MARK: UITableViewDelegate
extension MySettingVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 300
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footer = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        
        let logoutButton = UIButton().then {
            $0.frame = CGRect(x: 0, y: 0, width: 74, height: 37)
            $0.setTitle("로그아웃", for: .normal)
            $0.setTitleColor(.brownGreyThree, for: .normal)
            $0.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        }
        let memberExitButton = UIButton().then {
            $0.frame = CGRect(x: 0, y: 0, width: 74, height: 37)
            $0.setTitle("회원 탈퇴", for: .normal)
            $0.setTitleColor(.brownGreyThree, for: .normal)
            $0.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        }
        
        let stackView = UIStackView().then {
            $0.axis = .vertical
            $0.spacing = 7
            $0.alignment = .center
            $0.addArrangedSubview(logoutButton)
            $0.addArrangedSubview(memberExitButton)
        }
        
        footer.addSubview(stackView)
        
        logoutButton.snp.makeConstraints {
            $0.width.equalTo(74)
            $0.height.equalTo(37)
        }
        memberExitButton.snp.makeConstraints {
            $0.width.equalTo(74)
            $0.height.equalTo(37)
        }
        stackView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(169)
            $0.leading.equalToSuperview().offset(16)
        }
        return footer
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            guard let dvc = UIStoryboard(name: "ProfileEdit", bundle: nil).instantiateViewController(identifier: "ProfileEditVC") as? ProfileEditVC else {
                return
            }
            dvc.modalPresentationStyle = .fullScreen
            self.present(dvc, animated: true, completion: nil)
        case 1:
            guard let dvc = UIStoryboard(name: "AppInfo", bundle: nil).instantiateViewController(identifier: "AppInfoVC") as? AppInfoVC else {
                return
            }
            self.present(dvc, animated: true, completion: nil)
        case 2:
            guard let dvc = UIStoryboard(name: "Mongles", bundle: nil).instantiateViewController(identifier: "MonglesVC") as? MonglesVC else {
                return
            }
            self.present(dvc, animated: true, completion: nil)
        default:
            break
        }
    }
}
//MARK: UITableViewDataSource
extension MySettingVC: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingNames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SettingTVC.identifier) as? SettingTVC else {
            return UITableViewCell()
        }
        cell.settingNameLabel.text = self.settingNames[indexPath.row]
        return cell
    }
}


//
//  AccountEditVC.swift
//  Mongle
//
//  Created by 이예슬 on 11/3/20.
//  Copyright © 2020 이주혁. All rights reserved.
//

import UIKit

class AccountEditVC: UIViewController {

    // MARK:- IBOutlet
    
    @IBOutlet weak var accountEditTableView: UITableView!
    @IBOutlet weak var backButton: UIButton!
    
    //MARK: - Custom Properties
    let heightRatio: CGFloat = UIScreen.main.bounds.height/812
    let widthRatio: CGFloat = UIScreen.main.bounds.width/375
    var accountEditMenu: [String] = ["비밀번호 변경", "로그아웃", "서비스 탈퇴"]
    //팝업뷰
    let blurImageView = UIImageView().then{
        $0.image = UIImage(named: "logoutPopupBg")
    }
    let popupView = UIView().then{
        $0.backgroundColor = .clear
    }
    var popupImageView = UIImageView().then{
        $0.image = UIImage(named: "logoutPopupBox")
    }
    var popupTitleLabel = UILabel().then{
        $0.text = "계정을 로그아웃 하시겠어요?"
        $0.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 15)
        $0.textColor = .black
        $0.adjustsFontSizeToFitWidth = true
    }
    var popupTextLabel = UILabel().then{
        $0.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 13)
        $0.numberOfLines = 0
        $0.textColor = .brownGreyThree
        $0.adjustsFontSizeToFitWidth = true
        $0.textAlignment = .center
    }
    var yesButton = UIButton().then{
        $0.setTitle("네", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.backgroundColor = .softGreen
        $0.makeRounded(cornerRadius: 19)
        $0.addTarget(self, action: #selector(yesButtonAction), for: .touchUpInside)
        $0.titleLabel?.font = $0.titleLabel?.font.withSize(13)
    }
    var noButton = UIButton().then{
        $0.setTitle("아니요", for: .normal)
        $0.setTitleColor(.softGreen, for: .normal)
        $0.backgroundColor = .white
        $0.makeRounded(cornerRadius: 19)
        $0.setBorder(borderColor: .softGreen, borderWidth: 1)
        $0.addTarget(self, action: #selector(noButtonAction), for: .touchUpInside)
        $0.titleLabel?.font = $0.titleLabel?.font.withSize(13)
    }
    var yesState: YesFunction = .logout

    // MARK:- LifeCycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        accountEditTableView.delegate = self
        accountEditTableView.dataSource = self
    
    }
    
    // MARK:- Custom Methods
    func showPopupView(_ popupTitle: String, _ popupText: String){
        
        self.view.addSubview(blurImageView)
        self.view.addSubview(popupView)
        self.popupView.addSubview(popupImageView)
        self.popupView.addSubview(popupTitleLabel)
        self.popupView.addSubview(popupTextLabel)
        self.popupView.addSubview(yesButton)
        self.popupView.addSubview(noButton)
        //constraints
        self.popupTitleLabel.text = popupTitle
        self.popupTextLabel.text = popupText
        self.blurImageView.snp.makeConstraints{
            $0.top.bottom.leading.trailing.equalToSuperview()
        }
        self.popupView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(290*heightRatio)
            $0.leading.equalToSuperview().offset(35*widthRatio)
            $0.bottom.equalToSuperview().offset(-289*heightRatio)
            $0.trailing.equalToSuperview().offset(-35*widthRatio)
        }
        self.popupImageView.snp.makeConstraints{
            $0.top.bottom.leading.trailing.equalToSuperview()
        }
        self.popupTitleLabel.snp.makeConstraints{
            $0.top.equalToSuperview().offset(84*heightRatio)
            $0.bottom.equalToSuperview().offset(-131*heightRatio)
            $0.centerX.equalToSuperview()
        }
        self.popupTextLabel.snp.makeConstraints{
            $0.top.equalToSuperview().offset(112*heightRatio)
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-88*heightRatio)
        }
        self.yesButton.snp.makeConstraints{
            $0.top.equalToSuperview().offset(171*heightRatio)
            $0.bottom.equalToSuperview().offset(-25*heightRatio)
            $0.leading.equalToSuperview().offset(20*widthRatio)
            $0.trailing.equalToSuperview().offset(-157*widthRatio)
        }
        self.noButton.snp.makeConstraints{
            $0.top.equalToSuperview().offset(171*heightRatio)
            $0.bottom.equalToSuperview().offset(-25*heightRatio)
            $0.leading.equalToSuperview().offset(161*widthRatio)
            $0.trailing.equalToSuperview().offset(-16*widthRatio)
        }
        accountEditTableView.isUserInteractionEnabled = false
        backButton.isUserInteractionEnabled = false
        
    }
    
    func callWithdraw(){
        print(UserDefaults.standard.string(forKey: "email"))
        WithdrawService.shared.deleteRequest(email: UserDefaults.standard.string(forKey: "email") ?? "", password: UserDefaults.standard.string(forKey: "password") ?? ""){ networkResult in
            switch networkResult{
                case .success(let message):
                    guard let message = message as? String else { return }
                    print(message)
                    UserDefaults.standard.removeObject(forKey: "email")
                    UserDefaults.standard.removeObject(forKey: "password")
                    guard let loginVC = UIStoryboard(name:"LogIn", bundle:nil).instantiateViewController(identifier: "LogInVC") as? LogInVC else{
                                        return
                                    }
                    loginVC.modalPresentationStyle = .fullScreen
                    self.present(loginVC,animated: true){
                        self.navigationController?.popToRootViewController(animated: false)
                    }
                    
                case .requestErr(let message):
                    
                    guard let message = message as? String else { return }
                    print(message)
                    self.showToast(text: message)
                case .pathErr:
                    
                    print("path")
                case .serverErr:
                    print("serverErr")
                    self.showToast(text: "서버 내부 오류")
                case .networkFail:
                    print("networkFail")
                    self.showToast(text: "네트워크 실패")
                }
        
            
        }
    }
    //MARK: - @objc functions
    @objc func yesButtonAction(){
        
        switch yesState{
        
        case .logout:
            UserDefaults.standard.setValue("guest", forKey: "token")
            UserDefaults.standard.removeObject(forKey: "email")
            UserDefaults.standard.removeObject(forKey: "password")
            guard let loginVC = UIStoryboard(name:"LogIn", bundle:nil).instantiateViewController(identifier: "LogInVC") as? LogInVC else{
                                return
                            }
            loginVC.modalPresentationStyle = .fullScreen
            self.present(loginVC,animated: true){
                self.navigationController?.popToRootViewController(animated: false)
            }
        
        case .withdraw:
            callWithdraw()
        }
        
    }
    @objc func noButtonAction(){
        accountEditTableView.isUserInteractionEnabled = true
        backButton.isUserInteractionEnabled = true
        blurImageView.removeFromSuperview()
        popupView.removeFromSuperview()
    }
    
    // MARK:- IBActions
    @IBAction func touchUpBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
}

// MARK:- Extensions
extension AccountEditVC: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row{
        //비번변경
        case 0:
            guard let nextVC = UIStoryboard(name: "PasswordChange",bundle: nil).instantiateViewController(identifier: "PasswordChangeVC") as? PasswordChangeVC else{
                return
            }
    
            self.navigationController?.pushViewController(nextVC, animated: true)
        //로그아웃
        case 1:
            yesState = .logout
            popupImageView.image = UIImage(named:"logoutPopupBox")
            showPopupView("계정을 로그아웃 하시겠어요?", "로그아웃 후 몽글을 이용하려면\n다시 로그인을 해주세요!")
        //회원탈퇴
        case 2:
            yesState = .withdraw
            popupImageView.image = UIImage(named:"outPopupBox")
            showPopupView("몽글을 탈퇴하시겠어요?","탈퇴 후에는 몽글을 이용할 수 없어요!")
            
        default:
            break
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}

extension AccountEditVC: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return accountEditMenu.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AccountEditTVC.identifier) as? AccountEditTVC else{
            return UITableViewCell()
        }
        cell.accountEditMenuLabel.text = accountEditMenu[indexPath.row]
        
        return cell
    }
    
    
}
enum YesFunction{
    case logout
    case withdraw
}

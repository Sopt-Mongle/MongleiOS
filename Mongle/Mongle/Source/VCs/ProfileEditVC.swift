//
//  ProfileEditVC.swift
//  Mongle
//
//  Created by 이주혁 on 2020/07/14.
//  Copyright © 2020 이주혁. All rights reserved.
//

import UIKit

class ProfileEditVC: UIViewController{
    
    // MARK:- IBOutlet
    @IBOutlet weak var nickNameCountLabel: UILabel!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet var profileImageView: UIImageView!
    @IBOutlet var nickNameTextField: UITextField! {
        didSet {
            nickNameTextField.delegate = self
            nickNameTextField.autocorrectionType = .no
        }
    }
    @IBOutlet var layoutTableView: UITableView! {
        didSet {
            layoutTableView.dataSource = self
            layoutTableView.delegate = self
        }
    }
    @IBOutlet var keywordButton: [UIButton]!
    @IBOutlet var keywordBackgroundView: UIView!
    @IBOutlet var cameraButton: UIButton!
    @IBOutlet var completeButton: UIButton!
    @IBOutlet var bottomBlurImageBottomConstraint: NSLayoutConstraint!
    @IBOutlet var keywordLabelTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var topBlurView: UIImageView!
    @IBOutlet weak var nickNameWarningImageView: UIImageView!
    
    @IBOutlet weak var nickNameWarningLabel: UILabel!
    
    // MARK:- UIComponent
    lazy var imagePickerController = UIImagePickerController().then {
        $0.sourceType = .photoLibrary
        $0.allowsEditing = true
        $0.delegate = self
    }
    
    // MARK: Property
    var keywords: [String] = ["감성자극", "동기부여", "자기계발", "깊은생각", "독서기록", "일상문장"]
    var selectedKeywordIdx: Int = 1
    var isScrollSpended: Bool = false
    var name: String = ""
    var profileImage: String?
    var introduce: String = UserDefaults.standard.string(forKey: "UserProfileIntroduce") ?? ""
    let heightRatio: CGFloat = UIScreen.main.bounds.height/812
    let widthRatio: CGFloat = UIScreen.main.bounds.width/375
    var imageFlag = false
    // MARK:- Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setLayout()
        setKeywordButton()
        updateSelectedKeywordButton()
        setGesture()
        partialGreenColor()
        nickNameTextField.addTarget(self, action: #selector(textFieldDidChange(sender:)), for: .editingChanged)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        updateSelectedKeywordButton()
        registerForKeyboardNotifications()
        setData()
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        unregisterForKeyboardNotifications()
    }

    
    func registerForKeyboardNotifications() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow(_:)), name:
                                                UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name:
                                                UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func unregisterForKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name:
                                                    UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name:
                                                    UIResponder.keyboardWillHideNotification, object: nil)
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        self.view.endEditing(true)
    }
    // MARK:- @objc Method
    @objc func keyboardWillShow(_ notification: NSNotification) {
        
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey]
                                as? NSValue)?.cgRectValue {
            self.bottomBlurImageBottomConstraint.constant = -keyboardSize.height + 20
            
            UIView.animate(withDuration: 0.3, animations: {
                self.view.layoutIfNeeded()
            })
            
        }
        self.topBlurView.alpha = 1
    }
    @objc func textFieldDidChange(sender:UITextField) {

            if let text = sender.text {
                // 초과되는 텍스트 제거
                if text.count > 6 {
                    let index = text.index(text.startIndex, offsetBy: 5)
                    let newString = text[text.startIndex...index]
                    sender.text = String(newString)
                }
                nickNameCountLabel.text = "\((sender.text?.count)!)/6"
            }
        
    }
    @objc func keyboardWillHide(_ notification: NSNotification) {
        guard let duration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey]
                as? Double else {return}
        guard let curve = notification.userInfo?[UIResponder.keyboardAnimationCurveUserInfoKey]
                as? UInt else {return}
        self.bottomBlurImageBottomConstraint.constant = -17
        UIView.animate(withDuration: duration,
                       delay: 0.0,
                       options: .init(rawValue: curve),
                       animations: {
                        self.view.layoutIfNeeded()
                       })
        self.topBlurView.alpha = 0
        //self.view.layoutIfNeeded()
    }
    @objc func touchUpProfileImageView(){
        self.present(self.imagePickerController, animated: true, completion: nil)
    }
    @objc func yesButtonAction(){
        self.navigationController?.popViewController(animated: true)
    }
    // MARK: Custom Method
    func setLayout(){
        keywordBackgroundView.backgroundColor = UIColor.veryLightPinkEight
        profileImageView.makeRounded(cornerRadius: profileImageView.frame.width / 2)
        cameraButton.makeRounded(cornerRadius: cameraButton.frame.width / 2)
        
        nickNameTextField.makeRounded(cornerRadius: 10)
        nickNameTextField.setBorder(borderColor: .veryLightPinkFive, borderWidth: 1)
        
        nickNameTextField.addLeftPadding(left: 15)
        
        completeButton.makeRounded(cornerRadius: 28)
        
    }
    
    func setKeywordButton(){
        var idx: Int = 1
        keywordButton.forEach {
            $0.setTitle(keywords[idx-1], for: .normal)
            $0.titleLabel?.font = UIFont.systemFont(ofSize: 13)
            $0.setTitleColor(UIColor(red: 124 / 255, green: 124 / 255, blue: 124 / 255, alpha: 1.0), for: .normal)
            
            $0.setTitleColor(.white, for: .selected)
            $0.backgroundColor = .white
            $0.tag = idx
            idx += 1
        }
    }
    
    func updateSelectedKeywordButton(){
        keywordButton.forEach {
            if selectedKeywordIdx == $0.tag {
                $0.isSelected = true
                $0.backgroundColor = .softGreen
            }
            else {
                $0.isSelected = false
                $0.backgroundColor = .white
            }
        }
    }
    func setData(){
        self.nickNameTextField.text = UserDefaults.standard.string(forKey: "UserProfileName")
        self.profileImageView.imageFromUrl(UserDefaults.standard.string(forKey: "UserProfileImgLink"), defaultImgPath: "sentenceThemeOImgCurator1010")
        self.layoutTableView.reloadData()
        selectedKeywordIdx = UserDefaults.standard.integer(forKey: "UserProfileKeyIdx")
        updateSelectedKeywordButton()
        partialGreenColor()
    }
    func showWarning(color: WarningColor, title: String){
        nickNameWarningLabel.text = title
        switch color{
            case .green:
                nickNameWarningLabel.textColor = .softGreen
                nickNameWarningImageView.image = UIImage(named:"mySettingsProfile4IcPossible")
            case .red:
                nickNameWarningLabel.textColor = .reddish
                nickNameWarningImageView.image = UIImage(named:"mySettingsProfile3IcWarning")
                nickNameTextField.becomeFirstResponder()
                nickNameTextField.setBorder(borderColor: .reddish, borderWidth: 1)
                
                
        }

        nickNameWarningLabel.alpha = 1
        nickNameWarningImageView.alpha = 1
    }
    func hideWarning(){
        nickNameWarningLabel.alpha = 0
        nickNameWarningImageView.alpha = 0
    }
        
    func callNickNameDuplicate(){
        if isValidNickNameInput() {
            if nickNameTextField.text! != UserDefaults.standard.string(forKey: "UserProfileName"){
                SignUpDuplicateService.shared.checkDuplicate(email: "-", name: nickNameTextField.text!, completion: {networkResult in
                    switch networkResult{
                        case .success(let data):
                            guard let duplicateData = data as? String else{
                                return
                            }
                            if duplicateData == "name"{
                                //이미 사용중인 닉네임.
                                
                                self.nickNameTextField.setBorder(borderColor: .reddish, borderWidth: 1)
                                self.showWarning(color: .red, title: "이미 사용 중인 닉네임이에요!")
                           
                            }
                            else if duplicateData == "available"{
                                //사용 가능한 닉네임입니다.
                               
                                self.nickNameTextField.setBorder(borderColor: .softGreen, borderWidth: 1)
                                self.showWarning(color : .green, title: "사용 가능한 닉네임이에요!")
                                if (ProfileEditIntroduceTVC.isIntroduceValid!){
                                    DispatchQueue.main.async{
                                        self.hideWarning()
                                        self.nickNameTextField.setBorder(borderColor: .veryLightPink, borderWidth: 1)
                                        self.callProfileEdit()
                                    }
                                }
                                else{
                                    self.layoutTableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
                                }
                                
                            }
                            
                        case .requestErr(let message):
                            guard let message = message as? String else { return }
                            self.showToast(text: message)
                            print(message)
                        case .pathErr:
                            print("pathErr")
                        case .serverErr:
                            print("serverErr")
                        case .networkFail:
                            print("networkFail")
                            
                    }
                })
            }
            //닉네임은 수정하지 않았을 때
            else{
                nickNameTextField.setBorder(borderColor: .veryLightPink, borderWidth: 1)
                hideWarning()
                self.layoutTableView.reloadData()
                if (ProfileEditIntroduceTVC.isIntroduceValid! &&  (self.introduce != UserDefaults.standard.string(forKey: "UserProfileIntroduce") || self.selectedKeywordIdx != UserDefaults.standard.integer(forKey:"UserProfileKeyIdx") || imageFlag)){
                    DispatchQueue.main.async{
                        self.callProfileEdit()
                    }
                }
            }
            
        }
        else {
            self.nickNameTextField.setBorder(borderColor: .reddish, borderWidth: 1)
            showWarning(color: .red,title:"닉네임을 입력해주세요!")

        }
        
    }
    func callProfileEdit(){
        layoutTableView.reloadData()
        var msg = ""
        if UserDefaults.standard.string(forKey: "UserProfileIntroduce") != self.introduce{
            msg = self.introduce
        }
        else{
            msg = UserDefaults.standard.string(forKey: "UserProfileIntroduce")!
        }
        MyProfileService.shared.uploadMy(img: profileImageView.image ?? UIImage(named:"warning")!, name: nickNameTextField.text!, introduce: msg , keywordIdx: selectedKeywordIdx, completion: { networkResult in
            switch networkResult{
                case .success(let data):
                    guard let profileData = data as? [MyProfileUploadData] else{
                        return
                    }
                    self.imageFlag = false
                    UserDefaults.standard.setValue(profileData[0].name, forKey: "UserProfileName")
                    UserDefaults.standard.setValue(profileData[0].img, forKey: "UserProfileImgLink")
                    UserDefaults.standard.setValue(profileData[0].introduce, forKey: "UserProfileIntroduce")
                    UserDefaults.standard.setValue(profileData[0].keywordIdx, forKey: "UserProfileKeyIdx")
                    self.showToast(text: "프로필이 수정되었어요!"){
                        self.navigationController?.popViewController(animated: true)
                    }
                    
                case .requestErr(let message):
                    guard let message = message as? String else { return }
                    self.showToast(text: message)
                    print(message)
                case .pathErr:
                    print("pathErr")
                case .serverErr:
                    print("serverErr")
                case .networkFail:
                    print("networkFail")
            }
        }
        )
    }
    func isValidNickNameInput() -> Bool {
        guard let text = nickNameTextField.text else {
            return false
        }
        if text.count > 0 && text.count < 7 {
            return true
        }
        return false
    }
    func partialGreenColor(){
        
        guard let text = self.nickNameTextField.text else {
            return
        }
        nickNameCountLabel.text = "\(text.count)/6"
        nickNameCountLabel.textColor = .softGreen
        if nickNameTextField.text == "" {
            nickNameCountLabel.textColor = .veryLightPink
        }
        let attributedString = NSMutableAttributedString(string: nickNameCountLabel.text!)
        attributedString.addAttribute(NSAttributedString.Key.foregroundColor,
                                      value: UIColor.veryLightPink,
                                      range: (text as NSString).range(of: "/6"))
        
        nickNameCountLabel.attributedText = attributedString
    }
    func setGesture(){
        profileImageView.isUserInteractionEnabled = true
        let tabGesture = UITapGestureRecognizer(target: self, action: #selector(touchUpProfileImageView))
        profileImageView.addGestureRecognizer(tabGesture)
    }
    
    
    //MARK: - IBAction
    @IBAction func touchKeywordButton(sender: UIButton) {
        self.view.endEditing(true)
        nickNameTextField.resignFirstResponder()
        selectedKeywordIdx = sender.tag
        updateSelectedKeywordButton()
    }
    
    @IBAction func touchUpBackButton(sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func touchUpCompleteButton(){
        self.view.endEditing(true)
        callNickNameDuplicate()
    }
}

//MARK: UITextFieldDelegate
extension ProfileEditVC: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        UIView.animate(withDuration:0.3){
            self.layoutTableView.setContentOffset(CGPoint(x: 0, y: textField.frame.minY - 70 ), animated: false)
        }
        textField.setBorder(borderColor: .softGreen, borderWidth: 1.0)
        nickNameCountLabel.alpha = 1
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        if isValidNickNameInput(){
            hideWarning()
            nickNameTextField.setBorder(borderColor: .veryLightPink, borderWidth: 1)
        }
        else{
            showWarning(color: .red, title: "닉네임을 입력해주세요!")
            nickNameTextField.setBorder(borderColor: .reddish, borderWidth: 1)
        }
        nickNameCountLabel.alpha = 0
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else {return false}
            
            // 중간에 추가되는 텍스트 막기
            if text.count >= 6 && range.length == 0 && range.location < 6 {
                return false
            }
            
            return true
    
        
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        return true
    }
}

// MARK: UITableViewDelegate
extension ProfileEditVC: UITableViewDelegate {
    
}
// MARK: UITableViewDataSource
extension ProfileEditVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isScrollSpended {
            return 5
        }
        else {
            return 5
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        if indexPath.row == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ProfileEditIntroduceTVC.identifier, for: indexPath) as? ProfileEditIntroduceTVC else {
                return UITableViewCell()
            }
            cell.selectedTextFieldDelegate = { [weak self] in
                self?.isScrollSpended = true
                self?.layoutTableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
            }
            cell.unSelectedTextfieldDelegate = { [weak self] in
                self?.isScrollSpended = false
            }
            cell.introduceDelegate = { text in
                self.introduce = text
            }
  
            return cell
        }
        else {
            return UITableViewCell()
        }
        
    }
}

// MARK: UIImagePickerControllerDelegate, UINavigationControllerDelegate
extension ProfileEditVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let originalImage: UIImage = info[.originalImage] as? UIImage {
            self.profileImageView.image = originalImage
            imageFlag = true
        }
        
        self.dismiss(animated: true, completion: nil)
    }
}

enum WarningColor{
    case green,red
}

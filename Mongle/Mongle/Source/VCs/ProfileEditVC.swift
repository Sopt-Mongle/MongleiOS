//
//  ProfileEditVC.swift
//  Mongle
//
//  Created by 이주혁 on 2020/07/14.
//  Copyright © 2020 이주혁. All rights reserved.
//

import UIKit

class ProfileEditVC: UIViewController {
    
    // MARK:- IBOutlet
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
    
    
    // MARK:- UIComponent
    lazy var imagePickerController = UIImagePickerController().then {
        $0.sourceType = .photoLibrary
        $0.allowsEditing = true
        $0.delegate = self
    }
    
    lazy var nickNameWarningStackView = UIStackView()
    lazy var introduceWarningStackView = UIStackView()
    
    // MARK: Property
    var keywords: [String] = ["감성자극", "동기부여", "자기계발", "깊은생각", "독서기록", "일상문장"]
    var selectedKeywordIdx: Int = 0
    var isScrollSpended: Bool = false
    
    // MARK:- Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setLayout()
        
        setKeywordButton()
        updateSelectedKeywordButton()
        setGesture()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        registerForKeyboardNotifications()
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
    
    // MARK:- @objc Method
    @objc func keyboardWillShow(_ notification: NSNotification) {
        
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey]
            as? NSValue)?.cgRectValue {
            self.bottomBlurImageBottomConstraint.constant = -keyboardSize.height + 20
            
            UIView.animate(withDuration: 0.3, animations: {
                self.view.layoutIfNeeded()
            })
            
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
    }
    @objc func touchUpProfoleImageView(){
        self.present(self.imagePickerController, animated: true, completion: nil)
    }
    
    
    // MARK: Custom Method
    func setLayout(){
        keywordBackgroundView.backgroundColor = UIColor(red: 232 / 255, green: 232 / 255, blue: 232 / 255, alpha: 1.0)
        profileImageView.makeRounded(cornerRadius: profileImageView.frame.width / 2)
        cameraButton.makeRounded(cornerRadius: cameraButton.frame.width / 2)
        
        nickNameTextField.makeRounded(cornerRadius: 10)
        nickNameTextField.setBorder(borderColor: .veryLightPinkFive, borderWidth: 1)
        
        
        nickNameTextField.addLeftPadding(left: 15)
//        introduceTextField.addLeftPadding(left: 15)
        
        completeButton.makeRounded(cornerRadius: 28)
//        nickNameTextField.textRect(forBounds: CGRect(x: 0, y: 0, width: 20, height: 10))
    }
    
    func setKeywordButton(){
        var idx: Int = 0
        keywordButton.forEach {
            $0.setTitle(keywords[idx], for: .normal)
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
    func testValidInput(){
        keywordLabelTopConstraint.constant = 59
        if isValidNickNameInput() {
            nickNameWarningStackView.removeFromSuperview()
            nickNameTextField.setBorder(borderColor: .veryLightPinkFive, borderWidth: 1)
            nickNameWarningStackView = makeWarningStackView(message: "사용 가능한 닉네임이에요!", isCorrect: true)
            
        }
        else {
            nickNameWarningStackView.removeFromSuperview()
            nickNameTextField.setBorder(borderColor: .reddish, borderWidth: 1)
            self.nickNameWarningStackView = makeWarningStackView(message: "닉네임을 입력해주세요!", isCorrect: false)
        }
        self.view.addSubview(nickNameWarningStackView)
        
        nickNameWarningStackView.snp.makeConstraints {
            $0.top.equalTo(nickNameTextField.snp.bottom).offset(9)
            $0.leading.equalToSuperview().offset(16)
        }
    }
    
    func isValidNickNameInput() -> Bool {
        guard let text = nickNameTextField.text else {
            return false
        }
        if text.count > 0 && text.count < 6 {
            return true
        }
        return false
    }
    
    func setGesture(){
        profileImageView.isUserInteractionEnabled = true
        let tabGesture = UITapGestureRecognizer(target: self, action: #selector(touchUpProfoleImageView))
        profileImageView.addGestureRecognizer(tabGesture)
    }

    func makeWarningStackView(message: String, isCorrect: Bool) -> UIStackView{

        var imageStr: String = ""
        var stateColor: UIColor?
        
        if isCorrect {
            imageStr = "mySettingsProfileNamePossibleIcPossible"
            stateColor = .softGreen
        }
        else {
            imageStr = "warning"
            stateColor = .reddish
        }
        
        let label = UILabel().then {
            $0.text = message
            $0.textColor = stateColor
            $0.font = UIFont.systemFont(ofSize: 13)
            $0.sizeToFit()
        }
        
        let imageView = UIImageView().then {
            $0.frame = CGRect(x: 0, y: 0, width: 15, height: 15)
            $0.image = UIImage(named: imageStr)
        }
        
        imageView.snp.makeConstraints {
            $0.width.height.equalTo(15)
        }
        
        
        let stackView = UIStackView().then {
            $0.spacing = 8
            $0.distribution = .fill
            $0.axis = .horizontal
            $0.addArrangedSubview(imageView)
            $0.addArrangedSubview(label)
        }
        
        return stackView
    }
    
    
    @IBAction func touchKeywordButton(sender: UIButton) {
        selectedKeywordIdx = sender.tag
        updateSelectedKeywordButton()
    }
    
    @IBAction func touchUpDismissButton(sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func touchUpCompleteButton(){
        testValidInput()
        layoutTableView.reloadData()
    }
}

//MARK: UITextFieldDelegate
extension ProfileEditVC: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        layoutTableView.setContentOffset(CGPoint(x: 0, y: textField.frame.minY - 30), animated: true)
        textField.setBorder(borderColor: .softGreen, borderWidth: 1.0)
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.setBorder(borderColor: .veryLightPink, borderWidth: 1.0)
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
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
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
        }
        
        self.dismiss(animated: true, completion: nil)
    }
}
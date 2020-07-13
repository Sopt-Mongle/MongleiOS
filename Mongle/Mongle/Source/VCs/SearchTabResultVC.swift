//
//  SearchTabResultVC.swift
//  Mongle
//
//  Created by 이예슬 on 7/8/20.
//  Copyright © 2020 이주혁. All rights reserved.
//

import UIKit

class SearchTabResultVC: UIViewController {
    
    let menuItem = ["테마","문장","큐레이터"]
    var pageInstance : SearchResultPageVC?
    var observingList: [NSKeyValueObservation] = []
    var underBarConstraintList: [NSLayoutConstraint] = []
    var searchKeyword:String = ""
    //MARK:- IBOutlet
    @IBOutlet weak var tabBarCV: UICollectionView!
    @IBOutlet weak var underBarView: UIView!
    @IBOutlet weak var searchTextField: UITextField!
    
    @IBAction func touchUpSearch(_ sender: Any) {
        
    }
    @IBAction func touchUpBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBarCV.delegate = self
        tabBarCV.dataSource = self
        
        searchTextField.text = searchKeyword
        underBarView.backgroundColor = .softGreen
        underBarView.translatesAutoresizingMaskIntoConstraints = false
        let constraintHeight = underBarView.heightAnchor.constraint(equalToConstant: 2.0)
        let constraintTop = underBarView.topAnchor.constraint(equalTo: tabBarCV.bottomAnchor)
        let constraintWidth = underBarView.widthAnchor.constraint(equalToConstant: tabBarCV.frame.width / CGFloat(menuItem.count))
        
        NSLayoutConstraint.activate([constraintHeight, constraintTop,constraintWidth])
        
        collectionView(tabBarCV, didSelectItemAt: IndexPath(item: 0, section: 0))
        tabBarCV.selectItem(at: IndexPath(item: 0, section: 0),
                            animated: false,
                            scrollPosition: .bottom)
        print(#function)
        print(searchKeyword)
        // Do any additional setup after loading the view.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    override func viewWillDisappear(_ animated: Bool) {
        observingList.forEach { $0.invalidate() }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "pageSegue" {
            pageInstance = segue.destination as? SearchResultPageVC
            pageInstance?.searchKey = self.searchKeyword
            let ob = pageInstance?
                .keyValue
                .observe(\.curPresentViewIndex,
                         options: [.new, .old]) {
                            [weak self] (changeObject, value) in
                            
                            self?.tabBarCV.selectItem(at: IndexPath(item: changeObject.curPresentViewIndex,
                                                                                section: 0),animated: false,scrollPosition: .bottom)
                            
                            if (changeObject.curPresentViewIndex == 0){
                                UIView.animate(withDuration: 0.3){
                                    self!.underBarView.transform = CGAffineTransform(translationX:0 ,y: 0)
                                }
                            }
                            else if(changeObject.curPresentViewIndex == 1){
                                UIView.animate(withDuration: 0.3){
                                    self!.underBarView.transform = CGAffineTransform(translationX:(self?.tabBarCV.frame.width)! / CGFloat((self?.menuItem.count)!),y: 0)
                                }
                            }
                            else {
                                UIView.animate(withDuration: 0.3){
                                    self!.underBarView.transform = CGAffineTransform(translationX:(self?.tabBarCV.frame.width)! / CGFloat((self?.menuItem.count)!) * 2 ,y: 0)
                                }
                            }
                            
                            
                            print("kvo test")
                            
            }
            
            observingList.append(ob!)
            //pageInstance?.pageControlDelegate = self
        }
    }


}
extension SearchTabResultVC: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let item = indexPath.item
        
        guard let pageInstance = self.pageInstance else {
            return
        }
        print("item : \(item)")
//        pageInstance.searchKey = searchKeyword ?? "실ㄹㄹㄹㄹㄹㄹㄹㄹㄹ패"
        if item - pageInstance.keyValue.curPresentViewIndex > 0{
            pageInstance.setViewControllers([pageInstance.vcArr![item]], direction: .forward, animated: true, completion: nil)
            pageInstance.keyValue.curPresentViewIndex = item
        }
        else{
            pageInstance.setViewControllers([pageInstance.vcArr![item]], direction: .reverse, animated: true, completion: nil)
            pageInstance.keyValue.curPresentViewIndex = item
        }
    }
}

extension SearchTabResultVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return menuItem.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchResultMenuCVC.identifier, for: indexPath) as? SearchResultMenuCVC
            else {
                return UICollectionViewCell()
        }
        cell.menuLabel.text = menuItem[indexPath.row]
        
        
        return cell
    }
}

extension SearchTabResultVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width / CGFloat(menuItem.count), height: collectionView.bounds.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    //    UIEdgeInset
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}

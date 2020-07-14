//
//  SearchResultSentenceVC.swift
//  Mongle
//
//  Created by 이예슬 on 7/8/20.
//  Copyright © 2020 이주혁. All rights reserved.
//

import UIKit

class CuratorTabInfoSentenceVC: UIViewController {
    var searchKey:String = "봄"
    @IBOutlet weak var sentenceTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        sentenceTableView.delegate = self
        sentenceTableView.dataSource = self
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

}
extension CuratorTabInfoSentenceVC: UITableViewDelegate{

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
extension CuratorTabInfoSentenceVC: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "searchResultSentenceTVC", for: indexPath) as? SearchResultSentenceTVC else{
            return UITableViewCell()
        }
        let text = cell.sentenceLabel.text
        
        
        let attributedString = NSMutableAttributedString(string: cell.sentenceLabel.text!)
        attributedString.addAttribute(NSAttributedString.Key.foregroundColor,
                                      value: UIColor.softGreen,
                                      range: (text as! NSString).range(of: searchKey))
        cell.sentenceLabel.attributedText = attributedString
        
        return cell
    }
    
    
    
}


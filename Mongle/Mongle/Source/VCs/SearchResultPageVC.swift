//
//  SearchResultPageVC.swift
//  Mongle
//
//  Created by 이예슬 on 7/8/20.
//  Copyright © 2020 이주혁. All rights reserved.
//

import UIKit

@objc class KVOObject : NSObject {
    @objc dynamic var curPresentViewIndex: Int = 0
    
}

class SearchResultPageVC: UIPageViewController {
    
    var previousPage: UIViewController?
    var nextPage: UIViewController?
    var realNextPage: UIViewController?
    let identifiers: NSArray = ["SearchResultThemeVC", "SearchResultSentenceVC","SearchResultCuratorVC"]
    var vcArr: [UIViewController]?
    var keyValue = KVOObject()
    var searchKey : String = ""
//    @objc dynamic var curPresentViewIndex: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        self.dataSource = self
        vcArr = identifiers.compactMap {
            let vc = self.storyboard?.instantiateViewController(identifier: $0 as! String)
            return vc
        }
        if let firstVC = vcArr?.first {
            setViewControllers([firstVC], direction: .forward, animated: true, completion: nil)
        }
        // Do any additional setup after loading the view.
    }
    
    // 스크롤 방식 변경, inspector Builder에서 변경할 수도 있지만 커스텀 으로 생성하기 때문에 이런식으로 설정
    required init?(coder: NSCoder) {
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
    }
}

extension SearchResultPageVC : UIPageViewControllerDelegate {
    //이부분만
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        //print(pageViewController.viewControllers!.first!.view.tag)
        //print(pageViewController.presentingViewController)
        //print(previousViewControllers)
        if completed {
            previousPage = previousViewControllers[0]
            realNextPage = nextPage
            print(realNextPage)
            if realNextPage is Mongle.SearchResultThemeVC {
                self.keyValue.curPresentViewIndex = 0
            }
            else if realNextPage is Mongle.SearchResultSentenceVC{
                self.keyValue.curPresentViewIndex = 1
            }
            else{
                self.keyValue.curPresentViewIndex = 2
            }
        }
        
        
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, willTransitionTo pendingViewControllers: [UIViewController]) {
        nextPage = pendingViewControllers[0]
    }
}

extension SearchResultPageVC: UIPageViewControllerDataSource {
    // 이 함수가 뭔지 살짝 이해 안됨
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        guard let viewControllerIndex = vcArr?.firstIndex(of: viewController) else {
            return nil
        }
        
        let previousIndex = viewControllerIndex - 1
        //infinite 아니고 끝에선 튕기게
        if previousIndex < 0 {
            return nil
        }
        else {
            return vcArr![previousIndex]
        }
    }
    // KVO
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        guard let viewControllerIndex = vcArr?.firstIndex(of: viewController) else {
            return nil
        }

        let nextIndex = viewControllerIndex + 1
        if nextIndex >= vcArr!.count {
            return nil
        } else {
            return vcArr![nextIndex]
        }
    }

}

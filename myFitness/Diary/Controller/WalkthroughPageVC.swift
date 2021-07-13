//
//  WalkthroughPageVC.swift
//  myFitness
//
//  Created by 楊振東 on 2021/7/13.
//

import UIKit

protocol  WalkthroughPageVCDelegate: AnyObject {
    func didUpdatePageIndex(currentIndex: Int)
}

class WalkthroughPageVC: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    var pageHeadings = ["建立自己的健身菜單", "還能當作日誌, 紀錄健身心得", "開始自己的訓練計畫"]
    var pageImages = ["onboarding-1", "onboarding-2", "onboarding-3"]
    var pageSubHeadings = ["輸入主題,內容,即可快速建立",
                       "加上心情圖案,讓日誌更加豐富",
                       "放棄可以找到一萬個理由，堅持只需一個信念！"]

    var currentIndex = 0
    weak var walkthroughDelegate: WalkthroughPageVCDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()

       dataSource = self
        delegate = self
        
        if let startingViewController = contentViewController(at: 0) {
            setViewControllers([startingViewController], direction: .forward, animated: true, completion: nil)
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if completed {
            if let contentViewController = pageViewController.viewControllers?.first as? WalkthroughContentVC {
                
                currentIndex = contentViewController.index
                
                walkthroughDelegate?.didUpdatePageIndex(currentIndex: contentViewController.index)
            }
        
        }
    }
    


    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        var index = (viewController as! WalkthroughContentVC).index
        index -= 1
        
        return contentViewController(at: index)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        var index = (viewController as! WalkthroughContentVC).index
        index += 1
        
        return contentViewController(at: index)
    }
    
    func contentViewController(at index: Int) -> WalkthroughContentVC? {
        if index < 0 || index >= pageHeadings.count {
            return nil
        }
        
        // Create a new view controller and pass suitable data.
        let storyboard = UIStoryboard(name: "Onboarding", bundle: nil)
        if let pageContentVC = storyboard.instantiateViewController(withIdentifier: "WalkthroughContentVC") as? WalkthroughContentVC {
            
            pageContentVC.imageFile = pageImages[index]
            pageContentVC.heading = pageHeadings[index]
            pageContentVC.subHeading = pageSubHeadings[index]
            pageContentVC.index = index
            
            return pageContentVC
        }
        
        return nil
    }
    
    func forwardPage() {
        currentIndex += 1
        if let nextVC = contentViewController(at: currentIndex) {
            setViewControllers([nextVC], direction: .forward, animated: true, completion: nil)
        }
    }

}

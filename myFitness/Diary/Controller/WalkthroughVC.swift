//
//  WalkthroughVC.swift
//  myFitness
//
//  Created by 楊振東 on 2021/7/13.
//

import UIKit

class WalkthroughVC: UIViewController ,WalkthroughPageVCDelegate{
    @IBOutlet var pageControl: UIPageControl!
    @IBOutlet var nextButton: UIButton! {
        didSet {
            nextButton.layer.cornerRadius = 25.0
            nextButton.layer.masksToBounds = true
        }
    }
    @IBOutlet var skipButton: UIButton!
    
    var walkthroughPageVC: WalkthroughPageVC?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func skipBtnTapped(sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func nextButtonTapped(sender: UIButton) {
        
        if let index = walkthroughPageVC?.currentIndex {
            switch index {
            case 0...1:
                walkthroughPageVC?.forwardPage()
                
            case 2:
                UserDefaults.standard.set(true, forKey: "hasViewedWalkthrough")
                dismiss(animated: true, completion: nil)
                
            default: break
                
            }
        }
        
        updateUI()
    }
    
    func updateUI() {

        if let index = walkthroughPageVC?.currentIndex {
            switch index {
            case 0...1:
                nextButton.setTitle("下一步", for: .normal)
                skipButton.isHidden = false
            case 2:
                nextButton.setTitle("開始", for: .normal)
                skipButton.isHidden = true
            default: break
            }
            
            pageControl.currentPage = index
        }
        
    }
    
    func didUpdatePageIndex(currentIndex: Int) {
        updateUI()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination
        if let pageViewController = destination as? WalkthroughPageVC {
            walkthroughPageVC = pageViewController
            walkthroughPageVC?.walkthroughDelegate = self
        }
    }

}

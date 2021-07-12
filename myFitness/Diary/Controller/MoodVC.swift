//
//  MoodVC.swift
//  myFitness
//
//  Created by 楊振東 on 2021/7/11.
//

import UIKit

class MoodVC: UIViewController {
    @IBOutlet var moodButtons: [UIButton]!
    @IBOutlet var backgroundImageView: UIImageView!
    @IBOutlet var closeBtn: UIButton!
    var diary = Diary()

    override func viewDidLoad() {
        super.viewDidLoad()

        backgroundImageView.image = UIImage(named: diary.image)
        
        //模糊
        let blurEffect = UIBlurEffect(style: .dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        backgroundImageView.addSubview(blurEffectView)
        
        let moveRightTransform  = CGAffineTransform.init(translationX: 600, y: 0)
        let scaleUpTransform = CGAffineTransform.init(scaleX: 5.0, y: 5.0)
        let moveScaleTransform = scaleUpTransform.concatenating(moveRightTransform)
        
        for moodBtn in moodButtons {
            moodBtn.transform = moveScaleTransform
            moodBtn.alpha = 0
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        for index in 0...4 {
            UIView.animate(withDuration: 0.4, delay: (0.1 + 0.05 * Double(index)), options: [], animations: {
                self.moodButtons[index].alpha = 1.0
                self.moodButtons[index].transform = .identity
            }, completion: nil)
        }
        UIView.animate(withDuration: 0.4, delay: 0.1, options: [], animations: {
            self.closeBtn.transform = .identity
        }, completion: nil)
        
    }
    



}

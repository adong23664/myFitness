//
//  LegVC.swift
//  myFitness
//
//  Created by 楊振東 on 2021/7/7.
//

import UIKit

class LegVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    let legNames = ["腿部伸展","腿推","坐式腿彎舉","屈膝後擡腿","啞鈴跨步蹲舉","哈克深蹲"]
    let legImages = ["cat0","cat1","cat2","cat3","cat4","cat9"]
    
    let legVideos = ["swZQC689o9U", "DA4Rp5Xi2iQ", "mfnlZMUkK6k", "oluUU-1QIX8", "q2OBTyitMAU", "qGo1gLC2-iQ"]
    let legSteps = ["緩慢往上伸直雙腳,不要猛拉.維持此姿勢片刻,緩慢將雙腳放下至初始位置","1.坐在器械腿舉架的坐板上，背部緊貼靠板，雙腳踩在腳踏版上\n2. 臀腿發力，向前蹬板至兩腿微彎，將兩邊安全桿往外推，繼續動作置腿接近伸直，感受目標肌群的收縮\n3. 緩慢還原至膝關節呈現90度左右為初始位置，重複臀腿發力，完成目標次數為一組完整的訓練\n4.完成一組將兩邊安全桿往內拉，緩慢放置腳踏板即可。","坐在訓練器上，調教椅子和手柄高度，貼緊椅背，小腿放在槓護墊上，然後選擇適合自己的訓練重量。呼氣，雙腿向後屈曲，膝關節彎曲至90度，停頓1秒。吸氣，慢慢回到開始動作，保持膝蓋輕微彎曲。","1.雙手與雙膝著地，且雙手張開與肩同寬撐在地上。雙膝打開與臀部同寬，彎曲成90度。\n2. 收緊核心肌群，單腿在身體後方完全伸直，抬到臀部高度，並用你的腹肌來維持平衡。將腿放下，回到起始位置。","1.以中握握住一對啞鈴，使掌心相對。抬頭挺胸站直，雙腳打開與肩同寬，手臂完全伸直並擺在身體兩側。\n2. 挺起胸部，一隻腳朝前方跨出一大步，使後腳膝蓋向下接近地面，同時盡量保持前腳小腿打直。用前腳將身體推回到起始位置。","1.腳尖和膝蓋的朝向要一致\n2.腳後跟始終踩在踏板上不要離開\n3.蹬起時腳後跟和腳尖要同時發力\n4.膝關節不要鎖死，整個動作過程中注意將壓力集中在股四頭肌上\n5.臀部不要向後傾斜也不要離開墊子\n6.整個動作過程中，下背部緊靠在墊子上對抗墊子發力，可以更好的刺激股四頭肌\n7.頭部不要離開靠墊"]
    let legMainImages = ["腿部伸展","腿推","坐式腿彎舉","屈膝後擡腿","啞鈴跨步蹲舉","哈克深蹲"]

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.tintColor = .white

        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return legNames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "legcell",for: indexPath) as! LegTableViewCell
        cell.legNameLabel.text = legNames[indexPath.row]
        cell.legImageView.image = UIImage(named: legImages[indexPath.row])
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showLegDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let destinationController = segue.destination as! LegDetailVC
                destinationController.legVideoCode = legVideos[indexPath.row]
                destinationController.legstep = legSteps[indexPath.row]
                destinationController.legMainImageName = legMainImages[indexPath.row]
            }
        }
    }
}

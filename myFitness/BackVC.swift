//
//  BackVC.swift
//  myFitness
//
//  Created by 楊振東 on 2021/7/6.
//

import UIKit

class BackVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var tableView: UITableView!
    let backNames = ["引體向上","高拉力","坐式划船","單臂啞鈴划船","槓鈴聳肩","啞鈴聳肩"]
    let backImages = ["cat0","cat1","cat2","cat3","cat4","cat9"]
    
    let backVideos = ["KPy_MXU2xC4","FoCBWMB11dM","moX5RMa8l64","mwyC_CLTHwE","Dz6D4j4RYho","6OL0Qi0pioA"]
    let backMainImages = ["引體向上","高拉力","坐式划船","單臂啞鈴划船","槓鈴聳肩","啞鈴聳肩"]
    let backSteps = ["1. 肩胛骨後收，雙手實握於槓上\n2. 收緊腹肌、挺胸\n3. 背肌發力，吐氣上\n4. 背肌控制，吸氣下放","1.確保寬手柄已連接。調整膝蓋支撐，鎖定腿部姿勢。\n2.緊握橫桿，手掌向前（上手握拳）。它們之間的距離應該比肩寬。\n3.稍微向後傾斜（大約 20 度），挺胸，保持軀幹緊繃。\n4.將槓鈴向下拉至上胸部，將肩胛骨擠壓在一起。確保你的肘部向下移動，而不是向後。\n5.慢慢地將重心放回起始位置，充分伸展手臂，伸展臀部。確保您控制機器，機器不會控制或拉動您。","1. 坐在低拉滑輪機前，雙手張開比肩膀略寬，握住直桿握把。利用雙腿將身體往後推，讓手臂完全伸直，並支撐槓片的重量。\n2. 胸部持續面向前方，肩膀向下，背部拱起，將握把拉向腰部。讓啞鈴回到起始位置。","1.一手握緊一個啞鈴，俯身，將另一隻手支撐在長凳的一端，支撐手同側的腿部膝蓋和小腿放在長凳的另一端。\n2.調整好另一條腿的位置，膝蓋保持微屈以維持平衡，抬頭挺胸並伸展背部，核心收緊。\n3.有控制的將啞鈴向地面下放，直到同側背部肌肉充分的拉伸，然後向上收縮後背，同時手臂向上提拉啞鈴，直到將啞鈴提拉到髖關節位置，充分擠壓背中部，暫停片刻，再進行下一次反覆。\n4. 啞鈴向下放的階段3-4秒，向上拉的階段1-2秒，在動作最末端頂峰收縮1-2秒。\n5.啞鈴向下放的階段吸氣，向上拉的階段吐氣。","1.雙手張開比肩膀略寬，雙臂完全伸直，將槓鈴高舉過頭。\n2. 肩膀盡量聳高，將槓鈴朝天花板的方向抬起。舉至最高點後停頓，接著慢慢回到起始位置。","1.站直，膝蓋微彎，雙腳與肩同寬。\n2.手臂伸直，做聳肩動作，當肩膀提到高點時，停留三秒。\n3.放鬆肩膀回到開始位置後重新開始。\n4.在做聳肩時，保持肩膀直上直下，不要往後旋轉。"]

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.tintColor = .white

        
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        backNames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "backcell",for: indexPath) as! BackTableViewCell
        cell.backNameLabel.text = backNames[indexPath.row]
        cell.backImageView.image = UIImage(named: backImages[indexPath.row])
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showBackDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let destinationController = segue.destination as! BackDetailVC
                destinationController.backVideoCode = backVideos[indexPath.row]
                destinationController.backstep = backSteps[indexPath.row]
                destinationController.backMainImageName = backMainImages[indexPath.row]
            }
        }
    }
}

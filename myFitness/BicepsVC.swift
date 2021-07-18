//
//  BicepsVC.swift
//  myFitness
//
//  Created by 楊振東 on 2021/7/7.
//

import UIKit

class BicepsVC: UIViewController ,UITableViewDelegate, UITableViewDataSource{
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var bicepses : [PartMuscle] = [
        PartMuscle(name: "啞鈴彎舉", image: "啞鈴彎舉", video: "sAq_ocpRh_I", step: "1.起身站立，雙腳打開與髖部同寬，膝蓋放鬆微彎，雙臂置於身體兩側，雙手各握住一個啞鈴。肩膀往後收並往下放，收緊腹肌和骨盆，準備開始。\n2. 手肘緊靠身體兩側，位置剛好落在胸腔前側，掌心翻轉向上，將啞鈴向肩膀彎舉，舉到最高點時，把二頭肌完全收緊。\n3. 往反方向運動，回到起始姿勢，這樣算完成 1 次。\n4. 重複同樣動作，確保不是透過擺動或晃動身體來出力產生動能。", mainImage: "啞鈴彎舉"),
        PartMuscle(name: "屈臂", image: "屈臂", video: "vngli9UR6Hw", step: "坐在彎舉椅上，身體前傾，兩臂放置在斜板上，卡住腋窩，手心向上，反握槓鈴(啞鈴)，兩臂以肘關節為軸心將槓鈴往鎖骨方向舉起，至頂峰時稍暫停，再慢慢將槓鈴下放至起始位置。", mainImage: "屈臂"),
        PartMuscle(name: "垂式彎舉", image: "垂式彎舉", video: "zC3nLlEvin4", step: "1. 以中握握住一組啞鈴，使掌心相對，雙腳打開與肩同寬，抬頭挺胸站立。\n 2. 收緊核心肌群，將啞鈴朝上彎舉至肩膀的高度，同時保持掌心相對。在最高點停頓一下並收縮二頭肌，然後將啞鈴放下，回到起始位置。", mainImage: "垂式彎舉"),
        PartMuscle(name: "槓鈴彎舉", image: "槓鈴彎舉", video: "XZ4uBdekQqA", step: "1. 反握槓鈴，並讓槓鈴隨著完全伸直的手臂垂下，掌心朝前。\n2. 上臂保持不動，彎曲手肘，並將槓鈴盡量朝肩膀的方向彎舉。停頓一下，然後將槓鈴放下至起始位置。", mainImage: "槓鈴彎舉"),
        PartMuscle(name: "滑輪彎舉", image: "滑輪彎舉", video: "NFzTWp2qpiE", step: "1. 將繩索握把固定於低拉滑輪機。呈站姿，站於槓片前約 45 公分處，雙手握住繩索握把兩端，掌心相對，手臂完全伸直。\n2. 雙手手肘貼近身體兩側，將手臂向上彎舉，直到屈肘成 90 度角。舉至最高點後停頓一秒，然後慢慢回到起始位置，讓雙臂能夠完全伸展。", mainImage: "滑輪彎舉"),
        PartMuscle(name: "滑輪側彎舉", image: "滑輪側彎舉", video: "ONzEBGwCAQU", step: "調整兩側滑輪至高於肩膀的高度，腳與肩同寬地站在中間，以手掌朝向天花板的方式抓住手柄，這時手臂應平行於地板，吐氣時，慢慢擠壓肱二頭肌，直到前臂快與肱二頭肌接觸，再慢慢將前臂移回起始位置。", mainImage: "滑輪側彎舉")
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.tintColor = .white

        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bicepses.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "bicepscell",for: indexPath) as! BicepsTableViewCell
        cell.bicepsNameLabel.text = bicepses[indexPath.row].name
        cell.bicepsImageView.image = UIImage(named: bicepses[indexPath.row].image)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false) //閃一下
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showBicepsDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let destinationController = segue.destination as! BicepsDetailVC
                destinationController.biceps = bicepses[indexPath.row]
            }
        }
    }

}

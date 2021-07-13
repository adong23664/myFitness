//
//  AllVC.swift
//  myFitness
//
//  Created by 楊振東 on 2021/7/7.
//

import UIKit

class ShoulderVC: UIViewController ,UITableViewDelegate, UITableViewDataSource{
    
    
    @IBOutlet weak var tableView: UITableView!
    let shoulderNames = ["坐姿槓鈴推舉","坐姿啞鈴推舉","站姿側舉","前平舉","蝴蝶式側平舉","坐姿啞鈴側平舉"]
    let shoulderImages = ["cat0","cat1","cat2","cat3","cat4","cat9"]
    
    let shoulderVideos = ["oBGeXxnigsQ","qEwKCR5JCog","3VcKaXpzqRo","nCDWoH5FYCA","QjPpLMiPioI","Z0HTsZEMedA"]
    let shoulderSteps = ["1.坐在重訓椅上，背部挺直作為支撐，雙手手掌朝下正握槓鈴，雙手打開比肩膀略寬。\n2. 緩慢地彎曲手臂，並將槓鈴放下至鎖骨位置，而手肘保持貼近身體兩側。\n3. 緊握槓鈴，將槓鈴推舉過頭，直到手肘完全伸直。","1.坐姿，雙腿分開雙腳踩地，下肢固定，挺胸收腹，雙手各握啞鈴置於肩部上方邊緣，掌心向前\n2. 保持身體穩定，三角肌發力，將啞鈴向上推起，至雙臂接近伸直狀態，注意啞鈴不要相碰\n3. 頂點稍停，收縮三角肌，然後主動控制速度慢慢還原","1. 雙手各持一隻啞鈴，身體直立。手臂在身體兩側自然下垂，掌心相對。這是動作的起始位置。\n2. 保持手臂伸直，肘部微曲，將啞鈴向身體兩側平舉，同時​​呼氣。上舉的過程中略微旋轉手腕，使手臂呈倒水姿勢。直至手臂與地面平行。\n3. 在頂端稍適停留，感受肩部的收縮，然後慢慢將啞鈴放回起始位置，同時吸氣。\n4. 以上是一次完整動作，重複動作。","1. 雙腳與肩同寬採自然站姿\n2. 雙手握住啞鈴，手肘保持微彎且自然下垂\n3. 抬頭挺胸、繃緊核心、不要聳肩\n4. 將啞鈴上提至與肩膀相同高度即可\n5. 可雙手同時進行也可雙手交替進行","使用蝴蝶機訓練，每一個可以控制更長的節奏，盡可能做到頂峰收縮。根據訓練情況進行調整，可以使用手背去撐開蝴蝶機，對比手掌握著蝴蝶機會有不一樣的訓練刺激。","1.坐在凳子的一頭，雙膝併攏，雙手各握一隻啞鈴，軀幹向前俯，讓啞鈴在後腿處相遇，轉動手腕使手掌相對\n2.保持身體穩定，然後從身體兩側舉起啞鈴，同時轉動手腕，讓大拇指比你的小拇指稍低,手臂要略微彎曲，讓啞鈴舉到略高於頭的位置\n3.繼續併攏雙膝，將啞鈴慢慢放下，使其在小腿後面相遇，整個過程中都要用力"]
    let shoulderMainImages = ["坐姿槓鈴推舉","坐姿啞鈴推舉","站姿側舉","前平舉","蝴蝶式側平舉","坐姿啞鈴側平舉"]
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.tintColor = .white

        
    }
    

  

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shoulderNames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "shouldercell",for: indexPath) as! ShoulderTableViewCell
        cell.shoulderNameLabel.text = shoulderNames[indexPath.row]
        cell.shoulderImageView.image = UIImage(named: shoulderImages[indexPath.row])
        return cell
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showShoulderDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let destinationController = segue.destination as! ShoulderDetailVC
                destinationController.shoulderVideoCode = shoulderVideos[indexPath.row]
                destinationController.shoulderstep = shoulderSteps[indexPath.row]
                destinationController.shoulderMainImageName = shoulderMainImages[indexPath.row]
            }
        }
    }
}

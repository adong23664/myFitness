//
//  ChestVC.swift
//  myFitness
//
//  Created by 楊振東 on 2021/7/7.
//

import UIKit

class ChestVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    let chestNames = ["仰臥推舉","上斜臥推","仰臥飛鳥","雙槓臂屈臂身","拉力器夾胸","俯臥撐"]
    let chestImages = ["cat0","cat1","cat2","cat3","cat4","cat9"]
    
    let chsetVideos = ["W8_ZwQrXYv8","L1zAuC8DNrk","ezoZUre13fQ","npjDE9tOdIM","vVnwLGs2IVY","ylQBeyOB18w"]
    let chestSteps = ["1.準備動作 躺平在臥推椅上，將你的手握住槓鈴以及夾緊肩胛，腳踩平在地面上。\n2.握住槓 選擇一個適合你的握距，僅握住槓鈴且維持手腕的直立，這邊文章後面會解釋手腕的部分。\n3.起槓 深呼一口氣將槓鈴起槓，槓鈴移動時將手肘鎖緊。\n4.下放槓鈴 把槓鈴降至你胸中線，手肘與身體的夾角約成75度，前臂維持直立。","1.將可調式重訓椅調為傾斜 30-45 度。仰躺在推舉椅上，將一對啞鈴握在肩膀的正上方，手臂完全伸直，雙手掌心相對。\n2.夾緊肩胛骨，胸部稍微挺起。將啞鈴放下至胸部兩側。停頓一下，然後將啞鈴舉回至起始位置。","1. 正握一對啞鈴，仰面躺在平坦的重訓椅上。雙臂朝身體外側伸直，直到與地面平行，將啞鈴則持於胸部的高度。\n2. 控制速度，將雙臂抬起，讓掌心相對，將啞鈴舉至胸部正上方。在動作的最高點停頓一下並夾緊胸肌。以劃圓弧方式慢慢放下啞鈴，使啞鈴遠離身體。啞鈴幾乎與胸部齊高時，將動作倒回，回到起始姿勢。","1. 握住雙槓練習器的握把，將身體撐起，直到手臂完全伸直，使身體能夠筆直地上下移動。膝蓋微彎。\n2. 手肘彎曲，將身體往下降，直到上臂與地面平行。俯身向前，直到胸部幾乎與地面平行。\n3. 運用胸部、肩膀與手臂的力量，將身體從最低點撐起，並撐回起始位置。","1.站立在龍門架的正中央，一隻腳略微向前跨出，身體向前傾，向兩側伸開雙臂，手臂要幾乎伸直\n2.身體前傾，肘部彎曲，雙手要環繞的向前動作，像在熊抱一個人一樣。整個動作過程中要注意胸肌的收縮\n3.當雙手在身體前方合攏時，不要停下繼續做，讓雙手交叉，同時用意念刻意緊縮一下胸肌。\n4.有控制的回到起始位置，同樣的不要完全放回原位，要在一個最有彈性的點停下來。","1.從高棒式開始，雙腳微微寬於臀部。\n2.肩膀位於手腕上方，以避免肩膀和肘關節的壓力。\n3.肋骨往內、核心用力、屁股收緊，身體維持一直線，以保護下背。\n4.身體往下時，手肘往外呈45度，視線看向雙手前方。\n5.接著將身體往上撐，保持原來的姿勢與直線。"]
    let chestMainImages = ["仰臥推舉","上斜臥推","仰臥飛鳥","雙槓臂屈臂身","拉力器夾胸","俯臥撐"]
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.tintColor = .white

    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chestNames.count
    }
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "chestcell",for: indexPath) as! ChestTableViewCell
        cell.chestNameLabel.text = chestNames[indexPath.row]
        cell.chestImageView.image = UIImage(named: chestImages[indexPath.row])
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showChestDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let destinationController = segue.destination as! ChestDetailVC
                destinationController.chestVideoCode = chsetVideos[indexPath.row]
                destinationController.cheststep = chestSteps[indexPath.row]
                destinationController.chestMainImageName = chestMainImages[indexPath.row]
            }
        }
    }
}


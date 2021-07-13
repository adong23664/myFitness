//
//  TricepsVC.swift
//  myFitness
//
//  Created by 楊振東 on 2021/7/7.
//

import UIKit

class TricepsVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    let tricepsNames = ["下壓","槓鈴曲臂伸","三頭肌掌體","坐姿頸後臂伸展","窄握三頭推舉","啞鈴三頭肌伸展"]
    let tricepsImages = ["cat0","cat1","cat2","cat3","cat4","cat9"]
    
    let tricepsVideos = ["vB5OHsJ3EME","d_KZxkY_0cM","wjUmnZH528Y","nRiJVZDpdL0","vEUyEOVn3yM","ItLKDvhO8RU"]
    let tricepsSteps = ["1. 將V型拉桿置於滑輪機的高處，面向滑輪機，雙手打開與肩同寬，掌心朝下握住拉桿。將手肘帶向身體兩側，讓前臂與地面平行。\n2. 收縮三頭肌，前臂向下伸直，稍微旋轉一下握把，讓指關節的低點朝向地板。當手臂完全伸直時，停頓一下，然後反向回到起始位置。","1.槓鈴窄握, 預備動作將槓鈴放置腿上,後仰躺於躺椅.\n2. 將手臂伸直,起點,終點位置於額頭上方.\n3.肩部稍微內收避免外擴.\n4.大臂不動前臂動,反覆操作.","讓身體向地面下降接著靠三頭肌的力量將身體往上撐起。當我們肘關節彎曲大約達到90度左右，三頭肌以及其餘的肌肉就會用力的收縮，然而，這個動作最困難的部分就在於動作的頂點而非底部，所以，身體不需要下降到太低點，反而要在動作上升時將手臂伸直。","首先，我們可採用坐姿用雙手或單手握住啞鈴，並將啞鈴高舉過頭接著下降於頭部後方；這個動作必需要鎖定肘關節的位置只靠前臂上下伸展動作。","1. 掌心朝下正握 W 槓，雙手打開與肩同寬。仰躺在重訓椅上，將 W 槓舉至頭部正上方，手臂完全伸直。\n2. 上臂保持不動，彎曲手肘，將 W 槓放下至快要碰到額頭。停頓一下，然後收縮三頭肌，將 W 槓高舉過頭。\n3. 然後將 W 槓降下至胸部的位置。在此最低位置時停頓一下，然後將 W 槓推舉過頭，回到起始位置。","1. 雙手各持一個啞鈴，躺在健身椅上，雙臂朝胸部上方伸直。\n2. 彎曲手肘並將啞鈴降下，直到啞鈴靠近肩膀正上方。上臂不應移動。停頓一下，然後夾緊三頭肌，手臂伸直，將啞鈴放回至起始位置。"]
    
    let tricepsMainImages = ["下壓","槓鈴曲臂伸","三頭肌掌體","坐姿頸後臂伸展","窄握三頭推舉","啞鈴三頭肌伸展"]

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.tintColor = .white

        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tricepsNames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tricepscell",for: indexPath) as! TricepsTableViewCell
        cell.tricepsNameLabel.text = tricepsNames[indexPath.row]
        cell.tricepsImageView.image = UIImage(named: tricepsImages[indexPath.row])
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showTricepsDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let destinationController = segue.destination as! TricepsDetailVC
                destinationController.tricepsVideoCode = tricepsVideos[indexPath.row]
                destinationController.tricepsstep = tricepsSteps[indexPath.row]
                destinationController.tricepsMainImageName = tricepsMainImages[indexPath.row]
            }
        }
    }
    



}

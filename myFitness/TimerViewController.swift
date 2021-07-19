//
//  TimerViewController.swift
//  myFitness
//
//  Created by 楊振東 on 2021/6/20.
//

import UIKit
import AVFoundation

class Timers {
    var mins: String
    var seconds: [String]
    init(mins:String, seconds:[String]) {
        self.seconds = seconds
        self.mins = mins
    }
}

class TimerViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var player: AVAudioPlayer?

    @IBOutlet weak var startStopButton: UIButton!
    @IBOutlet weak var resetButton: UIButton!
    @IBOutlet weak var setNumber: UILabel!
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var done: UIButton!
    var timer = Timer()
    var setNB = 0
    var count : Int = 0
    var rememberCount : Int = 0
    var timerCounting : Bool = false
    var timers = [Timers]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        pickerView.delegate = self
        pickerView.dataSource = self
        pickerView.setValue(UIColor.white, forKey: "textColor")
        timers.append(Timers(mins: "00", seconds: ["00","01","02","03","04","05","06","07","08","09","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29","30","31","32","33","34","35","36","37","38","39","40","41","42","43","44","45","46","47","48","49","50","51","52","53","54","55","56","57","58","59" ]))
        timers.append(Timers(mins: "01", seconds: ["00","01","02","03","04","05","06","07","08","09","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29","30","31","32","33","34","35","36","37","38","39","40","41","42","43","44","45","46","47","48","49","50","51","52","53","54","55","56","57","58","59" ]))
        timers.append(Timers(mins: "02", seconds: ["00","01","02","03","04","05","06","07","08","09","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29","30","31","32","33","34","35","36","37","38","39","40","41","42","43","44","45","46","47","48","49","50","51","52","53","54","55","56","57","58","59"]))
        timers.append(Timers(mins: "03", seconds: ["00","01","02","03","04","05","06","07","08","09","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29","30","31","32","33","34","35","36","37","38","39","40","41","42","43","44","45","46","47","48","49","50","51","52","53","54","55","56","57","58","59"]))
        timers.append(Timers(mins: "04", seconds: ["00","01","02","03","04","05","06","07","08","09","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29","30","31","32","33","34","35","36","37","38","39","40","41","42","43","44","45","46","47","48","49","50","51","52","53","54","55","56","57","58","59"]))
        timers.append(Timers(mins: "05", seconds: ["00","01","02","03","04","05","06","07","08","09","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29","30","31","32","33","34","35","36","37","38","39","40","41","42","43","44","45","46","47","48","49","50","51","52","53","54","55","56","57","58","59"]))
        
        startStopButton.setTitleColor(UIColor(red: 0.0/255.0, green: 179.0/255.0, blue: 115.0/255.0, alpha: 1.0), for: .normal)
        startStopButton.layer.borderWidth = 3
        startStopButton.layer.borderColor = UIColor(red: 0.0/255.0, green: 179.0/255.0, blue: 115.0/255.0, alpha: 1.0).cgColor
        resetButton.layer.borderWidth = 3
        resetButton.layer.borderColor = UIColor.systemBlue.cgColor
        
        setNumber.layer.borderWidth = 3
        setNumber.layer.borderColor = UIColor.white.cgColor
        setNumber.layer.shadowOffset = CGSize(width: 10, height: 10)
        setNumber.layer.shadowColor = UIColor.darkGray.cgColor
        setNumber.layer.shadowOpacity = 0.5
        
        
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {return 2}
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return timers.count
        } else {
            let selected = pickerView.selectedRow(inComponent: 0)
            return timers[selected].seconds.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0 {
            return timers[row].mins
        } else {
            let selected = pickerView.selectedRow(inComponent: 0)
            return timers[selected].seconds[row]
        }
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        pickerView.reloadComponent(1)
        let selectedMins = pickerView.selectedRow(inComponent: 0)
        let selectedSeconds = pickerView.selectedRow(inComponent: 1)
        let mins = timers[selectedMins].mins
        let seconds = timers[selectedMins].seconds[selectedSeconds]
        timerLabel.text = "\(mins):\(seconds)"
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 40
    }
    
    @IBAction func startStopTapped(_ sender: Any) {
        if (count == 0){
            timer.invalidate()
        } else {
                if (timerCounting) {
                    timerCounting = false
                    timer.invalidate()
                    startStopButton.setTitle("開始", for: .normal)
                    startStopButton.setTitleColor(UIColor(red: 0.0/255.0, green: 179.0/255.0, blue: 115.0/255.0, alpha: 1.0), for: .normal)
                    startStopButton.layer.borderWidth = 3
                    startStopButton.layer.borderColor = UIColor(red: 0.0/255.0, green: 179.0/255.0, blue: 115.0/255.0, alpha: 1.0).cgColor
                    self.done.isEnabled = true
                    self.pickerView.isHidden = false
                    
                } else {
                    timerCounting = true
                    startStopButton.setTitle("暫停", for: .normal)
                    startStopButton.layer.borderWidth = 3
                    startStopButton.layer.borderColor = UIColor.red.cgColor
                    startStopButton.setTitleColor(UIColor.red, for: .normal)
                    timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerCounter), userInfo: nil, repeats: true)
                    self.done.isEnabled = false
                    self.pickerView.isHidden = true
                }
           }
    }
    
    @IBAction func restetTapped(_ sender: Any) {
    let alert = UIAlertController(title: "重置? ", message: "記錄將會消失!!", preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "取消", style: .cancel, handler: { (_) in
    // do nothing
    }))
    alert.addAction(UIAlertAction(title: "確定", style: .destructive, handler: { (_) in
        self.setNB = 0
        self.setNumber.text = "第\(self.setNB)組"
        self.count = 0
        self.rememberCount = 0
        self.timer.invalidate()
        self.timerLabel.text = self.makeTimerString(minutes: 0, sconds: 0)
        self.timerCounting = false
        self.startStopButton.setTitle("開始", for: .normal)
        self.startStopButton.setTitleColor(UIColor(red: 0.0/255.0, green: 179.0/255.0, blue: 115.0/255.0, alpha: 1.0), for: .normal)
        self.startStopButton.layer.borderWidth = 3
        self.startStopButton.layer.borderColor = UIColor(red: 0.0/255.0, green: 179.0/255.0, blue: 115.0/255.0, alpha: 1.0).cgColor
        self.done.isEnabled = true
        self.pickerView.isHidden = false
    }))
        self.present(alert, animated: true, completion: nil)
    }

    @objc
    func timerCounter() {
        count -= 1
        let time = secondsToHoursMinutesSeconds(seconds: count)
        let timeString = makeTimerString(minutes: time.0, sconds: time.1)
        timerLabel.text = timeString
        if (count == 0){
            if let player = player, player.isPlaying{
                //stop playback
                player.stop()
            } else {
                //setup player and play
                let urlString = Bundle.main.path(forResource: "Ding", ofType: "mp3")
                do {
                    try AVAudioSession.sharedInstance().setMode(.default)
                    try AVAudioSession.sharedInstance().setActive(true, options: .notifyOthersOnDeactivation)
                    
                    guard let urlString = urlString else {
                        return
                    }
                    player = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: urlString))
                    guard let player = player else {
                        return
                    }
                    player.play()
                } catch  {
                    print("something went wrong")
                }
            }
            count = rememberCount
            let time = secondsToHoursMinutesSeconds(seconds: count)
            let timeString = makeTimerString(minutes: time.0, sconds: time.1)
            timerLabel.text = timeString
            setNB += 1
            setNumber.text = "第\(setNB)組"
            timer.invalidate()
        }
    }
    
    func secondsToHoursMinutesSeconds(seconds: Int) ->(Int, Int){
        return (((seconds % 3600) / 60) , ((seconds % 3600) % 60))
    }
    
    func makeTimerString(minutes: Int, sconds: Int)-> String {
        var timeString = ""
        timeString += String(format: "%02d", minutes)
        timeString += ":"
        timeString += String(format: "%02d", sconds)
        return timeString
    }
    
    
    @IBAction func done(_ sender: Any) {
        if timerLabel.text == "00:00" {
            done.isEnabled = true
            pickerView.isHidden = false
        } else {
            pickerView.reloadComponent(1)
            let selectedMins = pickerView.selectedRow(inComponent: 0)
            let selectedSeconds = pickerView.selectedRow(inComponent: 1)
            let mins = timers[selectedMins].mins
            let seconds = timers[selectedMins].seconds[selectedSeconds]
            count = (Int(mins)! * 60 ) + Int(seconds)!
            rememberCount = (Int(mins)! * 60 ) + Int(seconds)!
            let time = secondsToHoursMinutesSeconds(seconds: count)
            let timeString = makeTimerString(minutes: time.0, sconds: time.1)
            timerLabel.text = timeString
            self.timerCounting = false
            self.startStopButton.setTitle("開始", for: .normal)
            self.startStopButton.setTitleColor(UIColor(red: 0.0/255.0, green: 179.0/255.0, blue: 115.0/255.0, alpha: 1.0), for: .normal)
            self.startStopButton.layer.borderWidth = 3
            self.startStopButton.layer.borderColor = UIColor(red: 0.0/255.0, green: 179.0/255.0, blue: 115.0/255.0, alpha: 1.0).cgColor
            done.isEnabled = false
            pickerView.isHidden = true
        }
    }


}


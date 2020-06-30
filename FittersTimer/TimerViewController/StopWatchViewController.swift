////
////  StopWatchViewController.swift
////  FittersTimer
////
////  Created by PASSTECH on 19/04/2019.
////  Copyright © 2019 Taek. All rights reserved.
////
//
//import UIKit
//
//class StopWatchViewController: UIViewController {
//
//    let watch = StopWatch()
//
//    @IBOutlet weak var ResetBtn: UIButton!
//    @IBOutlet weak var StartBtn: UIButton!
//    @IBOutlet weak var TimeLabel: UILabel!
//    @IBOutlet weak var PreSecondLabel: UILabel!
//
//    private var timer = Timer()
//    private var isTimerRunning = false
//    private var counter = 0.00
//    private var recordList = [String]()
//
//    var startFlag = false
//    var resetFlag = false
//
//
//    @IBAction func ResetBtnTapped(_ sender: Any)
//    {
//        if resetFlag // reset 기능
//        {
//            print("ResetBtnTapped")
//            reset()
////            ResetBtn.titleLabel!.text = "Reset"
//        }
//        else // record 기능
//        {
//            print("RecordBtnTapped")
//            record()
////            ResetBtn.titleLabel!.text = "Rep"
//        }
//
//
//
//
//
////        watch.reset()
//    }
//    @IBAction func StartBtnTapped(_ sender: Any)
//    {
//        if startFlag // stop 기능
//        {
//            print("StopBtnTapped")
//            stop()
//            startFlag = false
//            resetFlag = true
//            StartBtn.setTitle("Start", for: .normal)
//            ResetBtn.setTitle("Reset", for: .normal)
////            StartBtn.titleLabel!.text = "Start"
////            ResetBtn.titleLabel!.text = "Reset"
//        }
//        else // start 기능
//        {
//            print("StartBtnTapped")
//            start()
//            startFlag = true
//            resetFlag = false
//            StartBtn.setTitle("Stop", for: .normal)
//            ResetBtn.setTitle("Rep", for: .normal)
////            StartBtn.titleLabel!.text = "Stop"
////            ResetBtn.titleLabel!.text = "Rep"
//        }
//
//
//
//
////        Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(updateElapsedTimeLabel(timer:)), userInfo: nil, repeats: true)
////        watch.start()
//    }
//
////    @objc func updateElapsedTimeLabel (timer: Timer)
////    {
////        if watch.isRunning
////        {
////            let minute = Int(watch.elapsdTime / 60)
////            let seconds = Int(watch.elapsdTime.truncatingRemainder(dividingBy: 60))
////            let preSeconds = Int((watch.elapsdTime * 100).truncatingRemainder(dividingBy: 100))
////            TimeLabel.text = String (format: "%02d:%02d", minute, seconds)
////            PreSecondLabel.text = String (format: "%02d", preSeconds)
////        }
////        else
////        {
////            timer.invalidate()
////        }
////    }
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        // Do any additional setup after loading the view.
//    }
//
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
//
//    func start()
//    {
//        if !isTimerRunning
//        {
//            timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(runTimer), userInfo: nil, repeats: true)
//            isTimerRunning = true
//        }
//    }
//
//    func stop()
//    {
//        isTimerRunning = false
//        timer.invalidate()
//    }
//
//    func reset()
//    {
//        timer.invalidate()
//        isTimerRunning = false
//        counter = 0.00
//
//        TimeLabel.text = "00:00"
//        PreSecondLabel.text = "00"
//    }
//
//    func record()
//    {
//        let flooredCounter = Int(floor(counter))
//        let hour = flooredCounter / 3600
//        let minute = (flooredCounter % 3600) / 60
//        var minuteString = "\(minute)"
//        if minute < 10
//        {
//            minuteString = "0\(minute)"
//        }
//
//        let second = (flooredCounter % 3600) % 60
//        var secondString = "\(second)"
//
//        if second < 10
//        {
//            secondString = "0\(second)"
//        }
//
//        let preSecond = String (format: "%.2f", counter).components(separatedBy: ".").last!
//
//        let record = "\(minuteString):\(secondString):\(preSecond)"
////        let record = "\(hour):\(minuteString):\(secondString):\(preSecond)"
//        recordList.append(record)
//
//        print("\(recordList.count)th record: \(record)")
//    }
//
//    @objc func runTimer()
//    {
//        counter += 0.01
//
//        let flooredCounter = Int(floor(counter))
//        let hour = flooredCounter / 3600
//        let minute = (flooredCounter % 3600) / 60
//        var minuteString = "\(minute)"
//        if minute < 10
//        {
//            minuteString = "0\(minute)"
//        }
//        
//        let second = (flooredCounter % 3600) % 60
//        var secondString = "\(second)"
//
//        if second < 10
//        {
//            secondString = "0\(second)"
//        }
//
//        let preSecond = String (format: "%.2f", counter).components(separatedBy: ".").last!
//
//        TimeLabel.text = "\(minuteString):\(secondString)"
//        PreSecondLabel.text = preSecond
//    }
//}

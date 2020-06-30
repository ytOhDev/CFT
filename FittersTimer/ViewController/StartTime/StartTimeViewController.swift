//
//  StartTimeViewController.swift
//  FittersTimer
//
//  Created by PASSTECH on 25/04/2019.
//  Copyright © 2019 Taek. All rights reserved.
//

import UIKit
import AVFoundation

class StartTimeViewController: UIViewController {
    
    // Content
    
    @IBOutlet weak var View_WorkTime    : UIView!
    @IBOutlet weak var View_Cycle       : UIView!
    @IBOutlet weak var View_Round       : UIView!
    
    @IBOutlet var Lb_NS24               : [UILabel]!
    @IBOutlet var Lb_DS35               : [UILabel]!
    @IBOutlet var Lb_DS120              : UILabel!
    @IBOutlet var Lb_DS150              : [UILabel]!
    @IBOutlet var Lb_Sy24               : [UILabel]!
    
    // Label
    
    @IBOutlet weak var Lb_Title         : UILabel!
    @IBOutlet weak var Lb_WorkTime      : UILabel!
    @IBOutlet weak var Lb_Work          : UILabel!
    
    @IBOutlet weak var Lb_Work_M        : UILabel!
    @IBOutlet weak var Lb_Work_S        : UILabel!
    
    @IBOutlet weak var Lb_Cycle_F       : UILabel!
    @IBOutlet weak var Lb_Cycle         : UILabel!
    @IBOutlet weak var Lb_Round_F       : UILabel!
    @IBOutlet weak var Lb_Round         : UILabel!
    @IBOutlet weak var Lb_StartTime     : UILabel!
    @IBOutlet weak var Lb_EndTime       : UILabel!
    
    // Button
    
    @IBOutlet weak var Btn_Start        : UIButton!
    @IBOutlet weak var Btn_Reset        : UIButton!
    @IBOutlet weak var Btn_Back         : UIButton!
    @IBOutlet weak var Btn_Menu         : UIButton!
    
    
    // Fixed Text
    
    @IBOutlet weak var Lb_Cycle_C       : UILabel!
    @IBOutlet weak var Lb_Cycle_Slash   : UILabel!
    @IBOutlet weak var Lb_Round_R       : UILabel!
    @IBOutlet weak var Lb_Round_Slash   : UILabel!
    @IBOutlet weak var Lb_Work_Colon    : UILabel!
    @IBOutlet weak var Lb_StartText     : UILabel!
    @IBOutlet weak var Lb_EndText       : UILabel!
    
    
    private var objPlayer           : AVAudioPlayer?
    private var timer = Timer()
    private var isTimerRunning      : Bool = false
    private var counter             : Int = 0
    private var StartFlag           : Bool = false
    private var orderBy             : Bool = true
    private var labelColor          : Bool = true
    
    private var navi                : String = ""
    private var state               : String = ""
    
    private var prepare             : Int = 0
    private var work                : String = "00:00"
    private var cycle               : Int = 1
    private var cycle_rest          : String = "00:00"
    private var round               : Int = 1
    private var round_rest          : String = "00:00"
    private var startTime           : String = ""
    private var endTime             : String = ""
    
    private var F_prepare           : Int = 0
    private var F_work              : String = "00:00"
    private var F_work_m            : String = "00"
    private var F_work_s            : String = "00"
    private var F_cycle             : Int = 1
    private var F_cycle_rest        : String = "00:00"
    private var F_cycle_rest_m      : String = "00"
    private var F_cycle_rest_s      : String = "00"
    private var F_round             : Int = 1
    private var F_round_rest        : String = "00:00"
    private var F_round_rest_m      : String = "00"
    private var F_round_rest_s      : String = "00"
    private var F_Alltime_Int       : Int = 0
    private var F_Alltime           : String = "00:00"
    private var F_Alltime_h         : String = ""
    private var F_Alltime_m         : String = "00"
    private var F_Alltime_s         : String = "00"
    private var F_Alltime_Left      : Int = 0
    
    private var Int_work            : Int = 0
    private var Int_round_rest      : Int = 0
    private var Int_cycle_rest      : Int = 0
    
    private var changeState         : Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("StartTimeViewController viewDidLoad()")
        
        setLabelFont()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        print("preferredStatusBarStyle() called")
        
        let flag: Bool = UserDefaults.standard.value(forKey: "color") as? Bool ?? true
        
        labelColor = flag
        
        if labelColor == true
        {
            return .lightContent
        }
        else
        {
            return .default
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("StartTimeViewController appear")
        
        UIApplication.shared.isIdleTimerDisabled = true
        
        if let order_value = UserDefaults.standard.value(forKey: "order") as? Bool
        {
            orderBy = order_value
        }
        
        setUI()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("StartTimeViewController disappear")
        
        stop()
        
        UIApplication.shared.isIdleTimerDisabled = false
    }
    
    func setUI()
    {
        print("setUI()")
        navi = Status.sharedInstance.getNaviString()
        print("navi: \(navi)")
        
        dataInit()
        setNeedsStatusBarAppearanceUpdate()
        changeLabelColor()
        
        if F_prepare == 0 // 준비 시간이 없다. 바로 운동
        {
            if orderBy == true // 오름차순
            {
                Lb_Work_M.text = "00"
                Lb_Work_S.text = "00"
            }
            else // 내림차순
            {
                Lb_Work_M.text = F_work_m
                Lb_Work_S.text = F_work_s
            }
        }
        else // 준비 시간이 있다
        {
            Lb_Work_M.text = "00"
            Lb_Work_S.text = UserDefaults.standard.value(forKey: navi + "_" + "Prepare") as? String ?? "00"
        }
        
        Lb_Title.text = navi
        Lb_Work.text = "Work Time"
        Lb_WorkTime.text = F_Alltime
        Lb_Cycle_F.text = String(F_cycle)
        Lb_Cycle.text = "1"
        if Status.sharedInstance.getNavi() == .EMOM
        {
            print("F_work_m: \(F_work_m)")
            let work_m_int: Int = Int(F_work_m)!
            Lb_Round_F.text = String(work_m_int)
        }
        else
        {
            Lb_Round_F.text = String(F_round)
        }
        Lb_Round.text = "1"
        Lb_StartTime.text = "00:00:00"
        Lb_EndTime.text = "00:00:00"
        Btn_Reset.isEnabled = false
        Btn_Start.isEnabled = true
        Btn_Start.setTitle("Start", for: .normal)
        
        Lb_StartTime.text = getCurrentTime()
        Lb_EndTime.text = getAfterTime(passTime: F_Alltime_Int)
    }
    
    func dataInit()
    {
        if UserDefaults.standard.value(forKey: navi + "_" + "Prepare") == nil
        {
            UserDefaults.standard.set("00", forKey: navi + "_" + "Prepare")
        }
        
        if UserDefaults.standard.value(forKey: navi + "_" + "Round") == nil
        {
            UserDefaults.standard.set("01", forKey: navi + "_" + "Round")
        }
        
        if UserDefaults.standard.value(forKey: navi + "_" + "Round_Rest") == nil
        {
            UserDefaults.standard.set("00:00", forKey: navi + "_" + "Round_Rest")
        }
        
        if UserDefaults.standard.value(forKey: navi + "_" + "Round_Rest" + "_M") == nil
        {
            UserDefaults.standard.set("00", forKey: navi + "_" + "Round_Rest" + "_M")
        }
        
        if UserDefaults.standard.value(forKey: navi + "_" + "Round_Rest" + "_S") == nil
        {
            UserDefaults.standard.set("00", forKey: navi + "_" + "Round_Rest" + "_S")
        }
        
        
        if UserDefaults.standard.value(forKey: navi + "_" + "Cycle") == nil
        {
            UserDefaults.standard.set("01", forKey: navi + "_" + "Cycle")
        }
        
        if UserDefaults.standard.value(forKey: navi + "_" + "Cycle_Rest") == nil
        {
            UserDefaults.standard.set("00:00", forKey: navi + "_" + "Cycle_Rest")
        }
        
        if UserDefaults.standard.value(forKey: navi + "_" + "Cycle_Rest" + "_M") == nil
        {
            UserDefaults.standard.set("00", forKey: navi + "_" + "Cycle_Rest" + "_M")
        }
        
        if UserDefaults.standard.value(forKey: navi + "_" + "Cycle_Rest" + "_S") == nil
        {
            UserDefaults.standard.set("00", forKey: navi + "_" + "Cycle_Rest" + "_S")
        }
        
        F_prepare = Int(UserDefaults.standard.value(forKey: navi + "_" + "Prepare") as? String ?? "00") ?? 0
        F_work = UserDefaults.standard.value(forKey: navi + "_" + "Work") as! String
        F_work_m = UserDefaults.standard.value(forKey: navi + "_" + "Work" + "_M") as! String
        F_work_s = UserDefaults.standard.value(forKey: navi + "_" + "Work" + "_S") as! String
        F_cycle = Int(UserDefaults.standard.value(forKey: navi + "_" + "Cycle") as? String ?? "1") ?? 1
        F_cycle_rest = UserDefaults.standard.value(forKey: navi + "_" + "Cycle_Rest") as! String
        F_cycle_rest_m = UserDefaults.standard.value(forKey: navi + "_" + "Cycle_Rest" + "_M") as! String
        F_cycle_rest_s = UserDefaults.standard.value(forKey: navi + "_" + "Cycle_Rest" + "_S") as! String
        F_round = Int(UserDefaults.standard.value(forKey: navi + "_" + "Round") as? String ?? "1") ?? 1
        F_round_rest = UserDefaults.standard.value(forKey: navi + "_" + "Round_Rest") as! String
        F_round_rest_m = UserDefaults.standard.value(forKey: navi + "_" + "Round_Rest" + "_M") as! String
        F_round_rest_s = UserDefaults.standard.value(forKey: navi + "_" + "Round_Rest" + "_S") as! String
        
        Int_work = (Int(F_work_m)! * 60 + Int(F_work_s)!)
        Int_round_rest = (Int(F_round_rest_m)! * 60 + Int(F_round_rest_s)!)
        Int_cycle_rest = (Int(F_cycle_rest_m)! * 60 + Int(F_cycle_rest_s)!)
        
        let prepare_s: Int = F_prepare
        let work_s: Int = F_cycle * F_round * (Int(F_work_m)! * 60 + Int(F_work_s)!)
        let round_rest_s: Int = (F_cycle * F_round - 1) * (Int(F_round_rest_m)! * 60 + Int(F_round_rest_s)!)
        let cycle_rest_s: Int = (F_cycle - 1) * (Int(F_cycle_rest_m)! * 60 + Int(F_cycle_rest_s)!)
        
        F_Alltime_Int = prepare_s + work_s + round_rest_s + cycle_rest_s
        F_Alltime_Left = F_Alltime_Int
        
        print("*** Selected TIme ***\nPrepare: \(F_prepare), Work: \(F_work), Round: \(F_round), Round Rest: \(F_round_rest), Cycle: \(F_cycle), Cycle Rest: \(F_cycle_rest), All Work Time: \(F_Alltime_Int)")
        
        print("prepare_s: \(prepare_s), work_s: \(work_s), round_rest_s: \(round_rest_s), cycle_rest_s: \(cycle_rest_s)")
        
        print("")
        
        var Alltime_m_int: Int = F_Alltime_Int / 60
        let Alltime_s_int: Int = F_Alltime_Int % 60
        
        if Alltime_m_int > 59
        {
            let temp = Alltime_m_int / 60
            if temp < 10
            {
                F_Alltime_h = "0" + String(temp)
            }
            else
            {
                F_Alltime_h = String(temp)
            }
            Alltime_m_int = Alltime_m_int - (temp * 60)
        }
        
        if Alltime_m_int < 10
        {
            F_Alltime_m = "0" + String(Alltime_m_int)
        }
        else
        {
            F_Alltime_m = String(Alltime_m_int)
        }
        
        if Alltime_s_int < 10
        {
            F_Alltime_s = "0" + String(Alltime_s_int)
        }
        else
        {
            F_Alltime_s = String(Alltime_s_int)
        }
        
        if F_Alltime_h == ""
        {
            //            Lb_WorkTime.font = Lb_WorkTime.font.withSize(40)
            F_Alltime = F_Alltime_m + ":" + F_Alltime_s
        }
        else
        {
            //            Lb_WorkTime.font = Lb_WorkTime.font.withSize(27)
            F_Alltime = F_Alltime_h + ":" + F_Alltime_m + ":" + F_Alltime_s
        }
        
        prepare = F_prepare
        work = "00:00"
        cycle = 1
        cycle_rest = "00:00"
        round = 1
        round_rest = "00:00"
        
        print("prepare: \(prepare), orderBy: \(orderBy)")
        
        if prepare != 0
        {
            counter = -1
            Status.sharedInstance.putMovement(.Prepare)
        }
        else
        {
            if orderBy == true
            {
                counter = 0
            }
            else
            {
                counter = (Int(F_work_m)! * 60) + Int(F_work_s)!
            }
            Status.sharedInstance.putMovement(.Work)
        }
        
        print("counter: \(counter), putMovement: \(Status.sharedInstance.getMovement())")
    }
    
    func setLabelFont()
    {
        let bounds = UIScreen.main.bounds
        let height = bounds.size.height
        print("height: \(height)")
        
        for label in Lb_DS35
        {
            label.dynamicFont(fontSize: 35.0)
        }
        Lb_DS120.dynamicFont(fontSize: 120.0)
        for label in Lb_DS150
        {
            label.dynamicFont(fontSize: 150.0)
        }
        for label in Lb_NS24
        {
            label.dynamicFont(fontSize: 24.0)
        }
        for label in Lb_Sy24
        {
            label.dynamicFont(fontSize: 24.0)
        }
        Lb_Title.dynamicFont(fontSize: 40.0)
        
        Btn_Start.titleLabel?.dynamicFont(fontSize: 30.0)
        Btn_Reset.titleLabel?.dynamicFont(fontSize: 30.0)
        Btn_Back.setImage(UIImage(named: Size.sharedInstance.getSizeImage(height, "left_arrow_blue")), for: .normal)
        Btn_Menu.setImage(UIImage(named: Size.sharedInstance.getSizeImage(height, "list-menu_blue")), for: .normal)
    }
    
    func changeLabelColor()
    {
        if let flag: Bool = UserDefaults.standard.value(forKey: "color") as? Bool
        {
            labelColor = flag
            if flag == true // 흰색 글씨
            {
                labelColorChange(color: UIColor(red: 245.0/255.0, green: 245.0/255.0, blue: 240.0/255.0, alpha: 1.0))
                self.view.backgroundColor = UIColor(red: 41.0/255.0, green: 41.0/255.0, blue: 41.0/255.0, alpha: 1.0)
                View_WorkTime.backgroundColor = UIColor(red: 150.0/255.0, green: 150.0/255.0, blue: 150.0/255.0, alpha: 1.0)
                View_Cycle.backgroundColor = UIColor(red: 100.0/255.0, green: 100.0/255.0, blue: 100.0/255.0, alpha: 1.0)
                View_Round.backgroundColor = UIColor(red: 70.0/255.0, green: 70.0/255.0, blue: 70.0/255.0, alpha: 1.0)
                Btn_Reset.backgroundColor = UIColor(red: 150.0/255.0, green: 150.0/255.0, blue: 150.0/255.0, alpha: 1.0)
                Btn_Start.backgroundColor = UIColor(red: 100.0/255.0, green: 100.0/255.0, blue: 100.0/255.0, alpha: 1.0)
            }
            else
            {
                labelColorChange(color: UIColor(red: 41.0/255.0, green: 41.0/255.0, blue: 41.0/255.0, alpha: 1.0))
                self.view.backgroundColor = UIColor(red: 245.0/255.0, green: 245.0/255.0, blue: 240.0/255.0, alpha: 1.0)
                View_WorkTime.backgroundColor = UIColor(red: 200.0/255.0, green: 200.0/255.0, blue: 200.0/255.0, alpha: 1.0)
                View_Cycle.backgroundColor = UIColor(red: 170.0/255.0, green: 170.0/255.0, blue: 170.0/255.0, alpha: 1.0)
                View_Round.backgroundColor = UIColor(red: 140.0/255.0, green: 140.0/255.0, blue: 140.0/255.0, alpha: 1.0)
                Btn_Reset.backgroundColor = UIColor(red: 200.0/255.0, green: 200.0/255.0, blue: 200.0/255.0, alpha: 1.0)
                Btn_Start.backgroundColor = UIColor(red: 170.0/255.0, green: 170.0/255.0, blue: 170.0/255.0, alpha: 1.0)
            }
        }
    }
    
    func labelColorChange(color: UIColor)
    {
        Lb_WorkTime.textColor = color
        Lb_Work.textColor = color
        Lb_Work_M.textColor = color
        Lb_Work_S.textColor = color
        Lb_Cycle_F.textColor = color
        Lb_Cycle.textColor = color
        Lb_Round_F.textColor = color
        Lb_Round.textColor = color
        Lb_StartTime.textColor = color
        Lb_EndTime.textColor = color
        
        Lb_Cycle_C.textColor = color
        Lb_Cycle_Slash.textColor = color
        Lb_Round_R.textColor = color
        Lb_Round_Slash.textColor = color
        Lb_Work_Colon.textColor = color
        Lb_StartText.textColor = color
        Lb_EndText.textColor = color
        
        Btn_Reset.setTitleColor(color, for: .normal)
        Btn_Start.setTitleColor(color, for: .normal)
    }
    
    @IBAction func SwipedView(_ sender: Any) {
        print("SwipedView")
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func MenuBtnTapped(_ sender: Any) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "OptionView") as! OptionViewController
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func BackBtnTapped(_ sender: Any)
    {
        print("BackBtnTapped")
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func ResetBtnTapped(_ sender: Any)
    {
        print("ResetBtnTapped")
        reset()
    }
    
    @IBAction func StartBtnTapped(_ sender: Any)
    {
        print("StartBtnTapped")
        print("StartFlag: \(StartFlag)")
        
        if StartFlag
        {
            stop()
            StartFlag = false
            Btn_Start.setTitle("Start", for: .normal)
            if labelColor == true
            {
                Btn_Reset.setTitleColor(UIColor(red: 245.0/255.0, green: 245.0/255.0, blue: 240.0/255.0, alpha: 1.0), for: .normal)
            }
            else
            {
                Btn_Reset.setTitleColor(UIColor(red: 41.0/255.0, green: 41.0/255.0, blue: 41.0/255.0, alpha: 1.0), for: .normal)
            }
            Btn_Reset.isEnabled = true
        }
        else
        {
            start()
            StartFlag = true
            Btn_Start.setTitle("Stop", for: .normal)
            Btn_Reset.setTitleColor(.gray, for: .normal)
            Btn_Reset.isEnabled = false
        }
        
    }
    
    func start()
    {
        print("start()")
        if !isTimerRunning
        {
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(runningTimer), userInfo: nil, repeats: true)
            isTimerRunning = true
            Lb_StartTime.text = getCurrentTime()
            Lb_EndTime.text = getAfterTime(passTime: F_Alltime_Left)
        }
    }
    
    func reset()
    {
        print("reset()")
        timer.invalidate()
        isTimerRunning = false
        
        setUI()
    }
    
    func stop()
    {
        print("stop()")
        isTimerRunning = false
        timer.invalidate()
    }
    
    func getCurrentTime() -> String
    {
        let date = NSDate()
        let calender = NSCalendar.current
        let components = calender.dateComponents([.hour, .minute], from: date as Date)
        let time = String(format: "%02d:%02d", components.hour!, components.minute!)
        print("############### current time : \(time) ##################")
        
        return time
    }
    
    func getAfterTime(passTime: Int) -> String
    {
        let calender = Calendar.current
        let date = calender.date(byAdding: .second, value: passTime, to: Date())
        let components = calender.dateComponents([.hour, .minute], from: date!)
        let time = String(format: "%02d:%02d", components.hour!, components.minute!)
        print("############### after time : \(time) ##################")
        
        return time
    }
    
    @objc func runningTimer()
    {
        print("runningTimer: start")
        
        var min: Int = 0
        var sec: Int = 0
        var minS: String = ""
        var secS: String = ""
        
        F_Alltime_Left -= 1
        
        if Status.sharedInstance.getMovement() == .Prepare
        {
            prepare -= 1
            
            minS = "00"
            if prepare > 9
            {
                secS = String(prepare)
            }
            else
            {
                secS = "0" + String(prepare)
            }
        }
        else
        {
            if orderBy == true
            {
                counter += 1
            }
            else
            {
                counter -= 1
            }
            
            min = (counter % 3600) / 60
            sec = (counter % 3600) % 60
            
            if min < 10
            {
                minS = "0" + String(min)
            }
            else
            {
                minS = String(min)
            }
            
            if sec < 10
            {
                secS = "0" + String(sec)
            }
            else
            {
                secS = String(sec)
            }
        }
        
        if prepare == 0 && Status.sharedInstance.getMovement() == .Prepare
        {
            print("if prepare time is 1")
            Status.sharedInstance.putMovement(.Work)
            prepare = F_prepare
            if orderBy == true
            {
                counter = 0
            }
            else
            {
                counter = (Int(F_work_m)! * 60) + Int(F_work_s)!
            }
        }
        
        if F_prepare == 0 && F_work == "00:01" && F_round == 1 && F_cycle == 1
            && Status.sharedInstance.getMovement() == .Work
        {
            print("if only work time is 1")
            Status.sharedInstance.putMovement(.End)
            if orderBy == true
            {
                secS = "00"
            }
            else
            {
                secS = "01"
            }
        }
        
        timeProcess(minS: minS, secS: secS)
    }
    
    func playAudioFile(last: Bool) {
        var resource: String = "Pitch-10_1"
        
        if last {
            resource = "Pitch-10_2"
        }
        
        guard let url = Bundle.main.url(forResource: resource, withExtension: "mp3") else { return }
        
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
            try AVAudioSession.sharedInstance().setActive(true)
            
            // For iOS 11
            objPlayer = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
            objPlayer?.volume = 1.0
            
            guard let aPlayer = objPlayer else { return }
            aPlayer.play()
            
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    func timeProcess(minS: String, secS: String)
    {
        switch Status.sharedInstance.getMovement() {
            
        case .Prepare:
            changeState = false
            print("in_prepare: \(prepare)")
            Lb_Work.text = "Prepare"
            
            if F_prepare < 10
            {
                Lb_WorkTime.text = "00:0" + String(F_prepare)
            }
            else
            {
                Lb_WorkTime.text = "00:" + String(F_prepare)
            }
            
            if prepare == 3
            {
                print("Prepare time left three seconds")
                playAudioFile(last: false)
            }
            else if prepare == 2
            {
                print("Prepare time left two seconds")
                playAudioFile(last: false)
            }
            else if prepare == 1 || F_prepare == 1
            {
                print("Prepare time left one second, move to next movement")
                playAudioFile(last: false)
                if orderBy == true
                {
                    counter = -1
                }
                else
                {
                    counter = (Int(F_work_m)! * 60) + Int(F_work_s)! + 1
                }
                changeState = true
                Status.sharedInstance.putMovement(.Work)
            }
            break
            
        case .Work:
            work = minS + ":" + secS
            if changeState
            {
                playAudioFile(last: true)
                changeState = false
            }
            print("in_workTimer: \(work)")
            Lb_Work.text = "Work"
            Lb_WorkTime.text = F_work
            Lb_Round.text = String(round)
            Lb_Cycle.text = String(cycle)
            
            if Status.sharedInstance.getNavi() == .EMOM
            {
                if orderBy == true
                {
                    Lb_Round.text = String((counter / 60) + 1)
                }
                else
                {
                    let reverseCount: Int = Int(F_work_m)! - ((counter - 1) / 60)
                    Lb_Round.text = String(reverseCount)
                }
            }
            if ((Int_work - counter) == 3 && orderBy == true) || (counter == 3 && orderBy == false)
            {
                print("Work time left three seconds")
                playAudioFile(last: false)
            }
            else if ((Int_work - counter) == 2 && orderBy == true) || (counter == 2 && orderBy == false)
            {
                print("Work time left two seconds")
                playAudioFile(last: false)
            }
            else if ((Int_work - counter) == 1 && orderBy == true) || (counter == 1 && orderBy == false)
            {
                playAudioFile(last: false)
                if round < F_round // round 가 안끝났을 때
                {
                    if F_round_rest != "00:00" // round_rest 있을 때
                    {
                        print("Work time left one second, move to Round_Rest")
                        if orderBy == true
                        {
                            counter = -1
                        }
                        else
                        {
                            counter = (Int(F_round_rest_m)! * 60) + Int(F_round_rest_s)! + 1
                        }
                        changeState = true
                        Status.sharedInstance.putMovement(.Round_Rest)
                    }
                    else // round_rest 없을 때
                    {
                        print("Work time left one second, move to Work")
                        round += 1
                        if orderBy == true
                        {
                            counter = -1
                        }
                        else
                        {
                            counter = (Int(F_work_m)! * 60) + Int(F_work_s)! + 1
                        }
                        changeState = true
                        Status.sharedInstance.putMovement(.Work)
                    }
                }
                else // round 가 끝났을 때
                {
                    if cycle < F_cycle // round 는 끝났고, cycle 은 안끝났을 때
                    {
                        if F_round_rest != "00:00" // round_rest 있을 때
                        {
                            print("Work time left one second, move to Round_Rest")
                            if orderBy == true
                            {
                                counter = -1
                            }
                            else
                            {
                                counter = (Int(F_round_rest_m)! * 60) + Int(F_round_rest_s)! + 1
                            }
                            changeState = true
                            Status.sharedInstance.putMovement(.Round_Rest)
                        }
                        else // round_rest 없을 때
                        {
                            if F_cycle_rest != "00:00" // round_rest는 없고 cycle_rest 는 있을 때
                            {
                                print("Work time left one second, move to Cycle_Rest")
                                if orderBy == true
                                {
                                    counter = -1
                                }
                                else
                                {
                                    counter = (Int(F_cycle_rest_m)! * 60) + Int(F_cycle_rest_s)! + 1
                                }
                                changeState = true
                                Status.sharedInstance.putMovement(.Cycle_Rest)
                            }
                            else // round_rest가 없고 cycle_rest 도 없을 때
                            {
                                print("Work time left one second, move to Work")
                                round = 1
                                cycle += 1
                                if orderBy == true
                                {
                                    counter = -1
                                }
                                else
                                {
                                    counter = (Int(F_work_m)! * 60) + Int(F_work_s)! + 1
                                }
                                changeState = true
                                Status.sharedInstance.putMovement(.Work)
                            }
                        }
                    }
                    else
                    {
                        print("Work time left one second, move to End")
                        changeState = true
                        Status.sharedInstance.putMovement(.End)
                    }
                }
            }
            break
            
        case .Round_Rest:
            round_rest = minS + ":" + secS
            if changeState
            {
                playAudioFile(last: true)
                changeState = false
            }
            print("in_round_rest: \(round_rest)")
            Lb_Work.text = "Round Rest"
            Lb_WorkTime.text = F_round_rest
            
            if ((Int_round_rest - counter) == 3 && orderBy == true) || (counter == 3 && orderBy == false)
            {
                print("Round_Rest time left three seconds")
                playAudioFile(last: false)
            }
            else if ((Int_round_rest - counter) == 2 && orderBy == true) || (counter == 2 && orderBy == false)
            {
                print("Round_Rest time left two seconds")
                playAudioFile(last: false)
            }
            else if ((Int_round_rest - counter) == 1 && orderBy == true) || (counter == 1 && orderBy == false)
            {
                playAudioFile(last: false)
                if round < F_round // round 가 안 끝났을 때
                {
                    print("Round_rest time left one second, move to Work")
                    round += 1
                    if orderBy == true
                    {
                        counter = -1
                    }
                    else
                    {
                        counter = (Int(F_work_m)! * 60) + Int(F_work_s)! + 1
                    }
                    changeState = true
                    Status.sharedInstance.putMovement(.Work)
                }
                else // round 가 끝났을 때
                {
                    if cycle < F_cycle // round 는 끝났고, cycle 은 안끝났을 때
                    {
                        if F_cycle_rest != "00:00" // cycle_rest 있을 때
                        {
                            print("Round_rest time left one second, move to Cycle_Rest")
                            if orderBy == true
                            {
                                counter = -1
                            }
                            else
                            {
                                counter = (Int(F_cycle_rest_m)! * 60) + Int(F_cycle_rest_s)! + 1
                            }
                            changeState = true
                            Status.sharedInstance.putMovement(.Cycle_Rest)
                        }
                        else // cycle_rest 없을 때
                        {
                            print("Round_rest time left one second, move to Work")
                            round = 1
                            cycle += 1
                            if orderBy == true
                            {
                                counter = -1
                            }
                            else
                            {
                                counter = (Int(F_work_m)! * 60) + Int(F_work_s)! + 1
                            }
                            changeState = true
                            Status.sharedInstance.putMovement(.Work)
                        }
                    }
                    else // round 가 끝났고, cycle 도 끝났을 때 -> 종료
                    {
                        print("Round_rest time left one second, move to End")
                        changeState = true
                        Status.sharedInstance.putMovement(.End)
                    }
                }
            }
            break
            
        case .Cycle_Rest:
            cycle_rest = minS + ":" + secS
            if changeState
            {
                playAudioFile(last: true)
                changeState = false
            }
            print("in_cycle_rest: \(cycle_rest)")
            Lb_Work.text = "Cycle Rest"
            Lb_WorkTime.text = F_cycle_rest
            
            if ((Int_cycle_rest - counter) == 3 && orderBy == true) || (counter == 3 && orderBy == false)
            {
                print("Cycle_Rest time left three seconds")
                playAudioFile(last: false)
            }
            else if ((Int_cycle_rest - counter) == 2 && orderBy == true) || (counter == 2 && orderBy == false)
            {
                print("Cycle_Rest time left two seconds")
                playAudioFile(last: false)
            }
            else if ((Int_cycle_rest - counter) == 1 && orderBy == true) || (counter == 1 && orderBy == false)
            {
                playAudioFile(last: false)
                print("Cycle_Rest time left one second, move to Work")
                round = 1
                cycle += 1
                if orderBy == true
                {
                    counter = -1
                }
                else
                {
                    counter = (Int(F_work_m)! * 60) + Int(F_work_s)! + 1
                }
                changeState = true
                Status.sharedInstance.putMovement(.Work)
            }
            break
            
        case .End:
            if changeState
            {
                playAudioFile(last: true)
                changeState = false
            }
            print("End")
            Lb_Work.text = "End"
            Lb_WorkTime.text = F_Alltime
            
            StartFlag = false
            if labelColor == true
            {
                Btn_Reset.setTitleColor(.white, for: .normal)
            }
            else
            {
                Btn_Reset.setTitleColor(.black, for: .normal)
            }
            Btn_Reset.isEnabled = true
            
            Btn_Start.isEnabled = false
            Btn_Start.setTitleColor(.gray, for: .normal)
            
            stop()
            print("All the movement is finished")
            break
        }
        
        Lb_Work_M.text = minS
        Lb_Work_S.text = secS
    }
    
    
}

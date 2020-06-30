//
//  DualViewController.swift
//  FittersTimer
//
//  Created by PASSTECH on 19/04/2019.
//  Copyright © 2019 Taek. All rights reserved.
//

import UIKit

class DualViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    static let sharedInstance = DualViewController()
    
    @IBOutlet weak var TimePicker       : UIPickerView!
    @IBOutlet weak var DualViewTitle    : UILabel!
    @IBOutlet weak var Lb_Sec1          : UILabel!
    @IBOutlet weak var Lb_Min2          : UILabel!
    @IBOutlet weak var Lb_Sec2          : UILabel!
    
    @IBOutlet var Lb_Arr                : [UILabel]!
    
    @IBOutlet weak var Btn_Select       : UIButton!
    @IBOutlet weak var Btn_Cancel       : UIButton!
    
    var singleData                      : [String] = [String]()
    var dualData                        : [[String]] = [[String]]()
    var countData                       : [String] = [String]()
    var minute                          : [String] = [String]()
    var second                          : [String] = [String]()
    
    private var navi: String = ""
    private var state: String = ""
    
    var dualOn = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("DualViewController viewDidLoad()")
        
        // Do any additional setup after loading the view.
        
        TimePicker.delegate = self
        TimePicker.dataSource = self
        UIApplication.shared.isIdleTimerDisabled = true
        print("Navi: \(Status.sharedInstance.getNavi()) / State: \(Status.sharedInstance.getState())")
        
        setState()
        setData()
        setInit()
    }
    
    func setInit()
    {
        DualViewTitle.dynamicFont(fontSize: 35)
        for label in Lb_Arr
        {
            label.dynamicFont(fontSize: 25)
        }
        Btn_Select.titleLabel?.dynamicFont(fontSize: 25)
        Btn_Cancel.titleLabel?.dynamicFont(fontSize: 25)
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        print("DualViewController viewWillAppear")
        
        loadData()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setData()
    {
        print("setData()")
        
        for i in 0 ..< 60
        {
            var temp = String(i)
            if i < 10
            {
                temp = "0" + temp
            }
            minute.append(temp)
            second.append(temp)
        }
        
        for i in 1 ..< 100
        {
            var temp = String(i)
            if i < 10
            {
                temp = "0" + temp
            }
            countData.append(temp)
        }
        
        singleData = second
        dualData = [minute, second]
        
        navi = Status.sharedInstance.getNaviString()
        state = Status.sharedInstance.getStateString()
    }
    
    func setState()
    {
        print("setState()")
        
        switch Status.sharedInstance.getState() {
        case .Prepare:
            DualViewTitle.text = "PREPARE TIME"
            dualOn = false
            Lb_Sec1.text = "Sec"
            break
        case .Work:
            DualViewTitle.text = "WORK TIME"
            if Status.sharedInstance.getNavi() == .EMOM
            {
                Lb_Sec1.text = "MIN"
                dualOn = false
            }
            else
            {
                dualOn = true
            }
            break
        case .Round_Rest:
            DualViewTitle.text = "ROUND REST TIME"
            dualOn = true
            break
        case .Round:
            DualViewTitle.text = "ROUND"
            dualOn = false
            Lb_Sec1.text = "SET"
            break
        case .Cycle:
            DualViewTitle.text = "CYCLE"
            dualOn = false
            Lb_Sec1.text = "SET"
            break
        case .Cycle_Rest:
            DualViewTitle.text = "CYCLE REST TIME"
            dualOn = true
            break
        }
        print("dualOn: \(dualOn)")
        
        if dualOn
        {
            Lb_Sec1.textColor = UIColor.clear
            Lb_Min2.textColor = UIColor.black
            Lb_Sec2.textColor = UIColor.black
        }
        else
        {
            Lb_Sec1.textColor = UIColor.black
            Lb_Min2.textColor = UIColor.clear
            Lb_Sec2.textColor = UIColor.clear
        }
    }
    
    func saveData()
    {
        print("saveData()")
        
        switch Status.sharedInstance.getState() {
        case .Prepare:
            UserDefaults.standard.set(singleData[TimePicker.selectedRow(inComponent: 0)], forKey: navi + "_" + state)
            break
        case .Work:
            if (Status.sharedInstance.getNavi() == .EMOM)
            {
                let min = countData[TimePicker.selectedRow(inComponent: 0)]
                UserDefaults.standard.set(min + ":00", forKey: navi + "_" + state)
                UserDefaults.standard.set(min, forKey: navi + "_" + state + "_M")
                UserDefaults.standard.set("00", forKey: navi + "_" + state + "_S")
            }
            else
            {
                let min = dualData[0][TimePicker.selectedRow(inComponent: 0)]
                let sec = dualData[1][TimePicker.selectedRow(inComponent: 1)]
                UserDefaults.standard.set(min + ":" + sec, forKey: navi + "_" + state)
                UserDefaults.standard.set(min, forKey: navi + "_" + state + "_M")
                UserDefaults.standard.set(sec, forKey: navi + "_" + state + "_S")
            }
            
            break
        case .Round_Rest:
            let min = dualData[0][TimePicker.selectedRow(inComponent: 0)]
            let sec = dualData[1][TimePicker.selectedRow(inComponent: 1)]
            UserDefaults.standard.set(min + ":" + sec, forKey: navi + "_" + state)
            UserDefaults.standard.set(min, forKey: navi + "_" + state + "_M")
            UserDefaults.standard.set(sec, forKey: navi + "_" + state + "_S")
            break
        case .Round:
            UserDefaults.standard.set(countData[TimePicker.selectedRow(inComponent: 0)], forKey: navi + "_" + state)
            break
        case .Cycle:
            UserDefaults.standard.set(countData[TimePicker.selectedRow(inComponent: 0)], forKey: navi + "_" + state)
            break
        case .Cycle_Rest:
            let min = dualData[0][TimePicker.selectedRow(inComponent: 0)]
            let sec = dualData[1][TimePicker.selectedRow(inComponent: 1)]
            UserDefaults.standard.set(min + ":" + sec, forKey: navi + "_" + state)
            UserDefaults.standard.set(min, forKey: navi + "_" + state + "_M")
            UserDefaults.standard.set(sec, forKey: navi + "_" + state + "_S")
            break
        }
    }
    
    func loadData()
    {
        print("loadData()")
        print("navi: \(navi), state: \(state)")
        
        if dualOn
        {
            if let status: String = UserDefaults.standard.value(forKey: navi + "_" + state) as? String
            {
                let index_min = status.index(status.startIndex, offsetBy: 2)
                let min = Int(status[..<index_min])!
                
                let index_sec = status.index(status.endIndex, offsetBy: -2)
                let sec = Int(status[index_sec...])!
                
                print("min: \(min) / sec: \(sec)")
                TimePicker.selectRow(min, inComponent: 0, animated: true)
                TimePicker.selectRow(sec, inComponent: 1, animated: true)
            }
        }
        else
        {
            if let status: String = UserDefaults.standard.value(forKey: navi + "_" + state) as? String
            {
                if Status.sharedInstance.getState() == .Prepare
                {
                    let sec = Int(status)!
                    TimePicker.selectRow(sec, inComponent: 0, animated: true)
                }
                else
                {
                    if Status.sharedInstance.getNavi() == .EMOM
                    {
                        let index_min = status.index(status.startIndex, offsetBy: 2)
                        let min = Int(status[..<index_min])!
                        let index = min - 1
                        
                        TimePicker.selectRow(index, inComponent: 0, animated: true)
                    }
                    else
                    {
                        let sec = Int(status)! - 1
                        TimePicker.selectRow(sec, inComponent: 0, animated: true)
                    }
                }
            }
        }
        
    }
    
    
    @IBAction func SelectBtnTapped(_ sender: Any)
    {
        print("SelectBtnTapped")
        
        saveData()
        
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func CancelBtnTapped(_ sender: Any)
    {
        print("CancelBtnTapped")
        self.dismiss(animated: true, completion: nil)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        if dualOn
        {
            return 2
        }
        else
        {
            return 1
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if dualOn
        {
            return dualData[component].count
        }
        else
        {
            if Status.sharedInstance.getState() == .Prepare
            {
                return singleData.count
            }
            else
            {
                return countData.count
            }
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if dualOn
        {
            return dualData[component][row]
        }
        else
        {
            if Status.sharedInstance.getState() == .Prepare
            {
                return singleData[row]
            }
            else
            {
                return countData[row]
            }
        }
    }
        
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        let bounds = UIScreen.main.bounds
        let height = bounds.size.height
        print("height: \(height)")
        
        return Size.sharedInstance.getPickerViewWidth(height)
        
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        
        let label = (view as? UILabel) ?? UILabel()
        
        label.textAlignment = .center
        label.font = UIFont(name: "DS-Digital-Bold", size: 60)
        label.dynamicFont(fontSize: 60)
        
        if dualOn
        {
            label.text = dualData[component][row]
        }
        else
        {
            if Status.sharedInstance.getState() == .Prepare
            {
                label.text = singleData[row]
            }
            else
            {
                label.text = countData[row]
            }
        }
        
        return label
    }

    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        let bounds = UIScreen.main.bounds
        let height = bounds.size.height
        print("height: \(height)")
        
        return Size.sharedInstance.getTableRowHeight(height)
    }
    
}

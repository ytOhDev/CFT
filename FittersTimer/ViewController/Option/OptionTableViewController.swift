//
//  OptionTableViewController.swift
//  FittersTimer
//
//  Created by PASSTECH on 2019/11/19.
//  Copyright © 2019 Taek. All rights reserved.
//

import UIKit

class OptionTableViewController: UITableViewController {
    
    @IBOutlet weak var Sw_Color     : UISwitch!
    @IBOutlet weak var Sw_OrderBy   : UISwitch!
    
    @IBOutlet weak var Lb_Black     : UILabel!
    @IBOutlet weak var Lb_White     : UILabel!
    
    @IBOutlet weak var Lb_Down      : UILabel!
    @IBOutlet weak var Lb_Up        : UILabel!
    
    @IBOutlet var Lb_Arr            : [UILabel]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setSwitch()
        setInit()
    }
    
    func setInit()
    {
        for label in Lb_Arr
        {
            label.dynamicFont(fontSize: 18)
        }
        Sw_Color.dynamicSize()
        Sw_OrderBy.dynamicSize()
    }
    
    func setSwitch()
    {
        if let colorFlag: Bool = UserDefaults.standard.value(forKey: "color") as? Bool
        {
            Sw_Color.isOn = colorFlag
            changeColor(flag: .color, value: Sw_Color.isOn)
        }
        
        if let orderFlag: Bool = UserDefaults.standard.value(forKey: "order") as? Bool
        {
            Sw_OrderBy.isOn = orderFlag
            changeColor(flag: .order, value: Sw_OrderBy.isOn)
        }
    }
    
    
    @IBAction func TappedSwColor(_ sender: UISwitch) {
        changeColor(flag: .color, value: sender.isOn)
        Status.sharedInstance.color = sender.isOn
    }
    
    
    @IBAction func TappedSwOrder(_ sender: UISwitch) {
        changeColor(flag: .order, value: sender.isOn)
        Status.sharedInstance.order = sender.isOn
    }
    
    func changeColor(flag: SettingFlag, value: Bool)
    {
        if flag == .color
        {
            if value == true
            {
                Lb_White.textColor = UIColor(red: 0/255, green: 122/255, blue: 255/255, alpha: 1.0)
                Lb_Black.textColor = .lightGray
            }
            else
            {
                Lb_White.textColor = .lightGray
                Lb_Black.textColor = UIColor(red: 0/255, green: 122/255, blue: 255/255, alpha: 1.0)
            }
        }
        else if flag == .order
        {
            if value == true
            {
                Lb_Up.textColor = UIColor(red: 0/255, green: 122/255, blue: 255/255, alpha: 1.0)
                Lb_Down.textColor = .lightGray
            }
            else
            {
                Lb_Up.textColor = .lightGray
                Lb_Down.textColor = UIColor(red: 0/255, green: 122/255, blue: 255/255, alpha: 1.0)
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.font = UIFont(name: "SF Sports Night NS Upright", size: 24)!
        header.textLabel?.dynamicFont(fontSize: 24)
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let bounds = UIScreen.main.bounds
        let height = bounds.size.height
        print("height: \(height)")
        
        return Size.sharedInstance.getTableRowHeight(height)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let bounds = UIScreen.main.bounds
        let height = bounds.size.height
        print("height: \(height)")
        
        return Size.sharedInstance.getTableRowHeight(height)
    }
        
}

enum SettingFlag
{
    case color
    case order
}

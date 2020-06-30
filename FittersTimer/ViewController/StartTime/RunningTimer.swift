//
//  RunningTimer.swift
//  FittersTimer
//
//  Created by PASSTECH on 30/07/2019.
//  Copyright © 2019 Taek. All rights reserved.
//

import Foundation

class RunningTimer: NSObject
{
    static let sharedInstance = RunningTimer()
    
    func runningTimer(prepare_use: Bool)
    {
        print("runningTimer: start")
        
        var min: Int = 0
        var sec: Int = 0
        var minS: String = ""
        var secS: String = ""
        
        if prepare_use
        {
            prepare -= 1
        }
        else
        {
            counter += 1
            
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
                minS = String(min)
            }
        }
        
        Lb_State.text = Status.sharedInstance.getMovementString()
        
        switch Status.sharedInstance.getMovement() {
            
        case .Prepare:
            print("in_prepare: \(prepare)")
            
            if prepare == 3
            {
                print("Prepare time left three seconds")
            }
            else if prepare == 2
            {
                print("Prepare time left two seconds")
            }
            else if prepare == 1
            {
                print("Prepare time left one second")
                Status.sharedInstance.putMovement(.Work)
                counter = 0
            }
            break
        case .Work:
            workTimer = minS + ":" + secS
            print("in_workTimer: \(workTimer)")
            
            let F_min: Int = Int(UserDefaults.standard.value(forKey: navi + "_" + "Work_min") as? String ?? "00") ?? 0
            let F_sec: Int = Int(UserDefaults.standard.value(forKey: navi + "_" + "Work_sec") as? String ?? "00") ?? 0
            
            if min == F_min
            {
                if (F_sec - min) == 3
                {
                    print("Work time left three seconds")
                }
                else if (F_sec - min) == 2
                {
                    print("Work time left two seconds")
                }
                else if (F_sec - min) == 1
                {
                    print("Work time left one second")
                    counter = 0
                    //                    Status.sharedInstance.putMovement(.Cycle_Rest)
                }
            }
            break
        case .Round_Rest:
            round_rest = minS + ":" + secS
            print("in_round_rest: \(round_rest)")
            break
        case .Cycle_Rest:
            cycle_rest = minS + ":" + secS
            print("in_cycle_rest: \(cycle_rest)")
            break
        }
        
        
        Lb_Work_Timer.text = minS + ":" + secS
        print("runningTimer: end")
        
        
    }
}

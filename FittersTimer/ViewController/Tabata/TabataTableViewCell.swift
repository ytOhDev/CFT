//
//  TabataTableViewCell.swift
//  FittersTimer
//
//  Created by PASSTECH on 25/04/2019.
//  Copyright © 2019 Taek. All rights reserved.
//

import UIKit

class TabataTableViewCell: UITableViewCell
{
    @IBOutlet weak var Lb_Content: UILabel!
    @IBOutlet weak var Lb_Time: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        Status.sharedInstance.putNavi(.Tabata)
        switch Lb_Content.text {
        case "Prepare":
            Status.sharedInstance.putState(.Prepare)
            
        case "WorkTime":
            Status.sharedInstance.putState(.Work)
            
        case "Round_Rest":
            Status.sharedInstance.putState(.Round_Rest)
            
        case "Round":
            Status.sharedInstance.putState(.Round)
            
        case "Cycle":
            Status.sharedInstance.putState(.Cycle)
            
        case "Cycle_Rest":
            Status.sharedInstance.putState(.Cycle_Rest)
            
        default:
            break
        }
    }
}

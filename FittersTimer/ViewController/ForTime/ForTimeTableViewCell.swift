//
//  ForTimeTableViewCell.swift
//  FittersTimer
//
//  Created by PASSTECH on 24/04/2019.
//  Copyright © 2019 Taek. All rights reserved.
//

import UIKit

class ForTimeTableViewCell: UITableViewCell
{
    @IBOutlet weak var Lb_Content: UILabel!
    @IBOutlet weak var Lb_Time: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        Status.sharedInstance.putNavi(.ForTime)
        switch Lb_Content.text {
        case "Prepare":
            Status.sharedInstance.putState(.Prepare)
            
        case "ForTime":
            Status.sharedInstance.putState(.Work)
            
        default:
            break
        }
    }
}

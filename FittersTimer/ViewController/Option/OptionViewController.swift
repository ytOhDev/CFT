//
//  OptionViewController.swift
//  FittersTimer
//
//  Created by PASSTECH on 2019/11/19.
//  Copyright © 2019 Taek. All rights reserved.
//

import UIKit

class OptionViewController: UIViewController {
    
    @IBOutlet weak var Lb_Title     : UILabel!
    @IBOutlet weak var Btn_Done     : UIButton!
    @IBOutlet weak var Btn_Back     : UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("OptionViewController viewDidLoad()")
        
        // Do any additional setup after loading the view.
       
        setInit()
    }
    
    func setInit()
    {
        let bounds = UIScreen.main.bounds
        let height = bounds.size.height
        print("height: \(height)")
        
        Lb_Title.dynamicFont(fontSize: 40)
        Btn_Done.titleLabel?.dynamicFont(fontSize: 20)
        Btn_Back.setImage(UIImage(named: Size.sharedInstance.getSizeImage(height, "left_arrow_blue")), for: .normal)
    }
    
    @IBAction func SwipedView(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func TappedCancelBtn(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func TappedDoneBtn(_ sender: Any) {
        dismiss(animated: true, completion: nil)
        
        UserDefaults.standard.set(Status.sharedInstance.color, forKey: "color")
        UserDefaults.standard.set(Status.sharedInstance.order, forKey: "order")
        
        print("color: \(Status.sharedInstance.color), order: \(Status.sharedInstance.order)")
    }
    
    
}

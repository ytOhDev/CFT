//
//  TabataViewController.swift
//  FittersTimer
//
//  Created by PASSTECH on 23/04/2019.
//  Copyright © 2019 Taek. All rights reserved.
//

import UIKit

class TabataViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var TabataTableView      : UITableView!
    @IBOutlet weak var Lb_Title             : UILabel!
    @IBOutlet weak var Btn_Go               : UIButton!
    
    var setFlag                             : Bool = false
    
    
    let array_Content = ["Prepare", "WorkTime", "Round", "Round_Rest", "Cycle", "Cycle_Rest"]
    var array_Time = ["00", "00:00", "01", "00:00", "01", "00:00"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("TabataViewController viewDidLoad()")
        
        // Do any additional setup after loading the view.
        
        TabataTableView.dataSource = self
        TabataTableView.delegate = self
        
        setInit()
    }
    
    func setInit()
    {
        Lb_Title.dynamicFont(fontSize: 40)
        Btn_Go.titleLabel?.dynamicFont(fontSize: 30)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("TabataViewController appear")
        
        loadTime()
        
        print("array_time: \(array_Time)")
        
        TabataTableView.reloadData()
    }
    
    @IBAction func GoBtnTapped(_ sender: Any)
    {
        if (UserDefaults.standard.value(forKey: "Tabata_Work") as? String != nil)
            && UserDefaults.standard.value(forKey: "Tabata_Work") as? String != "00:00"
        {
            Status.sharedInstance.putNavi(.Tabata)
            let startTimeViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "StartTime") as! StartTimeViewController
            startTimeViewController.modalPresentationStyle = .fullScreen
            self.present(startTimeViewController, animated: true, completion: nil)
        }
        else
        {
            _ = SweetAlert().showAlert("Set Work Time", subTitle: "Please set your work time", style: AlertStyle.warning)
        }
    }
    
    private func loadTime()
    {
        if let Tabata_Prepare = UserDefaults.standard.value(forKey: "Tabata_Prepare")
        {
            array_Time[0] = Tabata_Prepare as! String
        }
        else
        {
            array_Time[0] = "00"
        }
        
        if let Tabata_Work = UserDefaults.standard.value(forKey: "Tabata_Work")
        {
            array_Time[1] = Tabata_Work as! String
        }
        else
        {
            array_Time[1] = "00:00"
        }
        
        if let Tabata_Round = UserDefaults.standard.value(forKey: "Tabata_Round")
        {
            array_Time[2] = Tabata_Round as! String
        }
        else
        {
            array_Time[2] = "01"
        }
        
        if let Tabata_Round_Rest = UserDefaults.standard.value(forKey: "Tabata_Round_Rest")
        
        {
            array_Time[3] = Tabata_Round_Rest as! String
        }
        else
        {
            array_Time[3] = "00:00"
        }
        
        if let Tabata_Cycle = UserDefaults.standard.value(forKey: "Tabata_Cycle")
        {
            array_Time[4] = Tabata_Cycle as! String
        }
        else
        {
            array_Time[4] = "01"
        }
        
        if let Tabata_Cycle_Rest = UserDefaults.standard.value(forKey: "Tabata_Cycle_Rest")
        {
            array_Time[5] = Tabata_Cycle_Rest as! String
        }
        else
        {
            array_Time[5] = "00:00"
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array_Content.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TabataCell", for: indexPath) as? TabataTableViewCell
            else
        {
            fatalError("The dequeued cell is not an instance of TabataTableViewCell.")
        }
        cell.Lb_Content.dynamicFont(fontSize: 25)
        cell.Lb_Time.dynamicFont(fontSize: 35)
        
        cell.Lb_Content.text = array_Content[indexPath.row]
        cell.Lb_Time.text = array_Time[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        tableView.deselectRow(at: indexPath, animated: false)
        print("indexPath.row: \(indexPath.row)")
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let bounds = UIScreen.main.bounds
        let height = bounds.size.height
        print("height: \(height)")
        
        return Size.sharedInstance.getTableRowHeight(height)
    }
    
}

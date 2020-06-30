//
//  EMOMViewController.swift
//  FittersTimer
//
//  Created by PASSTECH on 23/04/2019.
//  Copyright © 2019 Taek. All rights reserved.
//

import UIKit

class EMOMViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var AmrapTableView       : UITableView!
    @IBOutlet weak var Lb_Title             : UILabel!
    @IBOutlet weak var Btn_Go               : UIButton!
    
    var setFlag                             : Bool = false
    
    let array_Content = ["Prepare", "Min"]
    var array_Time = ["00", "00"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("AmrapViewController viewDidLoad()")
        
        // Do any additional setup after loading the view.
        
        AmrapTableView.dataSource = self
        AmrapTableView.delegate = self
        
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
        print("AmrapViewController viewWillAppear")
        
        loadTime()
        
        print("array_Time: \(array_Time)")
        
        AmrapTableView.reloadData()
    }
    
    @IBAction func GoBtnTapped(_ sender: Any)
    {
        if (UserDefaults.standard.value(forKey: "EMOM_Work") as? String == nil)
        {
            UserDefaults.standard.set("01:00", forKey: "EMOM_Work")
            UserDefaults.standard.set("01", forKey: "EMOM_Work_M")
            UserDefaults.standard.set("00", forKey: "EMOM_Work_S")
        }
        Status.sharedInstance.putNavi(.EMOM)
        let startTimeViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "StartTime") as! StartTimeViewController
        startTimeViewController.modalPresentationStyle = .fullScreen
        self.present(startTimeViewController, animated: true, completion: nil)
    }
    
    private func loadTime()
    {
        if let EMOM_Prepare = UserDefaults.standard.value(forKey: "EMOM_Prepare")
        {
            array_Time[0] = EMOM_Prepare as! String
        }
        else
        {
            array_Time[0] = "00"
        }
        
        if let EMOM_Work = UserDefaults.standard.value(forKey: "EMOM_Work")
        {
            array_Time[1] = EMOM_Work as! String
        }
        else
        {
            array_Time[1] = "01:00"
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array_Content.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "EMOMCell", for: indexPath) as? EMOMTableViewCell
        else
        {
            fatalError("The dequeued cell is not an instance of EMOMTableViewCell.")
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

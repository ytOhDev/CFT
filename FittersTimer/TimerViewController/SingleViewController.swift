////
////  SingleViewController.swift
////  FittersTimer
////
////  Created by PASSTECH on 19/04/2019.
////  Copyright © 2019 Taek. All rights reserved.
////
//
//import UIKit
//
//class SingleViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
//
//    @IBOutlet weak var TimePicker: UIPickerView!
//    @IBOutlet weak var SingleViewTitle: UILabel!
//
//    var pickerData: [String] = [String]()
//    var second: [String] = [String]()
//
//    var selectedSecond: String = ""
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        // Do any additional setup after loading the view.
//
//        TimePicker.delegate = self
//        TimePicker.dataSource = self
//
//        for i in 0 ..< 60
//        {
//            var temp = String(i)
//            if i < 10
//            {
//                temp = "0" + temp
//            }
//            second.append(temp)
//        }
//
//        pickerData = second
//
//    }
//
//    override func viewDidAppear(_ animated: Bool) {
//        print("SingleViewController appear")
//
//
//    }
//
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
//
//
//    @IBAction func SelectBtnTapped(_ sender: Any)
//    {
//        print("SelectBtnTapped")
//        self.dismiss(animated: true, completion: nil)
//    }
//
//    @IBAction func CancelBtnTapped(_ sender: Any)
//    {
//        print("CancelBtnTapped")
//        self.dismiss(animated: true, completion: nil)
//    }
//
//
//    func numberOfComponents(in pickerView: UIPickerView) -> Int {
//        return 1
//    }
//
//    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
//        return pickerData.count
//    }
//
//    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
//        return pickerData[row]
//    }
//
//    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) { // 선택한 conponent를 기준으로 데이터 검색 후, 값 저장
//
//        selectedSecond = pickerData[row]
//        print("selectedSecond: \(selectedSecond)")
//
//    }
//
//    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
//        return 140
//    }
//
//    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
//        var label: UILabel
//        if let view = view as? UILabel { label = view }
//        else { label = UILabel() }
//
//        label.font = UIFont (name: "Helvetica Neue", size: 60)
//        label.text = pickerData[row]
//        label.textAlignment = .center
//        return label
//    }
//
//    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
//        return 80
//    }
//
//}

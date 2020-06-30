//
//  Extenstion.swift
//  FittersTimer
//
//  Created by PASSTECH on 2020/06/16.
//  Copyright © 2020 Taek. All rights reserved.
//

import Foundation
import UIKit

extension UILabel {
    func dynamicFont(fontSize size: CGFloat) {
        let currentFontName = self.font.fontName
//        let currentFontSize = self.font.pointSize
        let currentFontSize = size
        var calculatedFont: UIFont?
        let bounds = UIScreen.main.bounds
        let height = bounds.size.height
        print("currentFontName: \(currentFontName), height: \(height)")
        switch height {
        case 480.0: //Iphone 3,4S => 3.5 inch
            self.font = UIFont(name: currentFontName, size: currentFontSize * 0.65)
            break
        case 568.0: //iphone 5, SE => 4 inch
            self.font = UIFont(name: currentFontName, size: currentFontSize * 0.8)
            break
        case 667.0: //iphone 6, 6s, 7, 8 => 4.7 inch
            self.font = UIFont(name: currentFontName, size: currentFontSize * 0.92)
            break
        case 736.0: //iphone 6s+ 6+, 7+, 8+ => 5.5 inch
            self.font = UIFont(name: currentFontName, size: currentFontSize * 0.95)
            break
        case 812.0: //iphone X, XS => 5.8 inch
            self.font = UIFont(name: currentFontName, size: currentFontSize)
            break
        case 896.0: //iphone XR => 6.1 inch  // iphone XS MAX => 6.5 inch
            self.font = UIFont(name: currentFontName, size: currentFontSize * 1.12)
            break
        case 1024.0: //iPad Pro, iPad mini => 9.7 inch
            self.font = UIFont(name: currentFontName, size: currentFontSize * 1.65)
            break
        case 1080.0: //iPad (7th generation), iPad Pro, iPad Air => 10.2 inch
            self.font = UIFont(name: currentFontName, size: currentFontSize * 1.8)
            break
        case 1112.0: //iPad Air (3th generation) => 10.5 inch
            self.font = UIFont(name: currentFontName, size: currentFontSize * 1.8)
            break
        case 1194.0: //iPad (2nd generation) => 11 inch
            self.font = UIFont(name: currentFontName, size: currentFontSize * 1.9)
            break
        case 1366.0: //iPad (3, 4nd generation) => 12.9 inch
            self.font = UIFont(name: currentFontName, size: currentFontSize * 2.2)
            break

        default:
            print("not an iPhone")
            break
        }
    }
    
    private func resizeFont(calculatedFont: UIFont?) {
        self.font = calculatedFont
        self.font = UIFont.systemFont(ofSize: calculatedFont!.pointSize)
    }
}

extension UISwitch {
    func dynamicSize() {
        let bounds = UIScreen.main.bounds
        let height = bounds.size.height
        
        switch height {
        case 480.0: //Iphone 3,4S => 3.5 inch
            self.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
        case 568.0: //iphone 5, SE => 4 inch
            self.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        case 667.0: //iphone 6, 6s, 7, 8 => 4.7 inch
            self.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        case 736.0: //iphone 6s+ 6+, 7+, 8+ => 5.5 inch
            self.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        case 812.0: //iphone X, XS => 5.8 inch
            self.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        case 896.0: //iphone XR => 6.1 inch  // iphone XS MAX => 6.5 inch
            self.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
        case 1024.0: //iPad Pro, iPad mini => 9.7 inch
            self.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
        case 1080.0: //iPad (7th generation), iPad Pro, iPad Air => 10.2 inch
            self.transform = CGAffineTransform(scaleX: 1.7, y: 1.7)
        case 1112.0: //iPad Air (3th generation) => 10.5 inch
            self.transform = CGAffineTransform(scaleX: 1.7, y: 1.7)
        case 1194.0: //iPad (2nd generation) => 11 inch
            self.transform = CGAffineTransform(scaleX: 1.8, y: 1.8)
        case 1366.0: //iPad (3, 4nd generation) => 12.9 inch
            self.transform = CGAffineTransform(scaleX: 2.0, y: 2.0)
            
        default:
            self.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        }
    }
}


class Size: NSObject
{
    static let sharedInstance = Size()
    
    func getFontSize(_ size: CGFloat) -> CGFloat
    {
        let currentFontSize = size
        let bounds = UIScreen.main.bounds
        let height = bounds.size.height
        switch height {
        case 480.0: //Iphone 3,4S => 3.5 inch
            return currentFontSize * 0.65
        case 568.0: //iphone 5, SE => 4 inch
            return currentFontSize * 0.8
        case 667.0: //iphone 6, 6s, 7, 8 => 4.7 inch
            return currentFontSize * 0.92
        case 736.0: //iphone 6s+ 6+, 7+, 8+ => 5.5 inch
            return currentFontSize * 0.95
        case 812.0: //iphone X, XS => 5.8 inch
            return currentFontSize * 1.0
        case 896.0: //iphone XR => 6.1 inch  // iphone XS MAX => 6.5 inch
            return currentFontSize * 1.12
        case 1024.0: //iPad Pro, iPad mini => 9.7 inch
            return currentFontSize * 1.65
        case 1080.0: //iPad (7th generation), iPad Pro, iPad Air => 10.2 inch
            return currentFontSize * 1.8
        case 1112.0: //iPad Air (3th generation) => 10.5 inch
            return currentFontSize * 1.8
        case 1194.0: //iPad (2nd generation) => 11 inch
            return currentFontSize * 1.9
        case 1366.0: //iPad (3, 4nd generation) => 12.9 inch
            return currentFontSize * 2.2
            
        default:
            return currentFontSize * 1.0
        }
    }
    
    func getMenuHeight(_ boundHeight: CGFloat, height: CGFloat) -> CGFloat
    {
        let height = boundHeight
        let currentHeight = height
        
        switch height {
        case 480.0: //Iphone 3,4S => 3.5 inch
            return currentHeight * 0.7
        case 568.0: //iphone 5, SE => 4 inch
            return currentHeight * 0.8
        case 667.0: //iphone 6, 6s, 7, 8 => 4.7 inch
            return currentHeight * 0.9
        case 736.0: //iphone 6s+ 6+, 7+, 8+ => 5.5 inch
            return currentHeight * 0.95
        case 812.0: //iphone X, XS => 5.8 inch
            return currentHeight * 1.0
        case 896.0: //iphone XR => 6.1 inch  // iphone XS MAX => 6.5 inch
            return currentHeight * 1.1
        case 1024.0: //iPad Pro, iPad mini => 9.7 inch
            return currentHeight * 1.5
        case 1080.0: //iPad (7th generation), iPad Pro, iPad Air => 10.2 inch
            return currentHeight * 1.8
        case 1112.0: //iPad Air (3th generation) => 10.5 inch
            return currentHeight * 1.8
        case 1194.0: //iPad (2nd generation) => 11 inch
            return currentHeight * 1.9
        case 1366.0: //iPad (3, 4nd generation) => 12.9 inch
            return currentHeight * 2.2
        default:
            return currentHeight
        }
    }
    
    func getTableRowHeight(_ boundHeight: CGFloat) -> CGFloat
    {
        let height = boundHeight
        
        switch height {
        case 480.0: //Iphone 3,4S => 3.5 inch
            return 50.0
        case 568.0: //iphone 5, SE => 4 inch
            return 55.5
        case 667.0: //iphone 6, 6s, 7, 8 => 4.7 inch
            return 60.0
        case 736.0: //iphone 6s+ 6+, 7+, 8+ => 5.5 inch
            return 60.0
        case 812.0: //iphone X, XS => 5.8 inch
            return 60.0
        case 896.0: //iphone XR => 6.1 inch  // iphone XS MAX => 6.5 inch
            return 70.0
        case 1024.0: //iPad Pro, iPad mini => 9.7 inch
            return 90.0
        case 1080.0: //iPad (7th generation), iPad Pro, iPad Air => 10.2 inch
            return 100.0
        case 1112.0: //iPad Air (3th generation) => 10.5 inch
            return 105.0
        case 1194.0: //iPad (2nd generation) => 11 inch
            return 110.0
        case 1366.0: //iPad (3, 4nd generation) => 12.9 inch
            return 120.0
        default:
            return 60.0
        }
    }
    
    func getPickerViewWidth(_ boundHeight: CGFloat) -> CGFloat
    {
        let height = boundHeight
        
        switch height {
        case 480.0: //Iphone 3,4S => 3.5 inch
            return 115.0
        case 568.0: //iphone 5, SE => 4 inch
            return 120.0
        case 667.0: //iphone 6, 6s, 7, 8 => 4.7 inch
            return 125.0
        case 736.0: //iphone 6s+ 6+, 7+, 8+ => 5.5 inch
            return 140.0
        case 812.0: //iphone X, XS => 5.8 inch
            return 130.0
        case 896.0: //iphone XR => 6.1 inch  // iphone XS MAX => 6.5 inch
            return 140.0
        case 1024.0: //iPad Pro, iPad mini => 9.7 inch
            return 250.0
        case 1080.0: //iPad (7th generation), iPad Pro, iPad Air => 10.2 inch
            return 270.0
        case 1112.0: //iPad Air (3th generation) => 10.5 inch
            return 280.0
        case 1194.0: //iPad (2nd generation) => 11 inch
            return 290.0
        case 1366.0: //iPad (3, 4nd generation) => 12.9 inch
            return 350.0
        default:
            return 140.0
        }
    }
    
    func getSizeImage(_ boundHeight: CGFloat, _ name: String) -> String
    {
        let height = boundHeight
        
        switch height {
        case 480.0: //Iphone 3,4S => 3.5 inch
            return name + "_24"
        case 568.0: //iphone 5, SE => 4 inch
            return name + "_24"
        case 667.0: //iphone 6, 6s, 7, 8 => 4.7 inch
            return name + "_24"
        case 736.0: //iphone 6s+ 6+, 7+, 8+ => 5.5 inch
            return name + "_24"
        case 812.0: //iphone X, XS => 5.8 inch
            return name + "_24"
        case 896.0: //iphone XR => 6.1 inch  // iphone XS MAX => 6.5 inch
            return name + "_24"
        case 1024.0: //iPad Pro, iPad mini => 9.7 inch
            return name + "_48"
        case 1080.0: //iPad (7th generation), iPad Pro, iPad Air => 10.2 inch
            return name + "_48"
        case 1112.0: //iPad Air (3th generation) => 10.5 inch
            return name + "_48"
        case 1194.0: //iPad (2nd generation) => 11 inch
            return name + "_48"
        case 1366.0: //iPad (3, 4nd generation) => 12.9 inch
            return name + "_48"
        default:
            return name + "_24"
        }
    }
}

//
//  MainController.swift
//  FittersTimer
//
//  Created by PASSTECH on 19/04/2019.
//  Copyright © 2019 Taek. All rights reserved.
//

import UIKit
import PagingMenuController

class MainController: UIViewController {
    
    var topSafeArea          : CGFloat!
    var bottomSafeArea       : CGFloat!

    var bounds: CGRect!
    var height: CGFloat!
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        print("viewWillLayoutSubviews")
        
        view.backgroundColor = UIColor.white

        if #available(iOS 11.0, *) {
            topSafeArea = view.safeAreaInsets.top
            bottomSafeArea = view.safeAreaInsets.bottom
        } else {
            topSafeArea = topLayoutGuide.length
            bottomSafeArea = bottomLayoutGuide.length
        }


        bounds = UIScreen.main.bounds
        height = bounds.size.height

        let options = PagingMenuOptions()
        let pagingMenuController = PagingMenuController(options: options)

        pagingMenuController.view.frame = CGRect(x: 0, y: 0 + topSafeArea, width: self.view.frame.width, height: self.view.frame.height - topSafeArea - bottomSafeArea)
        pagingMenuController.onMove = { state in
            switch state {
            case let .willMoveController(menuController, previousMenuController):
                break
            case let .didMoveController(menuController, previousMenuController):
                break
            case let .willMoveItem(menuItemView, previousMenuItemView):
                break
            case let .didMoveItem(menuItemView, previousMenuItemView):
                break
            case .didScrollStart:
                break
            case .didScrollEnd:
                break
            }
        }

        addChildViewController(pagingMenuController)
        view.addSubview(pagingMenuController.view)
        pagingMenuController.didMove(toParentViewController: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("viewDidLoad")
        UIApplication.shared.isIdleTimerDisabled = true
    }
    
}

private struct PagingMenuOptions: PagingMenuControllerCustomizable {
    let viewController1 = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Tabata") as! TabataViewController
    let viewController2 = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ForTime") as! ForTimeViewController
    let viewController3 = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "EMOM") as! EMOMViewController
    
    fileprivate var componentType: ComponentType {
        return .all(menuOptions: MenuOptions(), pagingControllers: pagingControllers)
    }
    
    fileprivate var pagingControllers: [UIViewController] {
        return [viewController1, viewController2, viewController3]
    }
    
    fileprivate struct MenuOptions: MenuViewCustomizable {
        var displayMode: MenuDisplayMode {
            return .segmentedControl
        }
        var itemsOptions: [MenuItemViewCustomizable] {
            return [MenuItem1(), MenuItem2(), MenuItem3()]
        }
        var menuPosition: MenuPosition {
            return .bottom
        }
        var height: CGFloat {
            let bounds = UIScreen.main.bounds
            let height = bounds.size.height
            let currentHeight: CGFloat = 60.0
            print("height: \(height)")
            
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
            case 1080.0: //iPad (7th generation), iPad Pro, iPad Air => 10.5 inch
                return currentHeight * 1.8
            case 1194.0: //iPad (2nd generation) => 11 inch
                return currentHeight * 1.9
            case 1366.0: //iPad (3, 4nd generation) => 12.9 inch
                return currentHeight * 2.2
            default:
                return currentHeight
            }
        }
    }
    
    fileprivate struct MenuItem1: MenuItemViewCustomizable {
        var displayMode: MenuItemDisplayMode {
            
            let text = MenuItemText(text: "Tabata", color: UIColor.lightGray, selectedColor: UIColor.black, font: UIFont(name: "SF Sports Night NS Upright", size: Size.sharedInstance.getFontSize(18))!, selectedFont: UIFont(name: "SF Sports Night NS Upright", size: Size.sharedInstance.getFontSize(18))!)
            return .text(title: text)
        }
    }
    fileprivate struct MenuItem2: MenuItemViewCustomizable {
        var displayMode: MenuItemDisplayMode {
            let text = MenuItemText(text: "ForTime", color: UIColor.lightGray, selectedColor: UIColor.black, font: UIFont(name: "SF Sports Night NS Upright", size: Size.sharedInstance.getFontSize(18))!, selectedFont: UIFont(name: "SF Sports Night NS Upright", size: Size.sharedInstance.getFontSize(18))!)
            return .text(title: text)
        }
    }
    fileprivate struct MenuItem3: MenuItemViewCustomizable {
        var displayMode: MenuItemDisplayMode {
            let text = MenuItemText(text: "EMOM", color: UIColor.lightGray, selectedColor: UIColor.black, font: UIFont(name: "SF Sports Night NS Upright", size: Size.sharedInstance.getFontSize(18))!, selectedFont: UIFont(name: "SF Sports Night NS Upright", size: Size.sharedInstance.getFontSize(18))!)
            return .text(title: text)
        }
    }
    
    
}


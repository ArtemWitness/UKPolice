//
//  UI.swift
//  UK Police
//
//  Created by Artem Trembach on 01.02.2020.
//  Copyright © 2020 Artem Trembach. All rights reserved.
//

import UIKit

// variable for smooth bouncy animations
let allAnimDamp : CGFloat = 0.675
let allAnimvel : CGFloat = 0
// variable for controll viewWillAppear-animation in MainVC
var mainVCAnimController : String = "begin"



// List of fonts
// --------------------------------------------------------------------------------------------- //
struct uiFonts {
    static var Molot : String = "Molot"
}

        
        
// List of colors
// --------------------------------------------------------------------------------------------- //
struct uiColors {
    static var DarkBlue : String = "#49516f"
    static var LightBlue : String = "#9196ae"
    static var Light : String = "#eff6ee"
    static var Red : String = "#f02d3a"
    static var Dark : String = "#02111b"
}



// Label setup
// --------------------------------------------------------------------------------------------- //
func setupLabel(label: UILabel, size: String, color: String) {
    label.textColor = hexStringToUIColor(hex: color)
    if size == "tiny" {
        label.font = UIFont(name:uiFonts.Molot, size: 15)
    } else if size == "small" {
        label.font = UIFont(name:uiFonts.Molot, size: 20)
    } else if size == "normal" {
        label.font = UIFont(name:uiFonts.Molot, size: 30)
    } else if size == "huge" {
        label.font = UIFont(name:uiFonts.Molot, size: 40)
    }
    
}



// HEX to UIColor
// --------------------------------------------------------------------------------------------- //
func hexStringToUIColor (hex:String) -> UIColor {
    var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
    if (cString.hasPrefix("#")) { cString.remove(at: cString.startIndex) }
    if ((cString.count) != 6) { return UIColor.gray }
    var rgbValue:UInt32 = 0
    Scanner(string: cString).scanHexInt32(&rgbValue)
    return UIColor(
        red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
        green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
        blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
        alpha: CGFloat(1.0)
    )
}



// View borders setup
// --------------------------------------------------------------------------------------------- //
extension UIView {
    func addDashBorder() {
        let color = hexStringToUIColor(hex: uiColors.Light).cgColor
        let shapeLayer:CAShapeLayer = CAShapeLayer()
        let frameSize = self.frame.size
        let shapeRect = CGRect(x: 0, y: 0, width: frameSize.width, height: frameSize.height)
        shapeLayer.bounds = shapeRect
        shapeLayer.name = "DashBorder"
        shapeLayer.position = CGPoint(x: frameSize.width/2, y: frameSize.height/2)
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = color
        shapeLayer.lineWidth = 2
        shapeLayer.lineJoin = .round
        shapeLayer.lineDashPattern = [2,4]
        shapeLayer.path = UIBezierPath(roundedRect: shapeRect, cornerRadius: 0).cgPath
        self.layer.masksToBounds = false
        self.layer.addSublayer(shapeLayer)
    }
    
    
    func addBorder() {
        let color = hexStringToUIColor(hex: uiColors.Light).cgColor
        let shapeLayer:CAShapeLayer = CAShapeLayer()
        let frameSize = self.frame.size
        let shapeRect = CGRect(x: 0, y: 0, width: frameSize.width, height: frameSize.height)
        shapeLayer.bounds = shapeRect
        shapeLayer.name = "DashBorder"
        shapeLayer.position = CGPoint(x: frameSize.width/2, y: frameSize.height/2)
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = color
        shapeLayer.lineWidth = 2
        shapeLayer.lineJoin = .round
        shapeLayer.lineDashPattern = [2,0]
        shapeLayer.path = UIBezierPath(roundedRect: shapeRect, cornerRadius: 0).cgPath
        self.layer.masksToBounds = false
        self.layer.addSublayer(shapeLayer)
    }
}

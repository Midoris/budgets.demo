//
//  Color+extensions.swift
//  Budgets
//
//  Created by IEVGENII IABLONSKYI on 10.01.19.
//  Copyright © 2019 IEVGENII IABLONSKYI. All rights reserved.
//

import UIKit

extension UIColor {

    static let red = colorFromHex(hex: 0xEA515D)
    static let green = colorFromHex(hex: 0x62D4A8)
    static let textGrey = colorFromHex(hex: 0x72808B)
    static let yellowBackground = colorFromHex(hex: 0xEE9A37)
//    static let lightRed = colorFromHex(hex: 0xFF4477)
//    static let lavenderPurple = colorFromHex(hex: 0x8888AA)
//    static let midnightPurple = colorFromHex(hex: 0x222244)
//    static let malibuBlue = colorFromHex(hex: 0x00bbff)
//    static let steelGrey = colorFromHex(hex: 0x6a7385)
//    static let vividRed = colorFromHex(hex: 0xf00000)
//    static let dusk = colorFromHex(hex: 0x544f7c)
//    static let paleGrey = colorFromHex(hex: 0xf6f7f8)
//    static let lightPink = colorFromHex(hex: 0xffdfe0)
    
    static func midnightPurple(at alpha: CGFloat) -> UIColor {
        return colorFromHex(hex: 0x222244).withAlphaComponent(alpha)
    }
    
    static func lavenderPurple(at alpha: CGFloat) -> UIColor {
        return colorFromHex(hex: 0x8888AA).withAlphaComponent(alpha)
    }
    
    static func lightRed(at alpha: CGFloat) -> UIColor {
        return colorFromHex(hex: 0xFF4477).withAlphaComponent(alpha)
    }
    
    static func malibuBlue(at alpha: CGFloat) -> UIColor {
        return colorFromHex(hex: 0x00bbff).withAlphaComponent(alpha)
    }
    
    static func steelGrey(at alpha: CGFloat) -> UIColor {
        return colorFromHex(hex: 0x6a7385).withAlphaComponent(alpha)
    }
    
    static func hex(hex: Int) -> UIColor { return colorFromHex(hex: hex) }
    
    static func rgba(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) -> UIColor {
        return colorFromRGBA(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    private static func colorFromHex(hex: Int) -> UIColor {
        let components = (
            R: CGFloat((hex >> 16) & 0xff) / 255,
            G: CGFloat((hex >> 08) & 0xff) / 255,
            B: CGFloat((hex >> 00) & 0xff) / 255
        )
        return UIColor(red: components.R, green: components.G, blue: components.B, alpha: 1)
    }
    
    private static func colorFromRGBA(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) -> UIColor {
        return UIColor(red: red / 255.0, green: green / 255.0, blue: blue / 255.0, alpha: alpha)
    }
}

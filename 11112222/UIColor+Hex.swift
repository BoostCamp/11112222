//
//  UIColor+Hex.swift
//  11112222
//
//  Created by Dongyoon Kang on 2017. 2. 17..
//  Copyright © 2017년 Dongyoon Kang. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(netHex:Int) {
        self.init(red:(netHex >> 16) & 0xff, green:(netHex >> 8) & 0xff, blue:netHex & 0xff)
    }
    
    struct FlatColor {
        struct White {
            static let Smoke = UIColor(netHex: 0xF5F5F5)
        }
        struct Green {
            static let Fern = UIColor(netHex: 0x6ABB72)
            static let MountainMeadow = UIColor(netHex: 0x3ABB9D)
            static let ChateauGreen = UIColor(netHex: 0x4DA664)
            static let PersianGreen = UIColor(netHex: 0x2CA786)
        }
        
        struct Blue {
            static let PictonBlue = UIColor(netHex: 0x5CADCF)
            static let Mariner = UIColor(netHex: 0x3585C5)
            static let CuriousBlue = UIColor(netHex: 0x4590B6)
            static let Denim = UIColor(netHex: 0x2F6CAD)
            static let Chambray = UIColor(netHex: 0x485675)
            static let BlueWhale = UIColor(netHex: 0x29334D)
        }
        
        struct Violet {
            static let Wisteria = UIColor(netHex: 0x9069B5)
            static let BlueGem = UIColor(netHex: 0x533D7F)
        }
        
        struct Yellow {
            static let Energy = UIColor(netHex: 0xF2D46F)
            static let Turbo = UIColor(netHex: 0xF7C23E)
        }
        
        struct Orange {
            static let NeonCarrot = UIColor(netHex: 0xF79E3D)
            static let Sun = UIColor(netHex: 0xEE7841)
        }
        
        struct Red {
            static let TerraCotta = UIColor(netHex: 0xE66B5B)
            static let Valencia = UIColor(netHex: 0xCC4846)
            static let Cinnabar = UIColor(netHex: 0xDC5047)
            static let WellRead = UIColor(netHex: 0xB33234)
        }
        
        struct Gray {
            static let AlmondFrost = UIColor(netHex: 0xA28F85)
            static let WhiteSmoke = UIColor(netHex: 0xEFEFEF)
            static let Iron = UIColor(netHex: 0xD1D5D8)
            static let IronGray = UIColor(netHex: 0x75706B)
        }
        struct AppColor {
            static let ChiliPepper = UIColor(netHex: 0x9B1B30)
        }
        
        struct CardColor {
            static let pantone2445 : Int = 0xE28691
            static let purple : Int = 0xA778BB
            static let darkBlue : Int = 0x6271B3
//            static let Pantone3519CP = UIColor(netHex: 0xE6A6A7)
//            static let Pantone3568UP = UIColor(netHex: 0xEFC6D2)
            
            
            //TEST
//            static let Pantone2434UP = UIColor(netHex: 0xDF6B56)
//            static let Pantone2448UP = UIColor(netHex: 0xD6685A)
            
            // Card Main Color
            static let Purple = UIColor(netHex: purple)
            static let Pantone2445CP = UIColor(netHex: pantone2445)
//            static let LightPurple = UIColor(netHex: 0xDBBBD3)
//            static let BrightBlue = UIColor(netHex: 0xC1D0EB)
            static let DarkBlue = UIColor(netHex: darkBlue)
            
            // Card Body Color
            static let SmokeWhite = UIColor(netHex: 0xF7F3F0)
        }
    }
    
    static func getMainColorHexValue() -> Int {
        
        var colorNumber : Int!
        let randomNum = arc4random() % 3
        switch randomNum {
        case 0:
            colorNumber = FlatColor.CardColor.pantone2445
        case 1:
            colorNumber = FlatColor.CardColor.purple
        case 2:
            colorNumber = FlatColor.CardColor.darkBlue
        default: break
        }
        
        return colorNumber

    }
    
    static func getRandomColor() -> UIColor{
        
        let pColor1: UIColor = FlatColor.CardColor.Purple
        
//        let pColor2:UIColor = FlatColor.CardColor.LightPurple
        
        let pColor3: UIColor = FlatColor.CardColor.Pantone2445CP
        
        let pColor4: UIColor = FlatColor.CardColor.DarkBlue
        
        let randomNum = arc4random() % 3
        var color = UIColor()
        switch randomNum {
        case 0:
            color = pColor1
        case 1:
            color = pColor4
        case 2:
            color = pColor3
        default: break
        }
        
        return color
    }
}

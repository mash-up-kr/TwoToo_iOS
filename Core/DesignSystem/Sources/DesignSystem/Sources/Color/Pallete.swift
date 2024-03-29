//
//  Pallete.swift
//  
//
//  Created by Julia on 2023/06/10.
//

import UIKit

public enum Pallete: String {
    
    case primary = "Primary"
    
    // MARK: - Main Color
    case mainCoral = "Main_Coral"
    case mainLightPink = "Main_LightPink"
    case mainPink = "Main_Pink"
    case mainWhite = "Main_White"
    
    // MARK: - Secondary Color
    case second01 = "Second_01"
    case second02 = "Second_02"
    
    // MARK: - Gray Color
    case grey200 = "Grey_200"
    case grey300 = "Grey_300"
    case grey400 = "Grey_400"
    case grey500 = "Grey_500"
    case grey600 = "Grey_600"
    case grey700 = "Grey_700"
    
    public static func setColor(_ pallete: Pallete) -> UIColor {
        guard let palleteColor = UIColor(named: pallete.rawValue, in: Bundle.module, compatibleWith: nil) else {
            return UIColor.clear
        }
        return palleteColor
    }

    /// cgColor
    public static func setColor(_ pallete: Pallete) -> CGColor {
        guard let palleteColor = UIColor(named: pallete.rawValue, in: Bundle.module, compatibleWith: nil) else {
            return UIColor.clear.cgColor
        }
        return palleteColor.cgColor
    }
}

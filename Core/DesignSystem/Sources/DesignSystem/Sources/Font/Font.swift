//
//  Font.swift
//  
//
//  Created by Julia on 2023/06/09.
//

import UIKit

public enum Font {
    
    public enum Name: String {
        case omyupretty = "OmyuPretty"
    }

    public enum Size: CGFloat {
        case _12 = 12
        case _15 = 15
        case _16 = 16
        case _18 = 18
        case _20 = 20
        case _24 = 24
        case _28 = 28
    }
    
    public enum Extension: String {
        case ttf
        case otf
    }
    
    public struct TTFont {
        private let _name: Name
        private let _extension: Extension

        init(name: Name = .omyupretty, extensions: Extension = .ttf) {
            self._name = name
            self._extension = extensions
        }

        var name: String {
            "\(_name.rawValue)"
        }

        var `extension`: String {
            _extension.rawValue
        }
    }

}


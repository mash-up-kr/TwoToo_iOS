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
    
    /// 폰트 파일 등록
    /// - 앱 초기에 최초 한 번 실행됩니다.
    // TODO: AppDelegate에 `Font.registerFonts()` 해야함
    public static func registerTTFont() {
        let font: TTFont = TTFont()
        Font.registerFont(fontName: font.name, fontExtension: font.extension)
    }
    
}

extension Font {
    
    /// 폰트 파일 등록
    /// - Parameters:
    ///   - fontName: 등록할 폰트 파일의 이름
    ///   - fontExtension: 등록할 폰트 파일의 확장자
    static func registerFont(fontName: String, fontExtension: String) {
        
        let bundle: Bundle = Bundle.module

        guard let fontURL = bundle.url(forResource: fontName,
                                              withExtension: fontExtension) else {
            fatalError("Couldn't find font \(fontName).\(fontExtension)")
        }

        guard let fontDataProvider = CGDataProvider(url: fontURL as CFURL) else {
            fatalError("Couldn't load data from the font \(fontName)")
        }

        guard let font = CGFont(fontDataProvider) else {
            fatalError("Couldn't create font from data")
        }

        var error: Unmanaged<CFError>?
        CTFontManagerRegisterGraphicsFont(font, &error)
        
    }
    
}

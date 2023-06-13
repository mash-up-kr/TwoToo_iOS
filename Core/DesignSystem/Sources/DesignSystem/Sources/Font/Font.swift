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
    
    private static var bundleId: String { "kr.mash-up.TwoToo.DesignSystem" }
    
    /// 폰트 파일 등록
    /// - Parameters:
    ///   - bundle: 등록할 폰트 파일이 존재하는 Bundle
    ///   - fontName: 등록할 폰트 파일의 이름
    ///   - fontExtension: 등록할 폰트 파일의 확장자
    public static func registerFont(fontName: String, fontExtension: String) {
        guard let fontURL = Bundle(identifier: bundleId)?.url(forResource: fontName,
                                                              withExtension: fontExtension),
              let fontDataProvider = CGDataProvider(url: fontURL as CFURL),
              let font = CGFont(fontDataProvider) else {
            debugPrint("Couldn't create font from filename: \(fontName) with extension \(fontExtension)")
            return
        }
        var error: Unmanaged<CFError>?
        CTFontManagerRegisterGraphicsFont(font, &error)
    }
    
}

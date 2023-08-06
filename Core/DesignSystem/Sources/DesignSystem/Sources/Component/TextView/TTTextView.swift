//
//  TTTextView.swift
//  
//
//  Created by Julia on 2023/06/25.
//

import UIKit

public protocol TTTextViewDelegate: AnyObject {
    func textViewDidEndEditing(text: String)
    func textViewDidChange(text: String)
}

public extension TTTextViewDelegate {
    func textViewDidEndEditing(text: String) {}
    func textViewDidChange(text: String) {}
}

public final class TTTextView: UITextView {
    
    public weak var customDelegate: TTTextViewDelegate?
    
    private var placeHolderText: String = ""
    private var maxCount: Int = 0
    
    private lazy var placeHolderLabel: UILabel = {
        let v = UILabel()
        v.font = .body1
        v.textColor = .grey500
        v.numberOfLines = 0
        return v
    }()
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        
        self.layout()
        self.attribute()
        self.delegate = self
    }
    
    public convenience init(placeHolder: String, maxCount: Int) {
        self.init()
        
        self.layout()
        self.attribute()
        self.delegate = self
        
        self.placeHolderText = placeHolder
        self.placeHolderLabel.text = placeHolder
        self.maxCount = maxCount
    }
     
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layout() {
        self.addSubview(self.placeHolderLabel)
        
        self.placeHolderLabel.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().offset(5)
        }
    }
    
    private func attribute() {
        self.contentInset = .init(top: 10, left: 10, bottom: 10, right: 10)
        self.backgroundColor = .mainWhite
        self.font = .body1
        self.textColor = .black
        self.isEditable = true
        self.layer.cornerRadius = 10
    }
}

extension TTTextView: UITextViewDelegate {
    
    public func textViewDidEndEditing(_ textView: UITextView) {
        self.customDelegate?.textViewDidEndEditing(text: textView.text)
    }
    
    public func textViewDidChange(_ textView: UITextView) {
        if textView.text != nil && !textView.text.isEmpty {
            self.placeHolderLabel.text = ""
            textView.textColor = .black
        }
        else {
            self.placeHolderLabel.text = self.placeHolderText
        }

        if self.text.count > self.maxCount {
        // 글자수 제한에 걸리면 마지막 글자를 삭제함.
            self.text.removeLast()
        }

        self.customDelegate?.textViewDidChange(text: textView.text)
    }

    public func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let newLength = self.text.count - range.length + text.count
        let maxCount = self.maxCount
         
         if newLength > maxCount {
             let overflow = newLength - maxCount
             if text.count < overflow {
                 return true
             }
             let index = text.index(text.endIndex, offsetBy: -overflow)
             let newText = text[..<index]
             guard let startPosition = textView.position(from: textView.beginningOfDocument, offset: range.location) else { return false }
             guard let endPosition = textView.position(from: textView.beginningOfDocument, offset: NSMaxRange(range)) else { return false }
             guard let textRange = textView.textRange(from: startPosition, to: endPosition) else { return false }

             textView.replace(textRange, withText: String(newText))

             return false
         }
         return true
     }
}

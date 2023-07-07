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
    
    public convenience init(placeHolder: String) {
        self.init()
        self.placeHolderLabel.text = placeHolder
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
    public func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text != nil {
            self.placeHolderLabel.text = ""
            textView.textColor = .black
        }
    }

    public func textViewDidEndEditing(_ textView: UITextView) {
        self.customDelegate?.textViewDidEndEditing(text: textView.text)
    }
    
    public func textViewDidChange(_ textView: UITextView) {
        self.customDelegate?.textViewDidChange(text: textView.text)
    }
}

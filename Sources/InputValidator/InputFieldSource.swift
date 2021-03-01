//
//  InputFieldValidator.swift
//  
//
//  Created by Yury Zenko on 1.03.21.
//

import UIKit

open class InputFieldSource: NSObject {
    
    var nextResponder: ((_ from: InputFieldSource) -> Void)?
    public var isValid: Bool { return true }
    public weak var outerTextField: UITextField? { return _innerTextField }
    
    public var originPlaceholderText: NSAttributedString?
    
    private weak var _innerTextField: UITextField?
    
    open func editingDidBegin() {}
    open func editingDidEnd(text: String?) {}
    open func clearTextField() -> Bool { return true }
    
    public required init(textField: UITextField?) {
        self._innerTextField = textField
        
        if let placeholder = textField?.placeholder {
            originPlaceholderText = NSAttributedString(string: placeholder, attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 0, green: 0, blue: 0.0980392, alpha: 0.22)])
        }
        
        super.init()
        self._innerTextField?.delegate = self
    }
    
    func becomeFirstResponder() {
        _innerTextField?.becomeFirstResponder()
    }
    
    func resignFirstResponder() {
        _innerTextField?.resignFirstResponder()
    }
    
    func setTextFieldValue(text: String?) {
        self._innerTextField?.text = text
    }
}

extension InputFieldSource: UITextFieldDelegate {
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        nextResponder?(self)
        return true
    }
    
    public func textFieldDidBeginEditing(_ textField: UITextField) {
        editingDidBegin()
    }
    
    public func textFieldDidEndEditing(_ textField: UITextField) {
        editingDidEnd(text: textField.text)
    }
    
    public func textFieldShouldClear(_ textField: UITextField) -> Bool {
        return clearTextField()
    }
}

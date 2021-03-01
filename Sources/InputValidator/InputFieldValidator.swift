//
//  InputFieldValidator.swift
//  
//
//  Created by Yury Zenko on 1.03.21.
//

import Foundation
import UIKit

open class InputFieldValidator: InputFieldSource {
    
    public var isAutoValidationEnabled: Bool = true
    public var validationRegexes: String? {
        guard let pattern = ValidationPattern(rawValue: validationKey) else {
            return nil
        }
        let bundle = Bundle(for: Bundle.self)
        return pattern.getRegexes(in: "TextRegexes", bundle: bundle)
    }
    
    public final override var isValid: Bool { return validateField(outerTextField, forceValidation: true) }
    public final override func textFieldDidEndEditing(_ textField: UITextField) {
        editingDidEnd(text: textField.text)
        if isAutoValidationEnabled {
            _ = validateField(textField, forceValidation: false)
        }
    }
    
    open var validationKey: String { return "" }
    open func validateField(_ textField: UITextField?, forceValidation: Bool) -> Bool {
        guard
            let txt = textField?.text,
            let validRegex = validationRegexes,
            let _ = textField else {
                return false
        }
        
        if !forceValidation, txt.count <= 0 {
            return false
        }
        
        let predicate = NSPredicate(format: "SELF MATCHES %@", validRegex)
        let result = predicate.evaluate(with: txt)
        result ? onFieldValidationSucceed(field: textField!) : onFieldValidationFailed(field: textField!)
        return result
    }
    
    func onFieldValidationSucceed(field: UITextField) {}
    func onFieldValidationFailed(field: UITextField) {}
}

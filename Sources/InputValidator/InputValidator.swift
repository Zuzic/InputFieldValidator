//
//  InputValidator.swift
//
//
//  Created by Yury Zenko on 1.03.21.
//

import Foundation

class InputValidator: NSObject {

    public var isAllFieldsValid: Bool { return validateAllSources() }
    
    private var sources: [InputFieldSource] = []
    
    public func addField(source: InputFieldSource) {
        sources.append(source)
        source.nextResponder = { [weak self] (delegate) in
            self?.changeResponder(from: delegate)
        }
    }
    
    private func changeResponder(from responder: InputFieldSource) {
        responder.resignFirstResponder()
        
        guard let index = sources.firstIndex(of: responder),
            index + 1 < sources.count else {
                return
        }
        
        let nextReponder = sources[index + 1]
        nextReponder.becomeFirstResponder()
    }
    
    private func validateAllSources() -> Bool {
        var result: Bool = true
        for source in sources {
            if !source.isValid {
                result = false
            }
        }
        
        return result
    }
    
}

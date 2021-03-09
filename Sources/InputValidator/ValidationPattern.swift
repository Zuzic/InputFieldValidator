//
//  ValidationPattern.swift
//  
//
//  Created by Yury Zenko on 1.03.21.
//

import Foundation
//MARK: - Protocol
public protocol ValidationPatternProtocol: RawRepresentable {
    func getRegexes(path: String?) -> String
}

extension ValidationPatternProtocol {
    public func getRegexes(path: String?) -> String {
        guard let plistPath =  path,
              let nsDictionary = NSDictionary(contentsOfFile: plistPath) else {
            return ""
        }
        
        return nsDictionary[self.rawValue] as? String ?? ""
    }
}

//MARK: - Class
public enum ValidationPattern: String, ValidationPatternProtocol {
    case email
    case password
}

//
//  ValidationPattern.swift
//  
//
//  Created by Yury Zenko on 1.03.21.
//

import Foundation

open enum ValidationPattern: String {
    case email
    case password
    
    public func getRegexes(path: String?) -> String {
        guard let plistPath =  path,
              let nsDictionary = NSDictionary(contentsOfFile: plistPath) else {
            return ""
        }
        
        return nsDictionary[self.rawValue] as? String ?? ""
    }
}

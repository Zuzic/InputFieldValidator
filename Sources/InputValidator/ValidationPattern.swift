//
//  ValidationPattern.swift
//  
//
//  Created by Yury Zenko on 1.03.21.
//

import Foundation

enum ValidationPattern: String {
    case email
    case password
    
    func getRegexes(in plist: String, bundle:Bundle) -> String {
        var nsDictionary: NSDictionary?
        if let plistPath = bundle.path(forResource: plist, ofType: "plist") {
            nsDictionary = NSDictionary(contentsOfFile: plistPath)
            return nsDictionary?[self.rawValue] as? String ?? ""
        }
        
        return ""
    }
}

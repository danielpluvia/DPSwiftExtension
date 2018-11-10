//
//  DPStringExtension.swift
//  DPSwiftExtension
//
//  Created by Xueqiang Ma on 10/11/18.
//

import Foundation

extension String {
    public func validateRegex(pattern: String) -> Bool {
        let test = NSPredicate(format:"SELF MATCHES %@", pattern)
        return test.evaluate(with: self)
    }
}

//
//  Utils.swift
//  ApplicationSwift-Poizat-Derouet
//
//  Created by warp on 19/10/17.
//  Copyright © 2017 warp. All rights reserved.
//

import Foundation

class Utils{
    // Convert Html to string, avoiding bad returns in some way
    public func stripHTML(fromString rawString: String) -> String {
        let scanner: Scanner = Scanner(string: rawString)
        var text: NSString? = ""
        var convertedString = rawString
        while !scanner.isAtEnd {
            scanner.scanUpTo("<", into: nil)
            scanner.scanUpTo(">", into: &text)
            convertedString = convertedString.replacingOccurrences(of: "\(text!)>", with: "")
        }
        return convertedString
    }
}

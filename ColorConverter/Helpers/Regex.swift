//
//  Regex.swift
//  YouTab
//
//  Created by Aleksey on 19.03.2022.
//

import Foundation

enum RegexPattern: String {
    case rgbRegex = #"(#[a-fA-F0-9]{6}|(\(([0-1][0-9][0-9]|2[0-4][0-9]|25[0-5]|[0-9][0-9]|[0-9])(\,([0-1][0-9][0-9]|2[0-4][0-9]|25[0-5]|[0-9][0-9]|[0-9])){2}(\,(1|(0(\.\d*)?)))?\)))"#
    case hexRegex = #"#?[0-9A-Fa-f]{6}"#
}

class Regex {
    static func isMatch(text: String, pattern: RegexPattern) -> Bool {
        let range = NSRange(location: 0, length: text.utf16.count)
        guard let regex = try? NSRegularExpression(pattern: pattern.rawValue, options: []) else {
            return false
        }
        return regex.firstMatch(in: text, options: [], range: range) != nil
    }
}

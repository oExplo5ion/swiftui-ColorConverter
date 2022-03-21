//
//  Color+String.swift
//  YouTab
//
//  Created by Aleksey on 20.03.2022.
//

import Foundation
import SwiftUI

extension Color {
    
    func getRgb() -> (Int,Int,Int) {
        guard let components = self.cgColor?.components else {
            return (0,0,0)
        }
        guard components.count >= 3 else {
            return (0,0,0)
        }
        let r = Int((components[0]*255).rounded())
        let g = Int((components[1]*255).rounded())
        let b = Int((components[2]*255).rounded())
        return (r,g,b)
    }
    
    func getHex() -> String {
        guard let components = cgColor?.components, components.count >= 3 else {
            return "FFFFFF"
        }
        let r = Float(components[0])
        let g = Float(components[1])
        let b = Float(components[2])
        return String(format: "%02lX%02lX%02lX", lroundf(r * 255), lroundf(g * 255), lroundf(b * 255))
    }
    
    static func getColorFromRgbText(color: String) -> Color {
        let components = color
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .replacingOccurrences(of: "(", with: "")
            .replacingOccurrences(of: ")", with: "")
            .replacingOccurrences(of: " ", with: "")
            .replacingOccurrences(of: ".", with: ",")
            .components(separatedBy: ",")
        
        var nums = [0,0,0]
        for (index,component) in components.enumerated() {
            guard let intNum = Int(component) else {
                break
            }
            nums.remove(at: index)
            nums.insert(intNum, at: index)
        }
        return Color(red: nums[0], green: nums[1], blue: nums[2])
    }
    
    static func getColorFromHexText(color: String) -> Color {
        guard let hex = Int(color, radix: 16) else { return .white }
        return Color(rgb: hex)
    }
}

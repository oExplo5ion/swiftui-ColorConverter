//
//  ContentViewModel.swift
//  YouTab
//
//  Created by Aleksey on 18.03.2022.
//

import Foundation
import SwiftUI

enum FieldType: Int, Hashable {
    case none
    case rgb
    case hex
}

protocol ContentViewModelDelegate {
    func focusState() -> FieldType?
}

class ContentViewModel: ObservableObject {
    
    // MARK: - Types
    enum ColorType {
        case rgb
        case hex
    }
    
    // MARK: - Proporties
    // MARK: - Public
    var delegate: ContentViewModelDelegate?
    
    // MARK: - Private
    @Published
    private(set) var rgbTextValue: String = ""
    @Published
    private(set) var hexTextValue: String = ""

    @Published
    private(set) var backgroundColor = Colors._34495E
    
    private(set) lazy var rgbText = Binding<String> {
        return self.rgbTextValue
    } set: { newValue in
        self.rgbTextValue = newValue
        self.convertRgbToHex(color: newValue)
    }
    
    private(set) lazy var hexText = Binding<String> {
        return self.hexTextValue
    } set: { newValue in
        self.hexTextValue = newValue
        self.convertHexToRgb(color: newValue)
    }
    
    // MARK: - Methods
    private func convertColor(type: ContentViewModel.ColorType, color: String) {
        switch type {
        case .rgb:
            convertRgbToHex(color: color)
        case .hex:
            convertHexToRgb(color: color)
        }
    }
    
    private func convertRgbToHex(color: String) {
        var correctColor: String {
            let formattedColor = color
                .trimmingCharacters(in: .whitespacesAndNewlines)
                .replacingOccurrences(of: "(", with: "")
                .replacingOccurrences(of: ")", with: "")
                .replacingOccurrences(of: " ", with: "")
                .replacingOccurrences(of: ".", with: ",")
            return "(" + formattedColor + ")"
        }
        guard Regex.isMatch(text: correctColor, pattern: RegexPattern.rgbRegex) else { return }
        let convertedColor = Color.getColorFromRgbText(color: correctColor)
        if let focusField = delegate?.focusState(), focusField != .hex {
            hexText.wrappedValue = convertedColor.getHex()
        }
        backgroundColor = convertedColor
    }
    
    private func convertHexToRgb(color: String) {
        guard Regex.isMatch(text: color, pattern: RegexPattern.hexRegex) else { return }
        let convertedColor = Color.getColorFromHexText(color: color)
        if let focusField = delegate?.focusState(), focusField != .rgb {
            rgbText.wrappedValue = String("\(convertedColor.getRgb())")
        }
        backgroundColor = convertedColor
    }
}

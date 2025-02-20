//
//  Theme.swift
//  Scrumdinger
//
//  Created by Aleksei Morozow on 01.02.2025.
//

import SwiftUI

enum Theme: String, CaseIterable, Identifiable, Codable {
    case yellow
    case orange
    case red
    
    var mainColor: Color {
        switch self {
        case .yellow: return Color.yellow
        case .orange: return Color.orange
        case .red: return Color.red
        }
    }
    
    var accentColor: Color {
        switch self {
        case .yellow, .orange: return .black
        case .red: return .white
        }
    }
    
    var name: String {
        rawValue.capitalized
    }
    
    var id: String {
        rawValue
    }
}

//
//  Palette.swift
//  Nywordle
//
//  Created by Mohamed Alwakil on 2025-02-28.
//

import SwiftUI

enum Palette {

    case indigo, green, earth, gray

    var background: Color {
        switch self {
        case .indigo:
                .backgroundBlue
        case .green:
                .backgroundGreen
        case .earth:
                .backgroundEarth
        case .gray:
                .backgroundGray
        }
    }

    var tileHeader: Color {
        switch self {
        case .indigo:
                .tileHeaderBlue
        case .green:
                .tileHeaderGreen
        case .earth:
                .tileHeaderEarth
        case .gray:
                .tileHeaderGray
        }
    }

    var tileBody: Color {
        switch self {
        case .indigo:
                .tileBodyBlue
        case.green:
                .tileBodyGreen
        case .earth:
                .tileBodyEarth
        case .gray:
                .tileBodyGray
        }
    }

    var accentColor: Color {
        switch self {
        case .indigo:
                .accentPurple
        case .green:
                .accentSage
        case .earth:
                .accentOrange
        case .gray:
                .accentPink
        }
    }


    var key: String {

        switch self {
        case .indigo:
            "indigo"
        case .green:
            "green"
        case .earth:
            "earth"
        case .gray:
            "gray"
        }
    }

    static func from(_ key: String) -> Palette {
        switch key {
        case "indigo":
            return .indigo
        case "green":
            return .green
        case "earth":
            return .earth
        case "gray":
            return .gray
        default:
            return .green
        }
    }

    var meshColors: [Color] {
        AWStyle.meshFor(self.background)
    }

}

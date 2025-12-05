//
//  Untitled.swift
//  Egypt Hookah Mix
//
//  Created by Dias Atudinov on 05.12.2025.
//

import SwiftUI

extension DateFormatter {
    static let shortEnglish: DateFormatter = {
        let df = DateFormatter()
        df.dateFormat = "dd MMM yyyy"
        df.locale = Locale(identifier: "en_US_POSIX")
        return df
    }()
}

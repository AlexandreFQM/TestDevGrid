//
//  DateFormatterExtension.swift
//  TestGists
//
//  Created by Alexandre Furquim on 07/04/21.
//

import Foundation

extension DateFormatter {
    static let createdAt: DateFormatter = {
        let formatter = DateFormatter()
        formatter.setLocalizedDateFormatFromTemplate("dM")
        return formatter
    }()
}

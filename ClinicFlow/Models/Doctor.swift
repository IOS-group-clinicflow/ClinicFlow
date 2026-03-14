//
//  Doctor.swift
//  ClinicFlow
//
//  Created by COBSCCOMP242P-070 on 2026-03-12.
//

import Foundation

struct Doctor: Identifiable {
    let id: UUID
    let name: String
    let specialty: String
    let availability: String
    let channelingFee: Int
    let imageName: String

    var formattedChannelingFee: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = "LKR"
        formatter.maximumFractionDigits = 0
        formatter.locale = Locale(identifier: "en_LK")

        return formatter.string(from: NSNumber(value: channelingFee)) ?? "LKR \(channelingFee)"
    }
}

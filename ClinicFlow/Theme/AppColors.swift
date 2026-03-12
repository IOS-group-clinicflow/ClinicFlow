//
//  AppColors.swift
//  ClinicFlow
//
//  Created by COBSCCOMP242P-070 on 2026-03-12.
//

import SwiftUI

struct AppColors {
    // Primary brand color
    static let primary = Color.blue
    static let primaryLight = Color.blue.opacity(0.15)
    
    // Backgrounds - uses semantic colors for dark mode support
    static let background = Color(.systemBackground)
    static let secondaryBackground = Color(.secondarySystemBackground)
    static let groupedBackground = Color(.systemGroupedBackground)
    
    // Text
    static let textPrimary = Color.primary
    static let textSecondary = Color.secondary
    static let textTertiary = Color(.tertiaryLabel)
    
    // Status colors
    static let success = Color.green
    static let warning = Color.orange
    static let error = Color.red
    static let info = Color.blue
    
    // Card and surface
    static let cardBackground = Color(.systemGray6)
    static let separator = Color(.separator)
}

//
//  StatusBadge.swift
//  ClinicFlow
//
//  Created by Kawish Jayawardena on 2026-03-12.
//

import SwiftUI

struct StatusBadge: View {
    
    let text: String
    var style: Style = .info
    
    enum Style {
        case success, warning, error, info
        
        var foregroundColor: Color {
            switch self {
            case .success: return AppColors.success
            case .warning: return AppColors.warning
            case .error: return AppColors.error
            case .info: return AppColors.primary
            }
        }
        
        var backgroundColor: Color {
            foregroundColor.opacity(0.15)
        }
    }
    
    var body: some View {
        Text(text)
            .font(AppTypography.caption)
            .fontWeight(.medium)
            .foregroundColor(style.foregroundColor)
            .padding(.horizontal, AppSpacing.sm + 2)
            .padding(.vertical, AppSpacing.xs)
            .background(style.backgroundColor)
            .cornerRadius(AppSpacing.sm)
    }
}

#Preview {
    HStack(spacing: 12) {
        StatusBadge(text: "Confirmed", style: .info)
        StatusBadge(text: "Completed", style: .success)
        StatusBadge(text: "Pending", style: .warning)
        StatusBadge(text: "Cancelled", style: .error)
    }
}

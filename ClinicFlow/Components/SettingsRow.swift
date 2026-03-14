//
//  SettingsRow.swift
//  ClinicFlow
//
//  Created by Kawish Jayawardena on 2026-03-12.
//

import SwiftUI

struct SettingsRow: View {
    
    let icon: String
    let title: String
    var subtitle: String? = nil
    var showChevron: Bool = true
    var iconColor: Color = AppColors.primary
    var onTap: (() -> Void)? = nil
    
    var body: some View {
        Group {
            if let onTap {
                Button(action: onTap) {
                    rowContent
                }
                .buttonStyle(.plain)
            } else {
                rowContent
            }
        }
    }

    private var rowContent: some View {
        HStack(spacing: AppSpacing.md) {
            
            ZStack {
                RoundedRectangle(cornerRadius: AppSpacing.sm)
                    .fill(iconColor.opacity(0.15))
                    .frame(width: 36, height: 36)
                
                Image(systemName: icon)
                    .font(.system(size: 16))
                    .foregroundColor(iconColor)
            }
            
            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(AppTypography.body)
                    .foregroundColor(AppColors.textPrimary)
                
                if let subtitle = subtitle {
                    Text(subtitle)
                        .font(AppTypography.caption)
                        .foregroundColor(AppColors.textTertiary)
                }
            }
            
            Spacer()
            
            if showChevron {
                Image(systemName: "chevron.right")
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(AppColors.textTertiary)
            }
        }
        .padding(.vertical, AppSpacing.sm + 2)
        .padding(.horizontal, AppSpacing.screenHorizontal)
    }
}

#Preview {
    VStack(spacing: 0) {
        SettingsRow(icon: "bell.fill", title: "Notifications", subtitle: "Manage alerts")
        Divider().padding(.leading, 76)
        SettingsRow(icon: "moon.fill", title: "Dark Mode", iconColor: .purple)
        Divider().padding(.leading, 76)
        SettingsRow(icon: "textformat.size", title: "Text Size", iconColor: .orange)
    }
}

//
//  EmptyStateView.swift
//  ClinicFlow
//
//  Created by Kawish Jayawardena on 2026-03-12.
//

import SwiftUI

struct EmptyStateView: View {
    
    let icon: String
    let title: String
    let message: String
    var buttonTitle: String? = nil
    var action: (() -> Void)? = nil
    
    var body: some View {
        VStack(spacing: AppSpacing.md) {
            
            Image(systemName: icon)
                .font(.system(size: 48))
                .foregroundColor(AppColors.textTertiary)
                .padding(.bottom, AppSpacing.sm)
            
            Text(title)
                .font(AppTypography.title)
                .foregroundColor(AppColors.textPrimary)
                .multilineTextAlignment(.center)
            
            Text(message)
                .font(AppTypography.body)
                .foregroundColor(AppColors.textSecondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal, AppSpacing.xl)
            
            if let buttonTitle = buttonTitle {
                PrimaryButton(title: buttonTitle, action: { action?() })
                    .padding(.top, AppSpacing.sm)
            }
        }
        .padding(.vertical, AppSpacing.xl + 8)
    }
}

#Preview {
    EmptyStateView(
        icon: "calendar.badge.plus",
        title: "No Appointments",
        message: "You don't have any upcoming appointments. Book one to get started.",
        buttonTitle: "Book Appointment"
    ) {}
}

//
//  PaymentSummaryCard.swift
//  ClinicFlow
//
//  Created by COBSCCOMP242P-070 on 2026-03-12.
//

import SwiftUI

struct PaymentSummaryCard: View {
    
    let serviceName: String
    let amount: String
    let status: String
    let date: String
    
    var body: some View {
        HStack(spacing: AppSpacing.md) {
            
            // Icon
            ZStack {
                RoundedRectangle(cornerRadius: AppSpacing.cornerRadiusSmall)
                    .fill(iconBackground)
                    .frame(width: AppSpacing.iconContainerSize, height: AppSpacing.iconContainerSize)
                
                Image(systemName: iconName)
                    .font(.system(size: 18))
                    .foregroundColor(iconColor)
            }
            
            // Details
            VStack(alignment: .leading, spacing: AppSpacing.xs) {
                Text(serviceName)
                    .font(AppTypography.headline)
                    .foregroundColor(AppColors.textPrimary)
                
                Text(date)
                    .font(AppTypography.caption)
                    .foregroundColor(AppColors.textTertiary)
            }
            
            Spacer()
            
            // Amount and status
            VStack(alignment: .trailing, spacing: AppSpacing.xs) {
                Text(amount)
                    .font(AppTypography.headline)
                    .foregroundColor(AppColors.textPrimary)
                
                StatusBadge(text: status, style: badgeStyle)
            }
        }
        .padding(AppSpacing.cardPadding)
        .background(AppColors.cardBackground)
        .cornerRadius(AppSpacing.cornerRadiusMedium)
        .padding(.horizontal, AppSpacing.screenHorizontal)
    }
    
    private var badgeStyle: StatusBadge.Style {
        switch status.lowercased() {
        case "paid": return .success
        case "pending": return .warning
        case "required": return .error
        default: return .info
        }
    }
    
    private var iconName: String {
        switch status.lowercased() {
        case "paid": return "checkmark.circle.fill"
        case "pending": return "clock.fill"
        case "required": return "exclamationmark.circle.fill"
        default: return "creditcard.fill"
        }
    }
    
    private var iconColor: Color {
        switch status.lowercased() {
        case "paid": return AppColors.success
        case "pending": return AppColors.warning
        case "required": return AppColors.error
        default: return AppColors.primary
        }
    }
    
    private var iconBackground: Color {
        iconColor.opacity(0.15)
    }
}

#Preview {
    VStack(spacing: 12) {
        PaymentSummaryCard(
            serviceName: "OBG Ultrasound",
            amount: "LKR 5,500",
            status: "Paid",
            date: "10 Feb 2026"
        )
        PaymentSummaryCard(
            serviceName: "Blood Test",
            amount: "LKR 1,200",
            status: "Pending",
            date: "15 Mar 2026"
        )
    }
}

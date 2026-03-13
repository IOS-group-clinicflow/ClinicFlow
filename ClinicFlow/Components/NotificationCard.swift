//
//  NotificationCard.swift
//  ClinicFlow
//
//  Created by COBSCCOMP242P-070 on 2026-03-12.
//

import SwiftUI

struct NotificationCard: View {
    
    let notification: NotificationItem
    
    var body: some View {
        HStack(alignment: .top, spacing: AppSpacing.md) {
            
            // Category icon
            ZStack {
                Circle()
                    .fill(categoryColor.opacity(0.15))
                    .frame(width: 40, height: 40)
                
                Image(systemName: categoryIcon)
                    .font(.system(size: 16))
                    .foregroundColor(categoryColor)
            }
            
            // Content
            VStack(alignment: .leading, spacing: AppSpacing.xs) {
                HStack {
                    Text(notification.title)
                        .font(AppTypography.headline)
                        .foregroundColor(AppColors.textPrimary)
                    
                    Spacer()
                    
                    Text(notification.time)
                        .font(AppTypography.caption)
                        .foregroundColor(AppColors.textTertiary)
                }
                
                Text(notification.message)
                    .font(AppTypography.subheadline)
                    .foregroundColor(AppColors.textSecondary)
                    .lineLimit(2)
            }
        }
        .padding(AppSpacing.cardPadding)
        .background(AppColors.cardBackground)
        .cornerRadius(AppSpacing.cornerRadiusMedium)
        .padding(.horizontal, AppSpacing.screenHorizontal)
    }
    
    private var categoryIcon: String {
        switch notification.category.lowercased() {
        case "reminder": return "bell.fill"
        case "queue": return "person.line.dotted.person"
        case "results": return "doc.text.fill"
        case "payment": return "creditcard.fill"
        default: return "bell.fill"
        }
    }
    
    private var categoryColor: Color {
        switch notification.category.lowercased() {
        case "reminder": return AppColors.primary
        case "queue": return AppColors.warning
        case "results": return AppColors.success
        case "payment": return AppColors.info
        default: return AppColors.primary
        }
    }
}

#Preview {
    VStack(spacing: 12) {
        ForEach(MockData.notifications) { notification in
            NotificationCard(notification: notification)
        }
    }
}

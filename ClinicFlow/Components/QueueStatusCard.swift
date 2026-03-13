//
//  QueueStatusCard.swift
//  ClinicFlow
//
//  Created by COBSCCOMP242P-070 on 2026-03-12.
//

import SwiftUI

struct QueueStatusCard: View {
    
    let currentNumber: Int
    let yourNumber: Int
    let estimatedWait: String
    let doctorName: String
    
    var body: some View {
        VStack(spacing: AppSpacing.md) {
            
            // Header
            HStack {
                Image(systemName: "person.line.dotted.person")
                    .font(.system(size: 20))
                    .foregroundColor(AppColors.primary)
                
                Text("Live Queue")
                    .font(AppTypography.headline)
                    .foregroundColor(AppColors.textPrimary)
                
                Spacer()
                
                StatusBadge(text: "Active", style: .success)
            }
            
            Divider()
            
            // Queue numbers
            HStack(spacing: AppSpacing.xl) {
                
                VStack(spacing: AppSpacing.xs) {
                    Text("Now Serving")
                        .font(AppTypography.caption)
                        .foregroundColor(AppColors.textSecondary)
                    
                    Text("\(currentNumber)")
                        .font(.system(size: 36, weight: .bold))
                        .foregroundColor(AppColors.primary)
                }
                
                VStack(spacing: AppSpacing.xs) {
                    Text("Your Number")
                        .font(AppTypography.caption)
                        .foregroundColor(AppColors.textSecondary)
                    
                    Text("\(yourNumber)")
                        .font(.system(size: 36, weight: .bold))
                        .foregroundColor(AppColors.textPrimary)
                }
                
                VStack(spacing: AppSpacing.xs) {
                    Text("Est. Wait")
                        .font(AppTypography.caption)
                        .foregroundColor(AppColors.textSecondary)
                    
                    Text(estimatedWait)
                        .font(AppTypography.headline)
                        .foregroundColor(AppColors.warning)
                }
            }
            
            Divider()
            
            // Doctor info
            HStack(spacing: AppSpacing.sm) {
                Image(systemName: "stethoscope")
                    .foregroundColor(AppColors.textSecondary)
                
                Text(doctorName)
                    .font(AppTypography.subheadline)
                    .foregroundColor(AppColors.textSecondary)
            }
        }
        .padding(AppSpacing.cardPadding + 4)
        .background(AppColors.cardBackground)
        .cornerRadius(AppSpacing.cornerRadiusLarge)
        .padding(.horizontal, AppSpacing.screenHorizontal)
    }
}

#Preview {
    QueueStatusCard(
        currentNumber: 12,
        yourNumber: 15,
        estimatedWait: "15 min",
        doctorName: "Dr. Nishantha Perera"
    )
}

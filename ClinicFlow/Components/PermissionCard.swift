//
//  PermissionCard.swift
//  ClinicFlow
//
//  Created by Kawish Jayawardena on 2026-03-11.
//
import SwiftUI

struct PermissionCard: View {
    
    var icon: String
    var title: String
    var description: String
    
    @Binding var isOn: Bool
    
    var body: some View {
        
        HStack(spacing: AppSpacing.md) {
            
            ZStack {
                
                RoundedRectangle(cornerRadius: AppSpacing.cornerRadiusSmall)
                    .fill(AppColors.primaryLight)
                    .frame(width: AppSpacing.iconContainerSize, height: AppSpacing.iconContainerSize)
                
                Image(systemName: icon)
                    .foregroundColor(AppColors.primary)
            }
            
            
            VStack(alignment: .leading, spacing: 4) {
                
                Text(title)
                    .font(AppTypography.body.weight(.semibold))
                
                Text(description)
                    .font(AppTypography.subheadline)
                    .foregroundColor(AppColors.textSecondary)
            }
            
            
            Spacer()
            
            
            Toggle("", isOn: $isOn)
                .labelsHidden()
        }
        .padding(AppSpacing.cardPadding)
        .background(AppColors.cardBackground)
        .cornerRadius(AppSpacing.cornerRadiusMedium + 2)
        .padding(.horizontal)
    }
}

//
//  DoctorCard.swift
//  ClinicFlow
//
//  Created by COBSCCOMP242P-070 on 2026-03-12.
//

import SwiftUI

struct DoctorCard: View {
    
    let doctor: Doctor
    var onTap: (() -> Void)? = nil
    
    var body: some View {
        Button(action: { onTap?() }) {
            HStack(spacing: AppSpacing.md) {
                
                // Doctor avatar
                ZStack {
                    Circle()
                        .fill(AppColors.primaryLight)
                        .frame(width: 56, height: 56)
                    
                    Image(systemName: doctor.imageName)
                        .font(.system(size: 28))
                        .foregroundColor(AppColors.primary)
                }
                
                // Doctor info
                VStack(alignment: .leading, spacing: AppSpacing.xs) {
                    Text(doctor.name)
                        .font(AppTypography.headline)
                        .foregroundColor(AppColors.textPrimary)
                    
                    Text(doctor.specialty)
                        .font(AppTypography.subheadline)
                        .foregroundColor(AppColors.primary)
                    
                    Label(doctor.availability, systemImage: "clock")
                        .font(AppTypography.caption)
                        .foregroundColor(AppColors.textTertiary)
                }
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(AppColors.textTertiary)
            }
            .padding(AppSpacing.cardPadding)
            .background(AppColors.cardBackground)
            .cornerRadius(AppSpacing.cornerRadiusMedium)
            .padding(.horizontal, AppSpacing.screenHorizontal)
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    VStack(spacing: 12) {
        DoctorCard(doctor: MockData.doctors[0])
        DoctorCard(doctor: MockData.doctors[1])
    }
}

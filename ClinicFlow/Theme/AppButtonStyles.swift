//
//  AppButtonStyles.swift
//  ClinicFlow
//
//  Created by COBSCCOMP242P-070 on 2026-03-12.
//

import SwiftUI

struct PrimaryButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(AppTypography.button)
            .foregroundColor(.white)
            .frame(maxWidth: .infinity)
            .frame(height: AppSpacing.buttonHeight)
            .background(configuration.isPressed ? AppColors.primary.opacity(0.8) : AppColors.primary)
            .cornerRadius(AppSpacing.cornerRadiusMedium)
            .padding(.horizontal, AppSpacing.screenHorizontal)
    }
}

struct SecondaryButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(AppTypography.button)
            .foregroundColor(AppColors.primary)
            .frame(maxWidth: .infinity)
            .frame(height: AppSpacing.buttonHeight)
            .background(configuration.isPressed ? AppColors.primaryLight : Color.clear)
            .overlay(
                RoundedRectangle(cornerRadius: AppSpacing.cornerRadiusMedium)
                    .stroke(AppColors.primary, lineWidth: 1.5)
            )
            .cornerRadius(AppSpacing.cornerRadiusMedium)
            .padding(.horizontal, AppSpacing.screenHorizontal)
    }
}

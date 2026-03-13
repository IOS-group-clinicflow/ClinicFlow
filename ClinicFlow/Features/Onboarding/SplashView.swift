//
//  SplashView.swift
//  ClinicFlow
//
//  Created by Kawish Jayawardena on 2026-03-13.
//

import SwiftUI

struct SplashView: View {
    var body: some View {
        ZStack {
            AppColors.background
                .ignoresSafeArea()

            VStack(spacing: AppSpacing.md) {
                Image(systemName: "cross.case.fill")
                    .font(.system(size: 48, weight: .semibold))
                    .foregroundColor(AppColors.primary)

                Text("Clinic Flow")
                    .font(AppTypography.largeTitle)
                    .foregroundColor(AppColors.textPrimary)

                Text("Your health, simplified.")
                    .font(AppTypography.subheadline)
                    .foregroundColor(AppColors.textSecondary)
            }
            .padding(AppSpacing.lg)
        }
    }
}

#Preview {
    SplashView()
}
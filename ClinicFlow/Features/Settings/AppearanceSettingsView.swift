//
//  AppearanceSettingsView.swift
//  ClinicFlow
//
//  Created by Kawish Jayawardena on 2026-03-14.
//

import SwiftUI

struct AppearanceSettingsView: View {
    @EnvironmentObject private var appearanceStore: AppAppearanceStore

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: AppSpacing.sectionSpacing) {
                Text("Choose how ClinicFlow looks throughout the app.")
                    .font(AppTypography.body)
                    .foregroundColor(AppColors.textSecondary)
                    .padding(.horizontal, AppSpacing.screenHorizontal)

                VStack(spacing: AppSpacing.md) {
                    ForEach(AppAppearance.allCases) { appearance in
                        Button {
                            appearanceStore.updateAppearance(appearance)
                        } label: {
                            HStack(spacing: AppSpacing.md) {
                                ZStack {
                                    RoundedRectangle(cornerRadius: AppSpacing.cornerRadiusMedium)
                                        .fill(AppColors.primaryLight)
                                        .frame(width: 52, height: 52)

                                    Image(systemName: appearance.iconName)
                                        .font(.system(size: 20, weight: .semibold))
                                        .foregroundColor(AppColors.primary)
                                }

                                VStack(alignment: .leading, spacing: AppSpacing.xs) {
                                    Text(appearance.title)
                                        .font(AppTypography.headline)
                                        .foregroundColor(AppColors.textPrimary)

                                    Text(appearance.subtitle)
                                        .font(AppTypography.subheadline)
                                        .foregroundColor(AppColors.textSecondary)
                                }

                                Spacer()

                                if appearanceStore.appearance == appearance {
                                    Image(systemName: "checkmark.circle.fill")
                                        .font(.system(size: 22))
                                        .foregroundColor(AppColors.success)
                                }
                            }
                            .padding(AppSpacing.cardPadding)
                            .background(AppColors.cardBackground)
                            .cornerRadius(AppSpacing.cornerRadiusLarge)
                            .padding(.horizontal, AppSpacing.screenHorizontal)
                        }
                        .buttonStyle(.plain)
                        .accessibilityLabel(appearance.title)
                        .accessibilityHint("Switch the app appearance to \(appearance.title.lowercased()) mode")
                    }
                }
            }
            .padding(.top)
            .padding(.bottom, AppSpacing.lg)
        }
        .background(AppColors.background)
        .navigationTitle("Appearance")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        AppearanceSettingsView()
            .environmentObject(AppAppearanceStore())
    }
}

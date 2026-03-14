//
//  AppSettingsView.swift
//  ClinicFlow
//
//  Created by Kawish Jayawardena on 2026-03-13.
//

import SwiftUI

struct AppSettingsView: View {
    @EnvironmentObject private var appearanceStore: AppAppearanceStore
    @State private var queueAlerts = true
    @State private var appointmentReminders = true
    @State private var textSize = 16.0
    @State private var selectedLanguage = "English"

    private let languages = ["English", "Sinhala", "Tamil"]

    var body: some View {
        ScrollView {
            VStack(spacing: AppSpacing.sectionSpacing) {
                VStack(spacing: 0) {
                    Toggle("Queue Alerts", isOn: $queueAlerts)
                        .padding(AppSpacing.md)
                    Divider()
                    Toggle("Appointment Reminders", isOn: $appointmentReminders)
                        .padding(AppSpacing.md)
                }
                .background(AppColors.cardBackground)
                .cornerRadius(AppSpacing.cornerRadiusMedium)
                .padding(.horizontal, AppSpacing.screenHorizontal)

                VStack(alignment: .leading, spacing: AppSpacing.md) {
                    VStack(alignment: .leading, spacing: AppSpacing.sm) {
                        Text("Appearance")
                            .font(AppTypography.subheadline)
                            .foregroundColor(AppColors.textSecondary)

                        Picker("Appearance", selection: appearanceBinding) {
                            ForEach(AppAppearance.allCases) { appearance in
                                Text(appearance.title).tag(appearance)
                            }
                        }
                        .pickerStyle(.segmented)
                    }

                    VStack(alignment: .leading, spacing: AppSpacing.xs) {
                        Text("Text Size")
                            .font(AppTypography.subheadline)
                            .foregroundColor(AppColors.textSecondary)
                        Slider(value: $textSize, in: 14...22, step: 1)
                        Text("Current: \(Int(textSize))")
                            .font(AppTypography.caption)
                            .foregroundColor(AppColors.textTertiary)
                    }

                    Picker("Language", selection: $selectedLanguage) {
                        ForEach(languages, id: \.self) { language in
                            Text(language).tag(language)
                        }
                    }
                    .pickerStyle(.menu)
                }
                .padding(AppSpacing.cardPadding)
                .background(AppColors.cardBackground)
                .cornerRadius(AppSpacing.cornerRadiusMedium)
                .padding(.horizontal, AppSpacing.screenHorizontal)
            }
            .padding(.top)
            .padding(.bottom, AppSpacing.lg)
        }
        .background(AppColors.background)
        .navigationTitle("App Settings")
        .navigationBarTitleDisplayMode(.inline)
    }

    private var appearanceBinding: Binding<AppAppearance> {
        Binding(
            get: { appearanceStore.appearance },
            set: { appearanceStore.updateAppearance($0) }
        )
    }
}

#Preview {
    NavigationStack {
        AppSettingsView()
            .environmentObject(AppAppearanceStore())
    }
}

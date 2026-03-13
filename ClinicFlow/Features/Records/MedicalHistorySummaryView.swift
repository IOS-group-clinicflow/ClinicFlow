//
//  MedicalHistorySummaryView.swift
//  ClinicFlow
//
//  Created by Kawish Jayawardena on 2026-03-13.
//

import SwiftUI

struct MedicalHistorySummaryView: View {
    private let patient = MockData.currentUser

    var body: some View {
        ScrollView {
            VStack(spacing: AppSpacing.sectionSpacing) {
                SectionHeader(title: "Patient Overview")

                PatientProfileCard(patient: patient)

                historyBlock(
                    title: "Allergies",
                    values: patient.allergies,
                    emptyText: "No known allergies",
                    color: AppColors.error
                )

                historyBlock(
                    title: "Medical History",
                    values: patient.medicalHistory,
                    emptyText: "No significant history",
                    color: AppColors.info
                )

                historyBlock(
                    title: "Chronic Conditions",
                    values: patient.chronicConditions,
                    emptyText: "No chronic conditions",
                    color: AppColors.warning
                )

                VStack(alignment: .leading, spacing: AppSpacing.sm) {
                    Text("Emergency Contact")
                        .font(AppTypography.headline)

                    Text(patient.emergencyContact)
                        .font(AppTypography.body)
                        .foregroundColor(AppColors.textPrimary)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(AppSpacing.cardPadding)
                .background(AppColors.cardBackground)
                .cornerRadius(AppSpacing.cornerRadiusMedium)
                .padding(.horizontal, AppSpacing.screenHorizontal)
            }
            .padding(.top)
            .padding(.bottom, AppSpacing.lg)
        }
        .background(AppColors.background)
        .navigationTitle("Medical History")
        .navigationBarTitleDisplayMode(.inline)
    }

    private func historyBlock(title: String, values: [String], emptyText: String, color: Color) -> some View {
        VStack(alignment: .leading, spacing: AppSpacing.sm) {
            Text(title)
                .font(AppTypography.headline)

            if values.isEmpty {
                Text(emptyText)
                    .font(AppTypography.subheadline)
                    .foregroundColor(AppColors.textSecondary)
            } else {
                ForEach(values, id: \.self) { value in
                    TagView(text: value, color: color)
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(AppSpacing.cardPadding)
        .background(AppColors.cardBackground)
        .cornerRadius(AppSpacing.cornerRadiusMedium)
        .padding(.horizontal, AppSpacing.screenHorizontal)
    }
}

#Preview {
    NavigationStack {
        MedicalHistorySummaryView()
    }
}

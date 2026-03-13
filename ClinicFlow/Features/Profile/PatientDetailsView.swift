//
//  PatientDetailsView.swift
//  ClinicFlow
//
//  Created by COBSCCOMP242P-070 on 2026-03-13.
//

import SwiftUI

struct PatientDetailsView: View {
    let patient: Patient

    var body: some View {
        ScrollView {
            VStack(spacing: AppSpacing.sectionSpacing) {
                PatientProfileCard(patient: patient, onTap: nil)

                detailSection(title: "Personal Details") {
                    detailRow(label: "Full Name", value: patient.name, icon: "person")
                    divider
                    detailRow(label: "Relationship", value: patient.relationship, icon: "person.2")
                    divider
                    detailRow(label: "Age", value: "\(patient.age)", icon: "calendar")
                    divider
                    detailRow(label: "Emergency Contact", value: patient.emergencyContact, icon: "phone")
                }

                detailSection(title: "Health Profile") {
                    tagBlock(
                        title: "Allergies",
                        values: patient.allergies,
                        emptyText: "No known allergies",
                        color: AppColors.error
                    )

                    divider

                    tagBlock(
                        title: "Medical History",
                        values: patient.medicalHistory,
                        emptyText: "No significant history",
                        color: AppColors.info
                    )

                    divider

                    tagBlock(
                        title: "Chronic Conditions",
                        values: patient.chronicConditions,
                        emptyText: "No chronic conditions",
                        color: AppColors.warning
                    )

                    divider

                    VStack(alignment: .leading, spacing: AppSpacing.xs) {
                        Text("Health Notes")
                            .font(AppTypography.subheadline)
                            .foregroundColor(AppColors.textSecondary)

                        Text(patient.healthNotes)
                            .font(AppTypography.body)
                            .foregroundColor(AppColors.textPrimary)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, AppSpacing.screenHorizontal)
                    .padding(.vertical, AppSpacing.sm + 2)
                }
            }
            .padding(.top)
            .padding(.bottom, AppSpacing.lg)
        }
        .background(AppColors.background)
        .navigationTitle(patient.relationship == "Self" ? "My Profile" : patient.name)
        .navigationBarTitleDisplayMode(.inline)
    }

    private var divider: some View {
        Divider()
            .padding(.leading, AppSpacing.screenHorizontal)
    }

    private func detailSection<Content: View>(title: String, @ViewBuilder content: () -> Content) -> some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(title)
                .font(AppTypography.headline)
                .foregroundColor(AppColors.textPrimary)
                .padding(.horizontal, AppSpacing.screenHorizontal)
                .padding(.top, AppSpacing.cardPadding)
                .padding(.bottom, AppSpacing.sm)

            content()
        }
        .background(AppColors.cardBackground)
        .cornerRadius(AppSpacing.cornerRadiusMedium)
        .padding(.horizontal, AppSpacing.screenHorizontal)
    }

    private func detailRow(label: String, value: String, icon: String) -> some View {
        ProfileRow(label: label, value: value, icon: icon)
    }

    private func tagBlock(title: String, values: [String], emptyText: String, color: Color) -> some View {
        VStack(alignment: .leading, spacing: AppSpacing.sm) {
            Text(title)
                .font(AppTypography.subheadline)
                .foregroundColor(AppColors.textSecondary)

            if values.isEmpty {
                Text(emptyText)
                    .font(AppTypography.body)
                    .foregroundColor(AppColors.textTertiary)
            } else {
                FlexibleTagList(values: values, color: color)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, AppSpacing.screenHorizontal)
        .padding(.vertical, AppSpacing.sm + 2)
    }
}

private struct FlexibleTagList: View {
    let values: [String]
    let color: Color

    var body: some View {
        VStack(alignment: .leading, spacing: AppSpacing.sm) {
            ForEach(values, id: \.self) { value in
                TagView(text: value, color: color)
            }
        }
    }
}

struct PatientDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            PatientDetailsView(patient: MockData.currentUser)
        }
    }
}

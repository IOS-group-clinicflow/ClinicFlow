//
//  TestResultsView.swift
//  ClinicFlow
//
//  Created by Kawish Jayawardena on 2026-03-13.
//

import SwiftUI

struct TestResultsView: View {
    private var testsOnly: [MedicalRecord] {
        MockData.medicalRecords.filter { $0.type.localizedCaseInsensitiveContains("lab") || $0.type.localizedCaseInsensitiveContains("imaging") }
    }

    var body: some View {
        ScrollView {
            VStack(spacing: AppSpacing.sectionSpacing) {
                if testsOnly.isEmpty {
                    EmptyStateView(
                        icon: "doc.text.magnifyingglass",
                        title: "No Test Results",
                        message: "Your test results will appear here once released by the clinic."
                    )
                } else {
                    ForEach(testsOnly) { record in
                        VStack(alignment: .leading, spacing: AppSpacing.sm) {
                            HStack {
                                Text(record.title)
                                    .font(AppTypography.headline)
                                Spacer()
                                StatusBadge(text: record.status, style: record.status.lowercased() == "available" ? .success : .warning)
                            }

                            Text(record.date)
                                .font(AppTypography.caption)
                                .foregroundColor(AppColors.textTertiary)

                            Text(record.summary)
                                .font(AppTypography.subheadline)
                                .foregroundColor(AppColors.textSecondary)
                        }
                        .padding(AppSpacing.cardPadding)
                        .background(AppColors.cardBackground)
                        .cornerRadius(AppSpacing.cornerRadiusMedium)
                        .padding(.horizontal, AppSpacing.screenHorizontal)
                    }
                }
            }
            .padding(.top)
            .padding(.bottom, AppSpacing.lg)
        }
        .background(AppColors.background)
        .navigationTitle("Test Results")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        TestResultsView()
    }
}

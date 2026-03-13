//
//  RecordsView.swift
//  ClinicFlow
//
//  Created by Kawish Jayawardena on 2026-03-12.
//

import SwiftUI

struct RecordsView: View {
    @State private var searchText = ""

    private var filteredRecords: [MedicalRecord] {
        guard !searchText.isEmpty else { return MockData.medicalRecords }

        return MockData.medicalRecords.filter {
            $0.title.localizedCaseInsensitiveContains(searchText)
                || $0.type.localizedCaseInsensitiveContains(searchText)
                || $0.summary.localizedCaseInsensitiveContains(searchText)
        }
    }

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: AppSpacing.sectionSpacing) {
                    SearchBarView(text: $searchText, placeholder: "Search records or tests")

                    SectionHeader(title: "Medical Records")

                    if filteredRecords.isEmpty {
                        EmptyStateView(
                            icon: "doc.text.magnifyingglass",
                            title: "No Matching Records",
                            message: "Try a different keyword to find your reports and summaries."
                        )
                    } else {
                        ForEach(filteredRecords) { record in
                            VStack(alignment: .leading, spacing: AppSpacing.sm) {
                                HStack {
                                    Text(record.title)
                                        .font(AppTypography.headline)
                                        .foregroundColor(AppColors.textPrimary)

                                    Spacer()

                                    StatusBadge(text: record.status, style: statusStyle(for: record.status))
                                }

                                HStack(spacing: AppSpacing.sm) {
                                    TagView(text: record.type, color: AppColors.info)
                                    Text(record.date)
                                        .font(AppTypography.caption)
                                        .foregroundColor(AppColors.textTertiary)
                                }

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

                    SectionHeader(title: "Lab & Payments")

                    ForEach(MockData.labTests) { test in
                        PaymentSummaryCard(
                            serviceName: test.name,
                            amount: test.requiresPayment ? "Payment Required" : "No Pre-payment",
                            status: paymentStatus(for: test),
                            date: test.status
                        )
                    }

                    Text("Some services may require payment before appointment confirmation.")
                        .font(AppTypography.caption)
                        .foregroundColor(AppColors.textTertiary)
                        .padding(.horizontal, AppSpacing.screenHorizontal)
                }
                .padding(.top)
                .padding(.bottom, AppSpacing.lg)
            }
            .background(AppColors.background)
            .navigationTitle("Records")
            .navigationBarTitleDisplayMode(.inline)
        }
    }

    private func statusStyle(for status: String) -> StatusBadge.Style {
        switch status.lowercased() {
        case "available": return .success
        case "pending": return .warning
        default: return .info
        }
    }

    private func paymentStatus(for test: LabTest) -> String {
        if test.requiresPayment { return "Required" }
        if test.status.lowercased() == "completed" { return "Paid" }
        return "Pending"
    }
}

#Preview {
    RecordsView()
}

//
//  BillingSummaryView.swift
//  ClinicFlow
//
//  Created by Kawish Jayawardena on 2026-03-13.
//

import SwiftUI

struct BillingSummaryView: View {
    @Binding var state: BookingFlowState
    let onBack: () -> Void
    let onContinue: () -> Void

    var body: some View {
        ScrollView {
            VStack(spacing: AppSpacing.sectionSpacing) {
                SectionHeader(title: "Payment Required")

                PaymentSummaryCard(
                    serviceName: state.selectedSpecialty ?? "Specialist Service",
                    amount: state.formattedTotalFee,
                    status: "Required",
                    date: formattedDate(state.selectedDate)
                )

                VStack(alignment: .leading, spacing: AppSpacing.sm) {
                    billingRow(label: "Consultation", value: state.formattedConsultationFee)
                    billingRow(label: "Service Fee", value: state.formattedServiceFee)
                    Divider()
                    billingRow(label: "Total", value: state.formattedTotalFee, isTotal: true)
                }
                .padding(AppSpacing.cardPadding)
                .background(AppColors.cardBackground)
                .cornerRadius(AppSpacing.cornerRadiusMedium)
                .padding(.horizontal, AppSpacing.screenHorizontal)

                Text("Pre-payment is required for this service to secure the appointment slot.")
                    .font(AppTypography.caption)
                    .foregroundColor(AppColors.textSecondary)
                    .padding(.horizontal, AppSpacing.screenHorizontal)

                HStack(spacing: AppSpacing.md) {
                    SecondaryButton(title: "Back", action: onBack)
                    PrimaryButton(title: "Choose Payment Method", icon: "arrow.right", action: onContinue)
                }
            }
            .padding(.top)
            .padding(.bottom, AppSpacing.lg)
        }
        .background(AppColors.background)
    }

    private func billingRow(label: String, value: String, isTotal: Bool = false) -> some View {
        HStack {
            Text(label)
                .font(isTotal ? AppTypography.headline : AppTypography.subheadline)
                .foregroundColor(isTotal ? AppColors.textPrimary : AppColors.textSecondary)
            Spacer()
            Text(value)
                .font(isTotal ? AppTypography.headline : AppTypography.subheadline)
                .foregroundColor(AppColors.textPrimary)
        }
    }

    private func formattedDate(_ date: Date?) -> String {
        guard let date else { return "-" }
        return date.formatted(.dateTime.day().month().year())
    }
}

#Preview {
    BillingSummaryView(state: .constant(BookingFlowState()), onBack: {}) {}
}

//
//  BookingSuccessView.swift
//  ClinicFlow
//
//  Created by Kawish Jayawardena on 2026-03-13.
//

import SwiftUI

struct BookingSuccessView: View {
    let state: BookingFlowState
    let onDone: () -> Void

    var body: some View {
        ScrollView {
            VStack(spacing: AppSpacing.sectionSpacing) {
                EmptyStateView(
                    icon: "checkmark.seal.fill",
                    title: "Appointment Booked",
                    message: "Your appointment has been successfully scheduled.",
                    buttonTitle: nil
                )

                VStack(spacing: AppSpacing.sm + 4) {
                    summaryRow(label: "Patient", value: state.selectedPatient?.name ?? "-")
                    summaryRow(label: "Doctor", value: state.selectedDoctor?.name ?? "-")
                    summaryRow(label: "Date", value: formattedDate(state.selectedDate))
                    summaryRow(label: "Time", value: state.selectedTime ?? "-")

                    if state.requiresPrePayment {
                        summaryRow(label: "Payment", value: "Completed")
                    } else {
                        summaryRow(label: "Payment", value: "At Clinic (if required)")
                    }
                }
                .padding(AppSpacing.cardPadding)
                .background(AppColors.cardBackground)
                .cornerRadius(AppSpacing.cornerRadiusMedium)
                .padding(.horizontal, AppSpacing.screenHorizontal)

                PrimaryButton(title: "Done", action: onDone)
            }
            .padding(.top)
            .padding(.bottom, AppSpacing.lg)
        }
        .background(AppColors.background)
    }

    private func summaryRow(label: String, value: String) -> some View {
        HStack {
            Text(label)
                .font(AppTypography.subheadline)
                .foregroundColor(AppColors.textSecondary)
            Spacer()
            Text(value)
                .font(AppTypography.body)
                .foregroundColor(AppColors.textPrimary)
                .multilineTextAlignment(.trailing)
        }
    }

    private func formattedDate(_ date: Date?) -> String {
        guard let date else { return "-" }
        return date.formatted(.dateTime.day().month().year())
    }
}

#Preview {
    BookingSuccessView(state: BookingFlowState()) {}
}

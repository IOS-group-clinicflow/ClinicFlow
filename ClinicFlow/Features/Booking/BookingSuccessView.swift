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
                VStack(spacing: AppSpacing.md) {
                    Text("Appointment Successful")
                        .font(AppTypography.title)
                        .foregroundColor(AppColors.textPrimary)
                        .multilineTextAlignment(.center)

                    Text("Your payment option has been saved and the appointment has been booked successfully.")
                        .font(AppTypography.body)
                        .foregroundColor(AppColors.textSecondary)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, AppSpacing.xl)

                    Image(systemName: "checkmark.circle.fill")
                        .font(.system(size: 76, weight: .semibold))
                        .foregroundColor(AppColors.success)
                        .accessibilityLabel("Appointment booked successfully")

                    Text("A notification with the appointment date and time has been added to Notifications.")
                        .font(AppTypography.caption)
                        .foregroundColor(AppColors.textSecondary)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, AppSpacing.xl)
                }
                .padding(.top, AppSpacing.md)

                VStack(spacing: AppSpacing.sm + 4) {
                    summaryRow(label: "Patient", value: state.selectedPatient?.name ?? "-")
                    summaryRow(label: "Specialty", value: state.selectedSpecialty ?? "-")
                    summaryRow(label: "Doctor", value: state.selectedDoctor?.name ?? "-")
                    summaryRow(label: "Date", value: formattedDate(state.selectedDate))
                    summaryRow(label: "Time", value: state.selectedTime ?? "-")
                    summaryRow(label: "Payment Method", value: state.selectedPaymentMethod?.rawValue ?? "-")
                    summaryRow(label: "Amount", value: state.formattedTotalFee)
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

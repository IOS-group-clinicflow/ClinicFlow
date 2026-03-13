//
//  ConfirmAppointmentView.swift
//  ClinicFlow
//
//  Created by Kawish Jayawardena on 2026-03-13.
//

import SwiftUI

struct ConfirmAppointmentView: View {
    @Binding var state: BookingFlowState
    let onBack: () -> Void
    let onConfirm: () -> Void

    var body: some View {
        ScrollView {
            VStack(spacing: AppSpacing.sectionSpacing) {
                SectionHeader(title: "Review Details")

                VStack(spacing: AppSpacing.sm + 4) {
                    summaryRow(label: "Patient", value: state.selectedPatient?.name ?? "-")
                    summaryRow(label: "Specialty", value: state.selectedSpecialty ?? "-")
                    summaryRow(label: "Doctor", value: state.selectedDoctor?.name ?? "-")
                    summaryRow(label: "Date", value: formattedDate(state.selectedDate))
                    summaryRow(label: "Time", value: state.selectedTime ?? "-")
                }
                .padding(AppSpacing.cardPadding)
                .background(AppColors.cardBackground)
                .cornerRadius(AppSpacing.cornerRadiusMedium)
                .padding(.horizontal, AppSpacing.screenHorizontal)

                if state.requiresPrePayment {
                    HStack(alignment: .top, spacing: AppSpacing.sm) {
                        Image(systemName: "creditcard.fill")
                            .foregroundColor(AppColors.warning)
                        Text("This service requires pre-payment before final booking confirmation.")
                            .font(AppTypography.subheadline)
                            .foregroundColor(AppColors.textSecondary)
                        Spacer()
                    }
                    .padding(AppSpacing.cardPadding)
                    .background(AppColors.cardBackground)
                    .cornerRadius(AppSpacing.cornerRadiusMedium)
                    .padding(.horizontal, AppSpacing.screenHorizontal)
                } else {
                    HStack(alignment: .top, spacing: AppSpacing.sm) {
                        Image(systemName: "checkmark.circle.fill")
                            .foregroundColor(AppColors.success)
                        Text("No pre-payment is needed. Your booking will be confirmed immediately.")
                            .font(AppTypography.subheadline)
                            .foregroundColor(AppColors.textSecondary)
                        Spacer()
                    }
                    .padding(AppSpacing.cardPadding)
                    .background(AppColors.cardBackground)
                    .cornerRadius(AppSpacing.cornerRadiusMedium)
                    .padding(.horizontal, AppSpacing.screenHorizontal)
                }

                HStack(spacing: AppSpacing.md) {
                    SecondaryButton(title: "Back", action: onBack)
                    PrimaryButton(title: state.requiresPrePayment ? "Continue to Billing" : "Confirm Appointment", icon: "arrow.right") {
                        onConfirm()
                    }
                    .disabled(!state.isReadyForConfirmation)
                    .opacity(state.isReadyForConfirmation ? 1 : 0.5)
                }
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
    ConfirmAppointmentView(state: .constant(BookingFlowState()), onBack: {}) {}
}

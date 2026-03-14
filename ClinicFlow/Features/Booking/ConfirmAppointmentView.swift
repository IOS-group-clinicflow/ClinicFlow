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
                    summaryRow(label: "Relationship", value: state.selectedPatient?.relationship ?? "-")
                    summaryRow(label: "Contact", value: state.selectedPatient?.emergencyContact ?? "-")
                    summaryRow(label: "Specialty", value: state.selectedSpecialty ?? "-")
                    summaryRow(label: "Doctor", value: state.selectedDoctor?.name ?? "-")
                    summaryRow(label: "Date", value: formattedDate(state.selectedDate))
                    summaryRow(label: "Time", value: state.selectedTime ?? "-")
                }
                .padding(AppSpacing.cardPadding)
                .background(AppColors.cardBackground)
                .cornerRadius(AppSpacing.cornerRadiusMedium)
                .padding(.horizontal, AppSpacing.screenHorizontal)

                HStack(alignment: .top, spacing: AppSpacing.sm) {
                    Image(systemName: "creditcard.fill")
                        .foregroundColor(AppColors.primary)
                    Text("Review the appointment details, then proceed to payment to finish the booking. A confirmation notification will be added once the payment step is completed.")
                        .font(AppTypography.subheadline)
                        .foregroundColor(AppColors.textSecondary)
                    Spacer()
                }
                .padding(AppSpacing.cardPadding)
                .background(AppColors.cardBackground)
                .cornerRadius(AppSpacing.cornerRadiusMedium)
                .padding(.horizontal, AppSpacing.screenHorizontal)

                HStack(spacing: AppSpacing.md) {
                    SecondaryButton(title: "Back", action: onBack)
                    PrimaryButton(title: "Proceed to Payment", icon: "arrow.right") {
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

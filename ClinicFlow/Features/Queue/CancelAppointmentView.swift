//
//  CancelAppointmentView.swift
//  ClinicFlow
//
//  Created by Kawish Jayawardena on 2026-03-13.
//

import SwiftUI

struct CancelAppointmentView: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject private var appointmentStore: AppointmentStore
    @EnvironmentObject private var notificationStore: AppNotificationStore

    @State private var selectedReason = ""
    @State private var otherReason = ""
    @State private var showCancellationAlert = false

    private let reasons = [
        "Feeling better",
        "Need a different date",
        "Booked by mistake",
        "Clinic location issue",
        "Other"
    ]

    var body: some View {
        Group {
            if let appointment = appointmentStore.upcomingAppointment {
                ScrollView {
                    VStack(spacing: AppSpacing.sectionSpacing) {
                        AppointmentCard(appointment: appointment)

                        VStack(alignment: .leading, spacing: AppSpacing.md) {
                            Text("Reason for Cancellation")
                                .font(AppTypography.title)
                                .foregroundColor(AppColors.textPrimary)

                            ForEach(reasons, id: \.self) { item in
                                Button {
                                    selectedReason = item
                                } label: {
                                    HStack {
                                        Text(item)
                                            .font(AppTypography.body)
                                            .foregroundColor(AppColors.textPrimary)
                                        Spacer()
                                        if selectedReason == item {
                                            Image(systemName: "checkmark.circle.fill")
                                                .foregroundColor(AppColors.error)
                                        }
                                    }
                                    .padding(AppSpacing.md)
                                    .background(AppColors.secondaryBackground)
                                    .cornerRadius(AppSpacing.cornerRadiusMedium)
                                }
                                .buttonStyle(.plain)
                                .accessibilityLabel(item)
                                .accessibilityHint("Select this cancellation reason")
                            }

                            if selectedReason == "Other" {
                                VStack(alignment: .leading, spacing: AppSpacing.xs) {
                                    Text("Add Details")
                                        .font(AppTypography.label)
                                        .foregroundColor(AppColors.textPrimary)

                                    TextEditor(text: $otherReason)
                                        .frame(minHeight: 100)
                                        .padding(AppSpacing.sm)
                                        .background(AppColors.secondaryBackground)
                                        .cornerRadius(AppSpacing.cornerRadiusMedium)
                                        .scrollContentBackground(.hidden)
                                        .accessibilityLabel("Other cancellation reason")
                                }
                            }
                        }
                        .padding(AppSpacing.cardPadding)
                        .background(AppColors.cardBackground)
                        .cornerRadius(AppSpacing.cornerRadiusLarge)
                        .padding(.horizontal, AppSpacing.screenHorizontal)

                        Button {
                            cancelAppointment(appointment)
                        } label: {
                            Text("Cancel Appointment")
                                .font(AppTypography.button)
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .frame(height: AppSpacing.buttonHeight)
                                .background(isCancellationReady ? AppColors.error : AppColors.error.opacity(0.35))
                                .cornerRadius(AppSpacing.cornerRadiusMedium)
                                .padding(.horizontal, AppSpacing.screenHorizontal)
                        }
                        .buttonStyle(.plain)
                        .disabled(!isCancellationReady)
                    }
                    .padding(.top)
                    .padding(.bottom, AppSpacing.lg)
                }
                .background(AppColors.background)
                .alert("Appointment Cancelled", isPresented: $showCancellationAlert) {
                    Button("Done") {
                        dismiss()
                    }
                } message: {
                    Text("Your appointment has been cancelled successfully.")
                }
            } else {
                EmptyStateView(
                    icon: "xmark.circle",
                    title: "No Appointment To Cancel",
                    message: "If you have an upcoming visit, you can cancel it from here."
                )
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(AppColors.background)
            }
        }
        .navigationTitle("Cancel Appointment")
        .navigationBarTitleDisplayMode(.inline)
    }

    private var isCancellationReady: Bool {
        guard !selectedReason.isEmpty else { return false }
        return selectedReason != "Other" || !otherReason.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }

    private func cancelAppointment(_ appointment: Appointment) {
        let reasonText = selectedReason == "Other" ? otherReason.trimmingCharacters(in: .whitespacesAndNewlines) : selectedReason
        notificationStore.addCancelledNotification(for: appointment, reason: reasonText)
        appointmentStore.cancelUpcomingAppointment()
        showCancellationAlert = true
    }
}

#Preview {
    NavigationStack {
        CancelAppointmentView()
            .environmentObject(AppointmentStore())
            .environmentObject(AppNotificationStore())
    }
}

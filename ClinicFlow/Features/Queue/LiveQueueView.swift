//
//  LiveQueueView.swift
//  ClinicFlow
//
//  Created by Kawish Jayawardena on 2026-03-13.
//

import SwiftUI

struct LiveQueueView: View {
    @EnvironmentObject private var appointmentStore: AppointmentStore

    var body: some View {
        Group {
            if let appointment = appointmentStore.upcomingAppointment {
                ScrollView {
                    VStack(spacing: AppSpacing.sectionSpacing) {
                        QueueStatusCard(
                            currentNumber: appointmentStore.queueState.nowServing,
                            yourNumber: appointmentStore.queueState.yourNumber,
                            estimatedWait: appointmentStore.queueState.estimatedWaitText,
                            doctorName: appointment.doctorName
                        )
                        .accessibilityElement(children: .combine)
                        .accessibilityLabel("Live queue")
                        .accessibilityValue("Now serving \(appointmentStore.queueState.nowServing), your number \(appointmentStore.queueState.yourNumber), estimated wait \(appointmentStore.queueState.estimatedWaitText)")

                        HStack(alignment: .top, spacing: AppSpacing.sm) {
                            Image(systemName: appointmentStore.queueState.notificationsEnabled ? "info.circle.fill" : "bell.slash.fill")
                                .foregroundColor(AppColors.info)

                            Text(appointmentStore.queueState.notificationsEnabled
                                 ? "Keep notifications enabled to receive real-time queue updates."
                                 : "Queue notifications are turned off. Enable them again to receive real-time updates.")
                                .font(AppTypography.subheadline)
                                .foregroundColor(AppColors.textSecondary)
                            Spacer()
                        }
                        .padding(AppSpacing.cardPadding)
                        .background(AppColors.cardBackground)
                        .cornerRadius(AppSpacing.cornerRadiusMedium)
                        .padding(.horizontal, AppSpacing.screenHorizontal)

                        VStack(alignment: .leading, spacing: AppSpacing.sm) {
                            Text("Queue Details")
                                .font(AppTypography.headline)
                                .foregroundColor(AppColors.textPrimary)

                            queueDetailRow(label: "Appointment Date", value: appointment.date)
                            queueDetailRow(label: "Appointment Time", value: appointment.time)
                            queueDetailRow(label: "Location", value: appointment.location)
                            queueDetailRow(label: "Last Updated", value: appointmentStore.queueState.lastUpdated.formatted(.dateTime.hour().minute()))
                        }
                        .padding(AppSpacing.cardPadding)
                        .background(AppColors.cardBackground)
                        .cornerRadius(AppSpacing.cornerRadiusMedium)
                        .padding(.horizontal, AppSpacing.screenHorizontal)
                    }
                    .padding(.top)
                    .padding(.bottom, AppSpacing.lg)
                }
                .background(AppColors.background)
            } else {
                EmptyStateView(
                    icon: "person.3.sequence.fill",
                    title: "No Active Queue",
                    message: "Book an upcoming appointment to view live queue progress and estimated waiting time."
                )
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(AppColors.background)
            }
        }
        .navigationTitle("Live Queue")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    appointmentStore.refreshQueue()
                } label: {
                    Image(systemName: "arrow.clockwise")
                }
                .accessibilityLabel("Refresh queue")
                .disabled(appointmentStore.upcomingAppointment == nil)
            }
        }
    }

    private func queueDetailRow(label: String, value: String) -> some View {
        HStack(alignment: .top, spacing: AppSpacing.md) {
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
}

#Preview {
    NavigationStack {
        LiveQueueView()
            .environmentObject(AppointmentStore())
    }
}

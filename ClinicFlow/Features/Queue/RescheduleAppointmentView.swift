//
//  RescheduleAppointmentView.swift
//  ClinicFlow
//
//  Created by Kawish Jayawardena on 2026-03-13.
//

import SwiftUI

struct RescheduleAppointmentView: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject private var appointmentStore: AppointmentStore
    @EnvironmentObject private var notificationStore: AppNotificationStore

    @State private var selectedDate: Date?
    @State private var selectedTime: String?
    @State private var showConfirmation = false

    private var availableDates: [Date] {
        let calendar = Calendar.current
        let start = calendar.startOfDay(for: Date())
        return (1...5).compactMap { calendar.date(byAdding: .day, value: $0, to: start) }
    }

    private let morningSlots = ["09:00 AM", "09:30 AM", "10:00 AM", "11:00 AM"]
    private let afternoonSlots = ["01:30 PM", "02:00 PM", "03:30 PM", "04:00 PM", "04:30 PM", "05:00 PM"]

    var body: some View {
        Group {
            if let appointment = appointmentStore.upcomingAppointment {
                ScrollView {
                    VStack(alignment: .leading, spacing: AppSpacing.sectionSpacing) {
                        originalAppointmentCard(appointment)
                        dateSelectionSection
                        timeSection(title: "Morning", systemImage: "sun.max", slots: morningSlots)
                        timeSection(title: "Afternoon", systemImage: "sun.haze", slots: afternoonSlots)

                        PrimaryButton(title: "Confirm Reschedule") {
                            confirmReschedule()
                        }
                        .disabled(selectedDate == nil || selectedTime == nil)
                        .opacity(selectedDate == nil || selectedTime == nil ? 0.5 : 1)
                        .padding(.top, AppSpacing.sm)
                    }
                    .padding(.top)
                    .padding(.bottom, AppSpacing.lg)
                }
                .background(AppColors.background)
                .alert("Appointment Rescheduled", isPresented: $showConfirmation) {
                    Button("Done") {
                        dismiss()
                    }
                } message: {
                    if let updatedAppointment = appointmentStore.upcomingAppointment {
                        Text("Your appointment has been moved to \(updatedAppointment.date) at \(updatedAppointment.time).")
                    }
                }
            } else {
                EmptyStateView(
                    icon: "calendar.badge.clock",
                    title: "No Appointment To Reschedule",
                    message: "Book an appointment first, then you can choose a new date and time here."
                )
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(AppColors.background)
            }
        }
        .navigationTitle("Reschedule Appointment")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            if selectedDate == nil {
                selectedDate = availableDates.first
            }
        }
    }

    private func originalAppointmentCard(_ appointment: Appointment) -> some View {
        VStack(alignment: .leading, spacing: AppSpacing.md) {
            Text("ORIGINAL APPOINTMENT")
                .font(.system(size: 13, weight: .bold))
                .tracking(2)
                .foregroundColor(AppColors.textTertiary)

            HStack(spacing: AppSpacing.md) {
                Circle()
                    .fill(AppColors.primaryLight)
                    .frame(width: 60, height: 60)
                    .overlay(
                        Image(systemName: "person.crop.circle.fill")
                            .font(.system(size: 34))
                            .foregroundColor(AppColors.primary)
                    )

                VStack(alignment: .leading, spacing: AppSpacing.xs) {
                    Text(appointment.doctorName)
                        .font(AppTypography.title)
                        .foregroundColor(AppColors.textPrimary)

                    Text("\(appointment.date), \(appointment.time)")
                        .font(AppTypography.body)
                        .foregroundColor(AppColors.textSecondary)

                    Text(appointment.location)
                        .font(AppTypography.caption)
                        .foregroundColor(AppColors.textTertiary)
                }
            }
        }
        .padding(AppSpacing.cardPadding + 4)
        .background(AppColors.cardBackground)
        .cornerRadius(AppSpacing.cornerRadiusLarge)
        .padding(.horizontal, AppSpacing.screenHorizontal)
    }

    private var dateSelectionSection: some View {
        VStack(alignment: .leading, spacing: AppSpacing.md) {
            HStack {
                Text("Select Date")
                    .font(AppTypography.title)
                    .foregroundColor(AppColors.textPrimary)
                Spacer()
                if let selectedDate {
                    Text(selectedDate.formatted(.dateTime.month(.wide).year()))
                        .font(AppTypography.headline)
                        .foregroundColor(AppColors.primary)
                }
            }
            .padding(.horizontal, AppSpacing.screenHorizontal)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: AppSpacing.md) {
                    ForEach(availableDates, id: \.self) { date in
                        Button {
                            selectedDate = date
                        } label: {
                            VStack(spacing: AppSpacing.xs) {
                                Text(date.formatted(.dateTime.weekday(.abbreviated)).uppercased())
                                    .font(AppTypography.caption)
                                Text(date.formatted(.dateTime.day()))
                                    .font(.system(size: 30, weight: .bold))
                            }
                            .foregroundColor(Calendar.current.isDate(selectedDate ?? .distantPast, inSameDayAs: date) ? .white : AppColors.textPrimary)
                            .frame(width: 90, height: 116)
                            .background(
                                Calendar.current.isDate(selectedDate ?? .distantPast, inSameDayAs: date)
                                ? AppColors.primary
                                : AppColors.cardBackground
                            )
                            .cornerRadius(AppSpacing.cornerRadiusLarge)
                        }
                        .buttonStyle(.plain)
                        .accessibilityLabel(date.formatted(.dateTime.weekday(.wide).day().month().year()))
                    }
                }
                .padding(.horizontal, AppSpacing.screenHorizontal)
            }
        }
    }

    private func timeSection(title: String, systemImage: String, slots: [String]) -> some View {
        VStack(alignment: .leading, spacing: AppSpacing.md) {
            HStack(spacing: AppSpacing.sm) {
                Image(systemName: systemImage)
                    .foregroundColor(AppColors.warning)
                Text(title)
                    .font(AppTypography.headline)
                    .foregroundColor(AppColors.textSecondary)
            }
            .padding(.horizontal, AppSpacing.screenHorizontal)

            LazyVGrid(columns: [GridItem(.adaptive(minimum: 140), spacing: AppSpacing.md)], spacing: AppSpacing.md) {
                ForEach(slots, id: \.self) { slot in
                    Button {
                        selectedTime = slot
                    } label: {
                        Text(slot)
                            .font(AppTypography.body)
                            .foregroundColor(selectedTime == slot ? AppColors.primary : AppColors.textPrimary)
                            .frame(maxWidth: .infinity)
                            .frame(height: 56)
                            .overlay(
                                RoundedRectangle(cornerRadius: AppSpacing.cornerRadiusMedium)
                                    .stroke(selectedTime == slot ? AppColors.primary : AppColors.separator.opacity(0.45), lineWidth: selectedTime == slot ? 2 : 1)
                            )
                            .background(AppColors.cardBackground)
                            .cornerRadius(AppSpacing.cornerRadiusMedium)
                    }
                    .buttonStyle(.plain)
                    .accessibilityLabel(slot)
                    .accessibilityHint("Select this time slot")
                }
            }
            .padding(.horizontal, AppSpacing.screenHorizontal)
        }
    }

    private func confirmReschedule() {
        guard let selectedDate, let selectedTime else { return }

        appointmentStore.rescheduleUpcomingAppointment(to: selectedDate, time: selectedTime)

        if let updatedAppointment = appointmentStore.upcomingAppointment {
            notificationStore.addRescheduledNotification(for: updatedAppointment)
        }

        showConfirmation = true
    }
}

#Preview {
    NavigationStack {
        RescheduleAppointmentView()
            .environmentObject(AppointmentStore())
            .environmentObject(AppNotificationStore())
    }
}

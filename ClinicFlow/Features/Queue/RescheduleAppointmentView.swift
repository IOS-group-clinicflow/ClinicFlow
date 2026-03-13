//
//  RescheduleAppointmentView.swift
//  ClinicFlow
//
//  Created by Kawish Jayawardena on 2026-03-13.
//

import SwiftUI

struct RescheduleAppointmentView: View {
    @State private var selectedDate = Date().addingTimeInterval(60 * 60 * 24)
    @State private var selectedTime = "10:30 AM"
    @State private var showConfirmation = false

    private let timeSlots = ["08:30 AM", "09:00 AM", "09:30 AM", "10:00 AM", "10:30 AM", "11:00 AM", "02:00 PM", "03:00 PM"]

    var body: some View {
        ScrollView {
            VStack(spacing: AppSpacing.sectionSpacing) {
                AppointmentCard(appointment: MockData.upcomingAppointment)

                VStack(alignment: .leading, spacing: AppSpacing.sm) {
                    Text("Select New Date")
                        .font(AppTypography.headline)
                    DatePicker("", selection: $selectedDate, in: Date()..., displayedComponents: .date)
                        .datePickerStyle(.graphical)
                        .labelsHidden()
                }
                .padding(AppSpacing.cardPadding)
                .background(AppColors.cardBackground)
                .cornerRadius(AppSpacing.cornerRadiusMedium)
                .padding(.horizontal, AppSpacing.screenHorizontal)

                VStack(alignment: .leading, spacing: AppSpacing.md) {
                    Text("Select New Time")
                        .font(AppTypography.headline)

                    LazyVGrid(columns: [GridItem(.adaptive(minimum: 120), spacing: AppSpacing.sm)], spacing: AppSpacing.sm) {
                        ForEach(timeSlots, id: \.self) { slot in
                            Button {
                                selectedTime = slot
                            } label: {
                                Text(slot)
                                    .font(AppTypography.subheadline)
                                    .foregroundColor(selectedTime == slot ? .white : AppColors.textPrimary)
                                    .frame(maxWidth: .infinity)
                                    .frame(height: 40)
                                    .background(selectedTime == slot ? AppColors.primary : AppColors.secondaryBackground)
                                    .cornerRadius(AppSpacing.cornerRadiusSmall)
                            }
                            .buttonStyle(.plain)
                        }
                    }
                }
                .padding(AppSpacing.cardPadding)
                .background(AppColors.cardBackground)
                .cornerRadius(AppSpacing.cornerRadiusMedium)
                .padding(.horizontal, AppSpacing.screenHorizontal)

                PrimaryButton(title: "Confirm Reschedule", icon: "calendar.badge.clock") {
                    showConfirmation = true
                }
            }
            .padding(.top)
            .padding(.bottom, AppSpacing.lg)
        }
        .background(AppColors.background)
        .navigationTitle("Reschedule")
        .navigationBarTitleDisplayMode(.inline)
        .alert("Appointment Rescheduled", isPresented: $showConfirmation) {
            Button("OK", role: .cancel) {}
        } message: {
            Text("Your new appointment is on \(selectedDate.formatted(.dateTime.day().month().year())) at \(selectedTime).")
        }
    }
}

#Preview {
    NavigationStack {
        RescheduleAppointmentView()
    }
}

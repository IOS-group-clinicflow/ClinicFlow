//
//  MyVisitsView.swift
//  ClinicFlow
//
//  Created by Kawish Jayawardena on 2026-03-12.
//

import SwiftUI

struct MyVisitsView: View {
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: AppSpacing.sectionSpacing) {
                    SectionHeader(title: "Upcoming")
                    AppointmentCard(appointment: MockData.upcomingAppointment)

                    VStack(spacing: 0) {
                        NavigationLink {
                            RescheduleAppointmentView()
                        } label: {
                            SettingsRow(icon: "calendar.badge.clock", title: "Reschedule Appointment", subtitle: "Choose a new date and time", iconColor: AppColors.warning)
                        }
                        .buttonStyle(.plain)

                        Divider().padding(.leading, 76)

                        NavigationLink {
                            CancelAppointmentView()
                        } label: {
                            SettingsRow(icon: "xmark.circle", title: "Cancel Appointment", subtitle: "Cancel your upcoming visit", iconColor: AppColors.error)
                        }
                        .buttonStyle(.plain)
                    }
                    .background(AppColors.cardBackground)
                    .cornerRadius(AppSpacing.cornerRadiusMedium)
                    .padding(.horizontal, AppSpacing.screenHorizontal)

                    SectionHeader(title: "Visit History")

                    ForEach(MockData.pastAppointments) { appointment in
                        AppointmentCard(appointment: appointment)
                    }

                    if MockData.pastAppointments.isEmpty {
                        EmptyStateView(
                            icon: "clock.arrow.circlepath",
                            title: "No Visit History",
                            message: "Completed visits will appear here once you attend appointments."
                        )
                    }

                    SectionHeader(title: "Need Help?", actionTitle: "Contact Clinic") {}

                    Text("You can reschedule or cancel upcoming appointments from visit details.")
                        .font(AppTypography.subheadline)
                        .foregroundColor(AppColors.textSecondary)
                        .padding(.horizontal, AppSpacing.screenHorizontal)
                }
                .padding(.top)
                .padding(.bottom, AppSpacing.lg)
            }
            .background(AppColors.background)
            .navigationTitle("My Visits")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    MyVisitsView()
}

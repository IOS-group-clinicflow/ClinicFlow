//
//  MyVisitsView.swift
//  ClinicFlow
//
//  Created by Kawish Jayawardena on 2026-03-12.
//

import SwiftUI

struct MyVisitsView: View {
    @EnvironmentObject private var appointmentStore: AppointmentStore

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: AppSpacing.sectionSpacing) {
                    SectionHeader(title: "Upcoming")

                    if let upcomingAppointment = appointmentStore.upcomingAppointment {
                        AppointmentCard(appointment: upcomingAppointment)

                        VStack(spacing: 0) {
                            NavigationLink {
                                LiveQueueView()
                            } label: {
                                SettingsRow(icon: "person.3.sequence.fill", title: "Live Queue", subtitle: "Track the current queue in real time", iconColor: AppColors.primary)
                            }
                            .buttonStyle(.plain)

                            Divider().padding(.leading, 76)

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
                    } else {
                        EmptyStateView(
                            icon: "calendar.badge.exclamationmark",
                            title: "No Upcoming Appointment",
                            message: "Once you book a visit, the live queue, reschedule, and cancellation options will appear here."
                        )
                    }

                    SectionHeader(title: "Visit History")

                    ForEach(appointmentStore.pastAppointments) { appointment in
                        AppointmentCard(appointment: appointment)
                    }

                    if appointmentStore.pastAppointments.isEmpty {
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
        .environmentObject(AppointmentStore())
}

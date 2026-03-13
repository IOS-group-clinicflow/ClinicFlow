//
//  HomeView.swift
//  ClinicFlow
//
//  Created by Kawish Jayawardena on 2026-03-12.
//

import SwiftUI

struct HomeView: View {
    @State private var showingUpcomingAppointment = true
    @State private var showingBookingFlow = false

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: AppSpacing.sectionSpacing) {
                    VStack(alignment: .leading, spacing: AppSpacing.xs) {
                        Text("Welcome back, \(MockData.currentUser.name.components(separatedBy: " ").first ?? "Patient")")
                            .font(AppTypography.largeTitle)
                            .foregroundColor(AppColors.textPrimary)

                        Text("How are you feeling today?")
                            .font(AppTypography.body)
                            .foregroundColor(AppColors.textSecondary)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, AppSpacing.screenHorizontal)
                        .padding(.top)

                    Picker("Home State", selection: $showingUpcomingAppointment) {
                        Text("With Appointment").tag(true)
                        Text("No Appointment").tag(false)
                    }
                    .pickerStyle(.segmented)
                    .padding(.horizontal, AppSpacing.screenHorizontal)

                    if showingUpcomingAppointment {
                        SectionHeader(title: "Upcoming Appointment")
                        AppointmentCard(appointment: MockData.upcomingAppointment)

                        SectionHeader(title: "Live Queue")
                        QueueStatusCard(
                            currentNumber: 12,
                            yourNumber: 15,
                            estimatedWait: "15 min",
                            doctorName: MockData.upcomingAppointment.doctorName
                        )
                    } else {
                        EmptyStateView(
                            icon: "calendar.badge.plus",
                            title: "No Upcoming Appointment",
                            message: "You don’t have any upcoming appointments. Tap below to start booking.",
                            buttonTitle: "Book Appointment"
                        ) {
                            showingBookingFlow = true
                        }
                    }

                    SectionHeader(title: "Find Specialist", actionTitle: "View All") {}

                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: AppSpacing.sm + 4) {
                            ForEach(Array(MockData.specialties.prefix(6)), id: \.self) { specialty in
                                SpecialistTile(
                                    specialty: specialty,
                                    icon: SpecialistTile.iconFor(specialty)
                                ) {
                                    showingBookingFlow = true
                                }
                            }
                        }
                        .padding(.horizontal, AppSpacing.screenHorizontal)
                    }

                    SectionHeader(title: "Linked Profiles")
                    ForEach(MockData.linkedPatients.prefix(2)) { patient in
                        PatientProfileCard(patient: patient) {}
                    }
                }
                .padding(.bottom, AppSpacing.lg)
            }
            .background(AppColors.background)
            .navigationTitle("Home")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        showingBookingFlow = true
                    } label: {
                        Image(systemName: "plus.circle.fill")
                            .foregroundColor(AppColors.primary)
                    }
                    .accessibilityLabel("Book appointment")
                }
            }
            .sheet(isPresented: $showingBookingFlow) {
                BookingFlowView()
            }
        }
    }
}

#Preview {
    HomeView()
}

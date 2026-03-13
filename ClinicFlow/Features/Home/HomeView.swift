//
//  HomeView.swift
//  ClinicFlow
//
//  Created by Kawish Jayawardena on 2026-03-12.
//

import SwiftUI

struct HomeView: View {
    @State private var showingBookingFlow = false
    @State private var showsUpcomingAppointment = true

    private let pageBackground = Color(red: 0.96, green: 0.96, blue: 0.97)
    private let headlineColor = Color(red: 0.12, green: 0.16, blue: 0.27)
    private let mutedTextColor = Color(red: 0.51, green: 0.57, blue: 0.68)
    private let cardBackground = Color.white
    private let accentBlue = Color(red: 0.14, green: 0.44, blue: 0.94)
    private let softBlue = Color(red: 0.91, green: 0.94, blue: 0.98)
    private let cardShadow = Color.black.opacity(0.05)

    var body: some View {
        ZStack {
            pageBackground
                .ignoresSafeArea()

            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 24) {
                    topHeader
                    appointmentSection
                    reminderCard
                }
                .padding(.horizontal, 20)
                .padding(.top, 8)
                .padding(.bottom, 32)
            }
        }
        .toolbar(.hidden, for: .navigationBar)
        .sheet(isPresented: $showingBookingFlow) {
            BookingFlowView()
        }
    }

    private var topHeader: some View {
        HStack(alignment: .center, spacing: 16) {
            HStack(spacing: 12) {
                HomeAvatarCluster()

                VStack(alignment: .leading, spacing: 4) {
                    Text("Welcome back,")
                        .font(.system(size: 15, weight: .semibold))
                        .foregroundColor(mutedTextColor)

                    Text(MockData.currentUser.name)
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(headlineColor)
                        .lineLimit(1)
                        .minimumScaleFactor(0.85)
                }
            }

            Spacer(minLength: 12)

            Button {
            } label: {
                ZStack(alignment: .topTrailing) {
                    Circle()
                        .fill(cardBackground)
                        .frame(width: 44, height: 44)
                        .shadow(color: Color.black.opacity(0.08), radius: 10, x: 0, y: 4)

                    Image(systemName: "bell")
                        .font(.system(size: 17, weight: .semibold))
                        .foregroundColor(mutedTextColor)

                    Circle()
                        .fill(Color(red: 0.93, green: 0.33, blue: 0.29))
                        .frame(width: 10, height: 10)
                        .overlay(
                            Circle()
                                .stroke(cardBackground, lineWidth: 2)
                        )
                        .offset(x: 6, y: -5)
                }
                .frame(width: 44, height: 44)
            }
            .buttonStyle(.plain)
            .accessibilityLabel("Notifications")
        }
        .padding(.top, 2)
    }

    private var appointmentSection: some View {
        VStack(alignment: .leading, spacing: 18) {
            Text("Today's Appointment")
                .font(.system(size: 26, weight: .bold))
                .foregroundColor(headlineColor)

            Group {
                if showsUpcomingAppointment {
                    upcomingAppointmentCard
                } else {
                    emptyAppointmentCard
                }
            }
        }
    }

    private var upcomingAppointmentCard: some View {
        VStack(alignment: .leading, spacing: 18) {
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Upcoming Visit")
                        .font(.system(size: 15, weight: .semibold))
                        .foregroundColor(accentBlue)

                    Text(MockData.upcomingAppointment.doctorName)
                        .font(.system(size: 24, weight: .bold))
                        .foregroundColor(headlineColor)
                        .fixedSize(horizontal: false, vertical: true)

                    Text(MockData.upcomingAppointment.specialty)
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(mutedTextColor)
                }

                Spacer(minLength: 16)

                StatusBadge(text: MockData.upcomingAppointment.status, style: .info)
            }

            HStack(spacing: 12) {
                appointmentInfoPill(
                    title: MockData.upcomingAppointment.date,
                    systemImage: "calendar"
                )

                appointmentInfoPill(
                    title: MockData.upcomingAppointment.time,
                    systemImage: "clock"
                )
            }

            HStack(alignment: .center, spacing: 12) {
                ZStack {
                    RoundedRectangle(cornerRadius: 20, style: .continuous)
                        .fill(softBlue)
                        .frame(width: 74, height: 74)

                    Image(systemName: "cross.case.fill")
                        .font(.system(size: 32, weight: .medium))
                        .foregroundColor(accentBlue)
                }

                VStack(alignment: .leading, spacing: 6) {
                    Text("Clinic")
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundColor(mutedTextColor)

                    Text(MockData.upcomingAppointment.location)
                        .font(.system(size: 17, weight: .semibold))
                        .foregroundColor(headlineColor)
                        .fixedSize(horizontal: false, vertical: true)
                }
            }

            HStack(spacing: 12) {
                Button {
                } label: {
                    Text("View Queue")
                        .font(.system(size: 17, weight: .bold))
                        .foregroundColor(accentBlue)
                        .frame(maxWidth: .infinity)
                        .frame(height: 54)
                        .background(softBlue)
                        .clipShape(RoundedRectangle(cornerRadius: 18, style: .continuous))
                }

                Button {
                    showingBookingFlow = true
                } label: {
                    Text("Book Again")
                        .font(.system(size: 17, weight: .bold))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 54)
                        .background(accentBlue)
                        .clipShape(RoundedRectangle(cornerRadius: 18, style: .continuous))
                }
            }
            .buttonStyle(.plain)
        }
        .padding(.horizontal, 22)
        .padding(.vertical, 24)
        .frame(maxWidth: .infinity, minHeight: 296, alignment: .topLeading)
        .background(cardBackground)
        .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
        .shadow(color: cardShadow, radius: 18, x: 0, y: 8)
    }

    private var emptyAppointmentCard: some View {
        VStack(spacing: 22) {
            ZStack {
                RoundedRectangle(cornerRadius: 30, style: .continuous)
                    .fill(softBlue)
                    .frame(width: 156, height: 156)

                Image(systemName: "calendar.badge.plus")
                    .font(.system(size: 62, weight: .medium))
                    .foregroundColor(accentBlue.opacity(0.45))
            }
            .padding(.top, 20)

            Text("No appointments today")
                .font(.system(size: 28, weight: .bold))
                .foregroundColor(headlineColor)
                .multilineTextAlignment(.center)

            Text("Take a proactive step for your health and schedule a check-up.")
                .font(.system(size: 19, weight: .medium))
                .foregroundColor(mutedTextColor)
                .multilineTextAlignment(.center)
                .lineSpacing(5)
                .padding(.horizontal, 24)

            Button {
                showingBookingFlow = true
            } label: {
                HStack(spacing: 10) {
                    Spacer()

                    Text("Book Now")
                        .font(.system(size: 22, weight: .bold))

                    Image(systemName: "chevron.right")
                        .font(.system(size: 18, weight: .bold))

                    Spacer()
                }
                .foregroundColor(.white)
                .frame(height: 70)
                .background(accentBlue)
                .clipShape(RoundedRectangle(cornerRadius: 24, style: .continuous))
                .shadow(color: accentBlue.opacity(0.18), radius: 16, x: 0, y: 10)
            }
            .buttonStyle(.plain)
            .padding(.horizontal, 22)
            .padding(.bottom, 24)
        }
        .frame(maxWidth: .infinity, minHeight: 430)
        .background(cardBackground)
        .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
        .shadow(color: cardShadow, radius: 18, x: 0, y: 8)
    }

    private func appointmentInfoPill(title: String, systemImage: String) -> some View {
        HStack(spacing: 8) {
            Image(systemName: systemImage)
                .font(.system(size: 15, weight: .semibold))
                .foregroundColor(accentBlue)

            Text(title)
                .font(.system(size: 15, weight: .semibold))
                .foregroundColor(headlineColor)
                .lineLimit(1)
                .minimumScaleFactor(0.85)
        }
        .padding(.horizontal, 14)
        .frame(height: 44)
        .background(softBlue.opacity(0.85))
        .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
    }

    private var reminderCard: some View {
        VStack(alignment: .leading, spacing: 18) {
            HStack(spacing: 10) {
                Image(systemName: "bell.badge")
                    .font(.system(size: 22, weight: .bold))

                Text("REMINDER")
                    .font(.system(size: 22, weight: .bold))
                    .tracking(0.6)
            }
            .foregroundColor(.white.opacity(0.95))

            Text("Flu Shot Season")
                .font(.system(size: 26, weight: .bold))
                .foregroundColor(.white)

            Text("Protect yourself and your family. Schedule your vaccination today.")
                .font(.system(size: 19, weight: .medium))
                .foregroundColor(.white.opacity(0.9))
                .lineSpacing(5)
                .fixedSize(horizontal: false, vertical: true)

            Button {
                showingBookingFlow = true
            } label: {
                Text("Schedule Now")
                    .font(.system(size: 18, weight: .bold))
                    .foregroundColor(accentBlue)
                    .padding(.horizontal, 32)
                    .frame(height: 64)
                    .background(Color.white)
                    .clipShape(RoundedRectangle(cornerRadius: 22, style: .continuous))
            }
            .buttonStyle(.plain)
        }
        .padding(.horizontal, 24)
        .padding(.vertical, 28)
        .frame(maxWidth: .infinity, minHeight: 228, alignment: .leading)
        .background(
            LinearGradient(
                colors: [
                    Color(red: 0.17, green: 0.47, blue: 0.93),
                    Color(red: 0.43, green: 0.66, blue: 0.96)
                ],
                startPoint: .leading,
                endPoint: .trailing
            )
        )
        .clipShape(RoundedRectangle(cornerRadius: 34, style: .continuous))
        .shadow(color: Color(red: 0.17, green: 0.47, blue: 0.93).opacity(0.22), radius: 20, x: 0, y: 12)
    }
}

private struct HomeAvatarCluster: View {
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            Circle()
                .fill(Color.white)
                .frame(width: 38, height: 38)
                .overlay(
                    ZStack {
                        Circle()
                            .fill(Color(red: 0.92, green: 0.96, blue: 1.0))
                            .frame(width: 38, height: 38)

                        Grid(horizontalSpacing: 1, verticalSpacing: 1) {
                            GridRow {
                                MiniAvatar(background: Color(red: 0.99, green: 0.95, blue: 0.78), shirt: Color(red: 0.28, green: 0.68, blue: 0.93))
                                MiniAvatar(background: Color(red: 0.99, green: 0.90, blue: 0.76), shirt: Color(red: 0.98, green: 0.64, blue: 0.18))
                            }

                            GridRow {
                                MiniAvatar(background: Color(red: 0.98, green: 0.94, blue: 0.83), shirt: Color(red: 0.47, green: 0.61, blue: 0.96))
                                MiniAvatar(background: Color(red: 0.95, green: 0.98, blue: 0.87), shirt: Color(red: 0.24, green: 0.78, blue: 0.47))
                            }
                        }
                        .clipShape(Circle())
                        .padding(3)
                    }
                )

            Circle()
                .fill(Color(red: 0.17, green: 0.75, blue: 0.36))
                .frame(width: 10, height: 10)
                .overlay(Circle().stroke(Color.white, lineWidth: 2))
        }
    }
}

private struct MiniAvatar: View {
    let background: Color
    let shirt: Color

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10, style: .continuous)
                .fill(background)
                .frame(width: 14, height: 14)

            VStack(spacing: 1) {
                Circle()
                    .fill(Color(red: 0.88, green: 0.67, blue: 0.47))
                    .frame(width: 4, height: 4)
                    .overlay(alignment: .top) {
                        Capsule()
                            .fill(Color(red: 0.15, green: 0.19, blue: 0.28))
                            .frame(width: 5, height: 2)
                            .offset(y: -0.5)
                    }

                RoundedRectangle(cornerRadius: 4, style: .continuous)
                    .fill(shirt)
                    .frame(width: 6.5, height: 5)
            }
        }
    }
}

#Preview {
    HomeView()
}

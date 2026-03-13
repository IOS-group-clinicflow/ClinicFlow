//
//  CancelAppointmentView.swift
//  ClinicFlow
//
//  Created by Kawish Jayawardena on 2026-03-13.
//

import SwiftUI

struct CancelAppointmentView: View {
    @State private var reason = ""
    @State private var showCancellationAlert = false

    private let reasons = [
        "Feeling better",
        "Need a different date",
        "Booked by mistake",
        "Clinic location issue",
        "Other"
    ]

    var body: some View {
        ScrollView {
            VStack(spacing: AppSpacing.sectionSpacing) {
                AppointmentCard(appointment: MockData.upcomingAppointment)

                VStack(alignment: .leading, spacing: AppSpacing.md) {
                    Text("Reason for Cancellation")
                        .font(AppTypography.headline)

                    ForEach(reasons, id: \.self) { item in
                        Button {
                            reason = item
                        } label: {
                            HStack {
                                Text(item)
                                    .font(AppTypography.body)
                                    .foregroundColor(AppColors.textPrimary)
                                Spacer()
                                if reason == item {
                                    Image(systemName: "checkmark.circle.fill")
                                        .foregroundColor(AppColors.error)
                                }
                            }
                            .padding(AppSpacing.md)
                            .background(AppColors.secondaryBackground)
                            .cornerRadius(AppSpacing.cornerRadiusSmall)
                        }
                        .buttonStyle(.plain)
                    }
                }
                .padding(AppSpacing.cardPadding)
                .background(AppColors.cardBackground)
                .cornerRadius(AppSpacing.cornerRadiusMedium)
                .padding(.horizontal, AppSpacing.screenHorizontal)

                PrimaryButton(title: "Cancel Appointment") {
                    showCancellationAlert = true
                }
                .disabled(reason.isEmpty)
                .opacity(reason.isEmpty ? 0.5 : 1)
            }
            .padding(.top)
            .padding(.bottom, AppSpacing.lg)
        }
        .background(AppColors.background)
        .navigationTitle("Cancel Appointment")
        .navigationBarTitleDisplayMode(.inline)
        .alert("Appointment Cancelled", isPresented: $showCancellationAlert) {
            Button("OK", role: .cancel) {}
        } message: {
            Text("Your appointment has been cancelled.")
        }
    }
}

#Preview {
    NavigationStack {
        CancelAppointmentView()
    }
}

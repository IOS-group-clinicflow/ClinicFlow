//
//  LiveQueueView.swift
//  ClinicFlow
//
//  Created by Kawish Jayawardena on 2026-03-13.
//

import SwiftUI

struct LiveQueueView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: AppSpacing.sectionSpacing) {
                QueueStatusCard(
                    currentNumber: 12,
                    yourNumber: 15,
                    estimatedWait: "15 min",
                    doctorName: MockData.upcomingAppointment.doctorName
                )

                HStack(alignment: .top, spacing: AppSpacing.sm) {
                    Image(systemName: "info.circle.fill")
                        .foregroundColor(AppColors.info)
                    Text("Keep notifications enabled to receive real-time queue updates.")
                        .font(AppTypography.subheadline)
                        .foregroundColor(AppColors.textSecondary)
                    Spacer()
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
        .navigationTitle("Live Queue")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        LiveQueueView()
    }
}

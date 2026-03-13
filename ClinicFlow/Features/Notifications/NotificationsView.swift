//
//  NotificationsView.swift
//  ClinicFlow
//
//  Created by Kawish Jayawardena on 2026-03-12.
//

import SwiftUI

struct NotificationsView: View {
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: AppSpacing.sectionSpacing) {
                    SectionHeader(title: "Recent Updates", actionTitle: "Mark All Read") {}

                    if MockData.notifications.isEmpty {
                        EmptyStateView(
                            icon: "bell.slash",
                            title: "No Notifications",
                            message: "Appointment reminders and queue updates will appear here."
                        )
                    } else {
                        ForEach(MockData.notifications) { item in
                            NotificationCard(notification: item)
                        }
                    }

                    Text("Notifications include reminders, queue changes, result updates, and payment alerts.")
                        .font(AppTypography.caption)
                        .foregroundColor(AppColors.textTertiary)
                        .padding(.horizontal, AppSpacing.screenHorizontal)
                }
                .padding(.top)
                .padding(.bottom, AppSpacing.lg)
            }
            .background(AppColors.background)
            .navigationTitle("Notifications")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    NotificationsView()
}

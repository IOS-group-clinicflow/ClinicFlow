//
//  NotificationsView.swift
//  ClinicFlow
//
//  Created by Kawish Jayawardena on 2026-03-12.
//

import SwiftUI

struct NotificationsView: View {
    @EnvironmentObject private var notificationStore: AppNotificationStore
    @State private var selectedFilter: NotificationFilter = .all

    private let pageBackground = AppColors.groupedBackground
    private let sectionStrip = AppColors.secondaryBackground
    private let titleColor = AppColors.textPrimary
    private let mutedText = AppColors.textSecondary
    private let accentBlue = Color(red: 0.15, green: 0.47, blue: 0.95)

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 0) {
                filterBar
                    .padding(.horizontal, 14)
                    .padding(.top, 14)
                    .padding(.bottom, 14)

                if visibleNotifications.isEmpty {
                    emptyState
                        .frame(maxWidth: .infinity)
                        .padding(.top, 120)
                } else {
                    LazyVStack(spacing: 0, pinnedViews: []) {
                        ForEach(orderedSections, id: \.self) { section in
                            let items = notifications(in: section)

                            if !items.isEmpty {
                                sectionHeader(section.rawValue)

                                VStack(spacing: 0) {
                                    ForEach(items.indices, id: \.self) { index in
                                        NotificationCard(
                                            notification: items[index],
                                            showsDivider: index < items.count - 1
                                        )
                                    }
                                }
                            }
                        }
                    }
                    .padding(.bottom, 24)
                }
            }
        }
        .background(pageBackground)
        .toolbar(.visible, for: .navigationBar)
        .navigationTitle("Notifications")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button("Clear all") {
                    notificationStore.clearAll()
                }
                .font(.system(size: 15, weight: .semibold))
                .foregroundColor(accentBlue)
                .disabled(notificationStore.notifications.isEmpty)
            }
        }
    }

    private var filterBar: some View {
        Picker("Notification filter", selection: $selectedFilter) {
            ForEach(NotificationFilter.allCases, id: \.self) { filter in
                Text(filter.rawValue)
                    .tag(filter)
            }
        }
        .pickerStyle(.segmented)
        .tint(accentBlue)
    }

    private func sectionHeader(_ title: String) -> some View {
        HStack {
            Text(title.uppercased())
                .font(.system(size: 13, weight: .bold))
                .tracking(1.1)
                .foregroundColor(AppColors.textTertiary)

            Spacer()
        }
        .padding(.horizontal, 14)
        .frame(height: 28)
        .background(sectionStrip)
    }

    private var emptyState: some View {
        VStack(spacing: 20) {
            ZStack(alignment: .bottomTrailing) {
                Circle()
                    .fill(AppColors.primaryLight)
                    .frame(width: 110, height: 110)

                Image(systemName: "bell.slash")
                    .font(.system(size: 42, weight: .light))
                    .foregroundColor(accentBlue.opacity(0.65))

                Circle()
                    .fill(AppColors.secondaryBackground)
                    .frame(width: 34, height: 34)
                    .overlay(
                        Image(systemName: "cross.case")
                            .font(.system(size: 15, weight: .semibold))
                            .foregroundColor(accentBlue)
                    )
                    .shadow(color: .black.opacity(0.06), radius: 8, x: 0, y: 4)
                    .offset(x: 8, y: 6)
            }

            Text(emptyTitle)
                .font(.system(size: 22, weight: .bold))
                .foregroundColor(titleColor)

            Text(emptyMessage)
                .font(.system(size: 16, weight: .medium))
                .foregroundColor(mutedText)
                .multilineTextAlignment(.center)
                .lineSpacing(4)
        }
        .padding(.horizontal, 48)
    }

    private var orderedSections: [NotificationSection] {
        NotificationSection.allCases
    }

    private var visibleNotifications: [NotificationItem] {
        switch selectedFilter {
        case .all:
            return notificationStore.notifications
        case .unread:
            return notificationStore.notifications.filter(\.isUnread)
        }
    }

    private func notifications(in section: NotificationSection) -> [NotificationItem] {
        visibleNotifications.filter { $0.section == section }
    }

    private var emptyTitle: String {
        selectedFilter == .unread ? "No unread notifications" : "All caught up"
    }

    private var emptyMessage: String {
        selectedFilter == .unread
            ? "You have read all your recent updates."
            : "You don't have any new notifications at the moment."
    }
}

private enum NotificationFilter: String, CaseIterable {
    case all = "All"
    case unread = "Unread"
}

struct NotificationsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            NotificationsView()
                .environmentObject(AppNotificationStore())
        }
    }
}

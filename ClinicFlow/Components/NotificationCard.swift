//
//  NotificationCard.swift
//  ClinicFlow
//
//  Created by COBSCCOMP242P-070 on 2026-03-12.
//

import SwiftUI

struct NotificationCard: View {
    let notification: NotificationItem
    var showsDivider: Bool = true

    var body: some View {
        VStack(spacing: 0) {
            HStack(alignment: .top, spacing: 12) {
                Circle()
                    .fill(notification.isUnread ? accentBlue : Color.clear)
                    .frame(width: 6, height: 6)
                    .padding(.top, 18)

                RoundedRectangle(cornerRadius: 14, style: .continuous)
                    .fill(iconBackground)
                    .frame(width: 40, height: 40)
                    .overlay {
                        Image(systemName: iconName)
                            .font(.system(size: 17, weight: .semibold))
                            .foregroundColor(iconTint)
                    }

                VStack(alignment: .leading, spacing: 5) {
                    HStack(alignment: .firstTextBaseline, spacing: 12) {
                        Text(notification.title)
                            .font(.system(size: 16, weight: .bold))
                            .foregroundColor(titleColor)
                            .lineLimit(1)

                        Spacer(minLength: 8)

                        Text(notification.time)
                            .font(.system(size: 12, weight: .semibold))
                            .foregroundColor(timestampColor)
                            .lineLimit(1)
                    }

                    Text(notification.message)
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(messageColor)
                        .lineSpacing(3)
                        .fixedSize(horizontal: false, vertical: true)
                }
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 14)
            .opacity(notification.isUnread ? 1 : 0.52)

            if showsDivider {
                Divider()
                    .padding(.leading, 70)
            }
        }
        .background(Color.white)
    }

    private let accentBlue = Color(red: 0.15, green: 0.47, blue: 0.95)

    private var iconName: String {
        switch notification.category.lowercased() {
        case "delay":
            return "clock"
        case "queue":
            return "person.3.fill"
        case "confirmed":
            return "calendar"
        case "results":
            return "testtube.2"
        case "notice":
            return "bell"
        case "tip":
            return "lightbulb"
        default:
            return "bell"
        }
    }

    private var iconTint: Color {
        switch notification.category.lowercased() {
        case "delay":
            return Color(red: 0.98, green: 0.49, blue: 0.16)
        case "queue":
            return accentBlue
        case "confirmed":
            return Color(red: 0.22, green: 0.74, blue: 0.37)
        case "results":
            return Color(red: 0.63, green: 0.32, blue: 0.94)
        case "notice":
            return Color(red: 0.58, green: 0.62, blue: 0.69)
        case "tip":
            return Color(red: 0.31, green: 0.77, blue: 0.87)
        default:
            return accentBlue
        }
    }

    private var iconBackground: Color {
        switch notification.category.lowercased() {
        case "delay":
            return Color(red: 1.0, green: 0.94, blue: 0.87)
        case "queue":
            return Color(red: 0.86, green: 0.91, blue: 0.99)
        case "confirmed":
            return Color(red: 0.84, green: 0.96, blue: 0.87)
        case "results":
            return Color(red: 0.93, green: 0.87, blue: 1.0)
        case "notice":
            return Color(red: 0.95, green: 0.96, blue: 0.97)
        case "tip":
            return Color(red: 0.84, green: 0.97, blue: 0.99)
        default:
            return Color(red: 0.91, green: 0.94, blue: 0.99)
        }
    }

    private var titleColor: Color {
        notification.isUnread ? Color(red: 0.16, green: 0.19, blue: 0.28) : Color(red: 0.46, green: 0.50, blue: 0.59)
    }

    private var messageColor: Color {
        notification.isUnread ? Color(red: 0.39, green: 0.45, blue: 0.55) : Color(red: 0.61, green: 0.65, blue: 0.72)
    }

    private var timestampColor: Color {
        notification.isUnread ? Color(red: 0.68, green: 0.72, blue: 0.79) : Color(red: 0.74, green: 0.77, blue: 0.82)
    }
}

struct NotificationCard_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 0) {
            ForEach(MockData.notifications.indices, id: \.self) { index in
                NotificationCard(
                    notification: MockData.notifications[index],
                    showsDivider: index < MockData.notifications.count - 1
                )
            }
        }
        .background(Color(.systemGroupedBackground))
    }
}

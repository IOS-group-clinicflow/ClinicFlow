//
//  AppNotificationStore.swift
//  ClinicFlow
//
//  Created by Kawish Jayawardena on 2026-03-14.
//

import Combine
import Foundation

@MainActor
final class AppNotificationStore: ObservableObject {
    @Published var notifications: [NotificationItem]

    init(notifications: [NotificationItem]? = nil) {
        self.notifications = notifications ?? MockData.notifications
    }

    func clearAll() {
        notifications.removeAll()
    }

    func addAppointmentNotification(for state: BookingFlowState) {
        let patientName = state.selectedPatient?.name ?? "Your"
        let doctorName = state.selectedDoctor?.name ?? "your doctor"
        let dateText = formattedDate(state.selectedDate)
        let timeText = state.selectedTime ?? "your selected time"

        let notification = NotificationItem(
            id: UUID(),
            title: "Appointment Confirmed",
            message: "\(patientName)'s appointment with \(doctorName) is booked for \(dateText) at \(timeText).",
            time: "Just now",
            category: "confirmed",
            section: .today,
            isUnread: true
        )

        notifications.insert(notification, at: 0)
    }

    private func formattedDate(_ date: Date?) -> String {
        guard let date else { return "your selected date" }
        return date.formatted(.dateTime.day().month().year())
    }
}

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

        insertNotification(
            title: "Appointment Confirmed",
            message: "\(patientName)'s appointment with \(doctorName) is booked for \(dateText) at \(timeText).",
            category: "confirmed"
        )
    }

    func addRescheduledNotification(for appointment: Appointment) {
        insertNotification(
            title: "Appointment Rescheduled",
            message: "Your appointment with \(appointment.doctorName) has been moved to \(appointment.date) at \(appointment.time).",
            category: "confirmed"
        )
    }

    func addCancelledNotification(for appointment: Appointment, reason: String) {
        insertNotification(
            title: "Appointment Cancelled",
            message: "Your appointment with \(appointment.doctorName) on \(appointment.date) at \(appointment.time) was cancelled. Reason: \(reason).",
            category: "notice"
        )
    }

    private func formattedDate(_ date: Date?) -> String {
        guard let date else { return "your selected date" }
        return date.formatted(.dateTime.day().month().year())
    }

    private func insertNotification(title: String, message: String, category: String) {
        let notification = NotificationItem(
            id: UUID(),
            title: title,
            message: message,
            time: "Just now",
            category: category,
            section: .today,
            isUnread: true
        )

        notifications.insert(notification, at: 0)
    }
}

//
//  AppointmentStore.swift
//  ClinicFlow
//
//  Created by Kawish Jayawardena on 2026-03-14.
//

import Combine
import Foundation

struct QueueState {
    var nowServing: Int
    var yourNumber: Int
    var notificationsEnabled: Bool
    var lastUpdated: Date

    var estimatedWaitText: String {
        let peopleAhead = max(yourNumber - nowServing, 0)
        return "\(max(peopleAhead * 5, 5)) min"
    }

    var isActive: Bool {
        nowServing < yourNumber
    }
}

@MainActor
final class AppointmentStore: ObservableObject {
    @Published var upcomingAppointment: Appointment?
    @Published var pastAppointments: [Appointment]
    @Published var queueState: QueueState

    init(
        upcomingAppointment: Appointment? = nil,
        pastAppointments: [Appointment]? = nil,
        queueState: QueueState = QueueState(
            nowServing: 12,
            yourNumber: 15,
            notificationsEnabled: true,
            lastUpdated: .now
        )
    ) {
        self.upcomingAppointment = upcomingAppointment ?? MockData.upcomingAppointment
        self.pastAppointments = pastAppointments ?? MockData.pastAppointments
        self.queueState = queueState
    }

    func refreshQueue() {
        guard queueState.isActive else { return }

        let increment = Int.random(in: 0...1)
        queueState.nowServing = min(queueState.nowServing + increment, queueState.yourNumber)
        queueState.lastUpdated = .now
    }

    func toggleQueueNotifications(_ isEnabled: Bool) {
        queueState.notificationsEnabled = isEnabled
    }

    func scheduleAppointment(from bookingState: BookingFlowState) {
        guard
            let patient = bookingState.selectedPatient,
            let doctor = bookingState.selectedDoctor,
            let date = bookingState.selectedDate,
            let time = bookingState.selectedTime
        else {
            return
        }

        upcomingAppointment = Appointment(
            id: UUID(),
            patientName: patient.name,
            doctorName: doctor.name,
            specialty: bookingState.selectedSpecialty ?? doctor.specialty,
            date: formattedDate(date),
            time: time,
            location: "Clinic Flow Medical Centre, Colombo 07",
            status: "Confirmed",
            needsPrePayment: true
        )

        queueState = QueueState(
            nowServing: 12,
            yourNumber: Int.random(in: 14...18),
            notificationsEnabled: queueState.notificationsEnabled,
            lastUpdated: .now
        )
    }

    func rescheduleUpcomingAppointment(to date: Date, time: String) {
        guard let appointment = upcomingAppointment else { return }

        upcomingAppointment = Appointment(
            id: appointment.id,
            patientName: appointment.patientName,
            doctorName: appointment.doctorName,
            specialty: appointment.specialty,
            date: formattedDate(date),
            time: time,
            location: appointment.location,
            status: "Confirmed",
            needsPrePayment: appointment.needsPrePayment
        )

        queueState.lastUpdated = .now
    }

    func cancelUpcomingAppointment() {
        guard let appointment = upcomingAppointment else { return }

        let cancelledAppointment = Appointment(
            id: appointment.id,
            patientName: appointment.patientName,
            doctorName: appointment.doctorName,
            specialty: appointment.specialty,
            date: appointment.date,
            time: appointment.time,
            location: appointment.location,
            status: "Cancelled",
            needsPrePayment: appointment.needsPrePayment
        )

        pastAppointments.insert(cancelledAppointment, at: 0)
        upcomingAppointment = nil
    }

    private func formattedDate(_ date: Date) -> String {
        date.formatted(.dateTime.day().month(.wide).year())
    }
}

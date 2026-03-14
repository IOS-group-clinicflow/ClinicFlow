//
//  BookingFlowView.swift
//  ClinicFlow
//
//  Created by Kawish Jayawardena on 2026-03-13.
//

import SwiftUI

struct BookingFlowView: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject private var appointmentStore: AppointmentStore
    @EnvironmentObject private var notificationStore: AppNotificationStore

    @State private var step: BookingStep = .selectPatient
    @State private var state = BookingFlowState()

    var body: some View {
        NavigationStack {
            Group {
                switch step {
                case .selectPatient:
                    SelectPatientView(state: $state) {
                        step = .findSpecialist
                    }

                case .findSpecialist:
                    FindSpecialistView(state: $state, onBack: {
                        step = .selectPatient
                    }) {
                        step = .selectDoctor
                    }

                case .selectDoctor:
                    SelectDoctorView(state: $state, onBack: {
                        step = .findSpecialist
                    }) {
                        step = .selectDate
                    }

                case .selectDate:
                    SelectAppointmentDateView(state: $state, onBack: {
                        step = .selectDoctor
                    }) {
                        step = .selectTime
                    }

                case .selectTime:
                    SelectAppointmentTimeView(state: $state, onBack: {
                        step = .selectDate
                    }) {
                        step = .confirm
                    }

                case .confirm:
                    ConfirmAppointmentView(state: $state, onBack: {
                        step = .selectTime
                    }) {
                        step = .paymentMethod
                    }

                case .paymentMethod:
                    PaymentMethodView(state: $state, onBack: {
                        step = .confirm
                    }) {
                        appointmentStore.scheduleAppointment(from: state)
                        notificationStore.addAppointmentNotification(for: state)
                        step = .success
                    }

                case .billing:
                    BillingSummaryView(state: $state, onBack: {
                        step = .confirm
                    }) {
                        step = .paymentMethod
                    }

                case .success:
                    BookingSuccessView(state: state) {
                        dismiss()
                    }
                }
            }
            .navigationTitle(title(for: step))
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    if step == .selectPatient {
                        Button("Close") { dismiss() }
                    }
                }
            }
            .background(AppColors.background)
        }
    }

    private func title(for step: BookingStep) -> String {
        switch step {
        case .selectPatient: return "Patient Details"
        case .findSpecialist: return "Find Specialist"
        case .selectDoctor: return "Select Doctor"
        case .selectDate: return "Select Date"
        case .selectTime: return "Select Time"
        case .confirm: return "Booking Review"
        case .billing: return "Billing Summary"
        case .paymentMethod: return "Payment"
        case .success: return "Appointment Booked"
        }
    }
}

#Preview {
    BookingFlowView()
        .environmentObject(AppointmentStore())
        .environmentObject(AppNotificationStore())
}

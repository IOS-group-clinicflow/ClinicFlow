//
//  BookingFlowState.swift
//  ClinicFlow
//
//  Created by Kawish Jayawardena on 2026-03-13.
//

import Foundation

enum BookingStep {
    case selectPatient
    case findSpecialist
    case selectDoctor
    case selectDate
    case selectTime
    case confirm
    case billing
    case paymentMethod
    case success
}

enum PaymentMethod: String, CaseIterable, Identifiable {
    case card = "Credit / Debit Card"
    case insurance = "Insurance"
    case digitalWallet = "Digital Wallet"
    case cashAtClinic = "Pay at Clinic"

    var id: String { rawValue }
}

struct BookingFlowState {
    var selectedPatient: Patient?
    var selectedSpecialty: String?
    var selectedDoctor: Doctor?
    var selectedDate: Date?
    var selectedTime: String?
    var selectedPaymentMethod: PaymentMethod?

    var requiresPrePayment: Bool {
        guard let selectedSpecialty else { return false }
        return selectedSpecialty.localizedCaseInsensitiveContains("obg")
            || selectedSpecialty.localizedCaseInsensitiveContains("ultrasound")
    }

    var isReadyForConfirmation: Bool {
        selectedPatient != nil
            && selectedSpecialty != nil
            && selectedDoctor != nil
            && selectedDate != nil
            && selectedTime != nil
    }
}

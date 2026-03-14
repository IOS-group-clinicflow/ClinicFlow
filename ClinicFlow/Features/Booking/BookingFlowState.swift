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
    case savedCard = "**** **** **** 7867"
    case card = "Credit / Debit Card"
    case applePay = "Apple Pay"
    case payAtCounter = "Pay at Counter"

    var id: String { rawValue }

    var subtitle: String {
        switch self {
        case .savedCard:
            return "Previously saved Visa card"
        case .card:
            return "Add or use a new credit or debit card"
        case .applePay:
            return "Pay quickly with Face ID or Touch ID"
        case .payAtCounter:
            return "Reserve now and pay when you arrive"
        }
    }

    var iconName: String {
        switch self {
        case .savedCard, .card:
            return "creditcard.fill"
        case .applePay:
            return "apple.logo"
        case .payAtCounter:
            return "building.columns.fill"
        }
    }
}

struct BookingFlowState {
    var selectedPatient: Patient?
    var patientFullName = ""
    var patientRelationship = "Self"
    var patientAge = ""
    var patientEmergencyContact = ""
    var patientAllergies = ""
    var patientMedicalHistory = ""
    var patientChronicConditions = ""
    var patientHealthNotes = ""
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

    var isPatientDetailsComplete: Bool {
        !patientFullName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
            && !patientRelationship.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
            && enteredPatientAge != nil
            && !patientEmergencyContact.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }

    var enteredPatientAge: Int? {
        Int(patientAge.trimmingCharacters(in: .whitespacesAndNewlines))
    }

    var consultationFee: Int {
        if let selectedDoctor {
            return selectedDoctor.channelingFee
        }

        guard let selectedSpecialty else { return 4500 }

        switch selectedSpecialty.lowercased() {
        case let specialty where specialty.contains("cardio"):
            return 6500
        case let specialty where specialty.contains("derma"):
            return 5500
        case let specialty where specialty.contains("obg"):
            return 7000
        case let specialty where specialty.contains("pediatri"):
            return 5000
        default:
            return 4500
        }
    }

    var serviceFee: Int {
        500
    }

    var totalFee: Int {
        consultationFee + serviceFee
    }

    var formattedConsultationFee: String {
        Self.currencyText(for: consultationFee)
    }

    var formattedServiceFee: String {
        Self.currencyText(for: serviceFee)
    }

    var formattedTotalFee: String {
        Self.currencyText(for: totalFee)
    }

    mutating func loadPatientDraft(from patient: Patient) {
        selectedPatient = patient
        patientFullName = patient.name
        patientRelationship = patient.relationship
        patientAge = String(patient.age)
        patientEmergencyContact = patient.emergencyContact
        patientAllergies = patient.allergies.joined(separator: ", ")
        patientMedicalHistory = patient.medicalHistory.joined(separator: ", ")
        patientChronicConditions = patient.chronicConditions.joined(separator: ", ")
        patientHealthNotes = patient.healthNotes
    }

    mutating func finalizePatientDetails() {
        guard let age = enteredPatientAge else { return }

        selectedPatient = Patient(
            id: selectedPatient?.id ?? UUID(),
            name: patientFullName.trimmingCharacters(in: .whitespacesAndNewlines),
            relationship: patientRelationship.trimmingCharacters(in: .whitespacesAndNewlines),
            age: age,
            allergies: parsedItems(from: patientAllergies),
            medicalHistory: parsedItems(from: patientMedicalHistory),
            chronicConditions: parsedItems(from: patientChronicConditions),
            emergencyContact: patientEmergencyContact.trimmingCharacters(in: .whitespacesAndNewlines),
            healthNotes: patientHealthNotes.trimmingCharacters(in: .whitespacesAndNewlines)
        )
    }

    private func parsedItems(from text: String) -> [String] {
        text
            .split(separator: ",")
            .map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
            .filter { !$0.isEmpty }
    }

    private static func currencyText(for amount: Int) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = "LKR"
        formatter.maximumFractionDigits = 0
        formatter.locale = Locale(identifier: "en_LK")

        return formatter.string(from: NSNumber(value: amount)) ?? "LKR \(amount)"
    }
}

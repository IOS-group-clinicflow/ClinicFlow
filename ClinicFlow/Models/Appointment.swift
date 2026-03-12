//
//  Appointment.swift
//  ClinicFlow
//
//  Created by COBSCCOMP242P-070 on 2026-03-12.
//

import Foundation

struct Appointment: Identifiable {
    let id: UUID
    let patientName: String
    let doctorName: String
    let specialty: String
    let date: String
    let time: String
    let location: String
    let status: String
    let needsPrePayment: Bool
}

//
//  Patient.swift
//  ClinicFlow
//
//  Created by COBSCCOMP242P-070 on 2026-03-12.
//

import Foundation

struct Patient: Identifiable {
    let id: UUID
    let name: String
    let relationship: String
    let age: Int
    let allergies: [String]
    let medicalHistory: [String]
    let chronicConditions: [String]
    let emergencyContact: String
    let healthNotes: String
}

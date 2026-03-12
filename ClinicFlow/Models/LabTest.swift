//
//  LabTest.swift
//  ClinicFlow
//
//  Created by COBSCCOMP242P-070 on 2026-03-12.
//

import Foundation

struct LabTest: Identifiable {
    let id: UUID
    let name: String
    let location: String
    let status: String
    let requiresPayment: Bool
    let notes: String
}

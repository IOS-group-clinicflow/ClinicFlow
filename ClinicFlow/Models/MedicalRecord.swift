//
//  MedicalRecord.swift
//  ClinicFlow
//
//  Created by COBSCCOMP242P-070 on 2026-03-12.
//

import Foundation

struct MedicalRecord: Identifiable {
    let id: UUID
    let title: String
    let type: String
    let date: String
    let summary: String
    let status: String
}

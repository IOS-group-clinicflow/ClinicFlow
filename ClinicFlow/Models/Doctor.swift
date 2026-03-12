//
//  Doctor.swift
//  ClinicFlow
//
//  Created by COBSCCOMP242P-070 on 2026-03-12.
//

import Foundation

struct Doctor: Identifiable {
    let id: UUID
    let name: String
    let specialty: String
    let availability: String
    let imageName: String
}

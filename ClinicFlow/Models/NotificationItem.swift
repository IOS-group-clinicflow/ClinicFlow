//
//  NotificationItem.swift
//  ClinicFlow
//
//  Created by COBSCCOMP242P-070 on 2026-03-12.
//

import Foundation

struct NotificationItem: Identifiable {
    let id: UUID
    let title: String
    let message: String
    let time: String
    let category: String
}

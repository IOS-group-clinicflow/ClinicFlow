//
//  ClinicFlowApp.swift
//  ClinicFlow
//
//  Created by Kawish Jayawardena on 2026-03-08.
//

import SwiftUI

@main
struct ClinicFlowApp: App {
    @StateObject private var appointmentStore = AppointmentStore()
    @StateObject private var notificationStore = AppNotificationStore()

    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(appointmentStore)
                .environmentObject(notificationStore)
        }
    }
}

//
//  AppAppearanceStore.swift
//  ClinicFlow
//
//  Created by Kawish Jayawardena on 2026-03-14.
//

import Combine
import SwiftUI

enum AppAppearance: String, CaseIterable, Identifiable {
    case light
    case dark

    var id: String { rawValue }

    var title: String {
        switch self {
        case .light: return "Light"
        case .dark: return "Dark"
        }
    }

    var subtitle: String {
        switch self {
        case .light: return "Bright surfaces for daytime viewing"
        case .dark: return "Dimmed colors for low-light environments"
        }
    }

    var iconName: String {
        switch self {
        case .light: return "sun.max.fill"
        case .dark: return "moon.fill"
        }
    }

    var colorScheme: ColorScheme {
        switch self {
        case .light: return .light
        case .dark: return .dark
        }
    }
}

@MainActor
final class AppAppearanceStore: ObservableObject {
    @AppStorage("clinicflow_app_appearance") private var storedAppearance = AppAppearance.light.rawValue

    @Published var appearance: AppAppearance

    init() {
        let savedAppearance = UserDefaults.standard.string(forKey: "clinicflow_app_appearance")
        appearance = AppAppearance(rawValue: savedAppearance ?? AppAppearance.light.rawValue) ?? .light
    }

    var colorScheme: ColorScheme {
        appearance.colorScheme
    }

    func updateAppearance(_ appearance: AppAppearance) {
        self.appearance = appearance
        storedAppearance = appearance.rawValue
    }
}

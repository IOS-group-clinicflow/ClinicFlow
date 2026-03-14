//
//  FloatingAppointmentBanner.swift
//  ClinicFlow
//
//  Created by OpenAI Codex on 2026-03-14.
//

import SwiftUI

struct FloatingAppointmentBanner: View {
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: 12) {
                VStack(alignment: .leading, spacing: 2) {
                    Text("Make an")
                        .font(.system(size: 13, weight: .semibold))
                        .foregroundStyle(AppColors.textSecondary)

                    Text("Appointment")
                        .font(.system(size: 17, weight: .bold))
                        .foregroundStyle(AppColors.textPrimary)
                        .lineLimit(1)
                        .minimumScaleFactor(0.85)
                }

                Image(systemName: "calendar.badge.plus")
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundStyle(.white)
                    .frame(width: 40, height: 40)
                    .background(AppColors.primary, in: RoundedRectangle(cornerRadius: 14, style: .continuous))
            }
            .padding(.leading, 14)
            .padding(.trailing, 10)
            .padding(.vertical, 10)
            .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 22, style: .continuous))
            .overlay(
                RoundedRectangle(cornerRadius: 22, style: .continuous)
                    .strokeBorder(AppColors.separator.opacity(0.45), lineWidth: 1)
            )
            .shadow(color: Color.black.opacity(0.12), radius: 18, x: 0, y: 10)
        }
        .buttonStyle(.plain)
        .accessibilityLabel("Make an appointment")
        .accessibilityHint("Opens the appointment booking flow")
    }
}

#Preview {
    FloatingAppointmentBanner(action: {})
        .padding()
        .background(AppColors.groupedBackground)
}

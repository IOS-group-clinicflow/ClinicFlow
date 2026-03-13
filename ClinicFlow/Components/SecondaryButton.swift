//
//  SecondaryButton.swift
//  ClinicFlow
//
//  Created by COBSCCOMP242P-070 on 2026-03-12.
//

import SwiftUI

struct SecondaryButton: View {
    
    let title: String
    var icon: String? = nil
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: AppSpacing.sm) {
                Text(title)
                    .font(AppTypography.button)
                
                if let icon = icon {
                    Image(systemName: icon)
                }
            }
        }
        .buttonStyle(SecondaryButtonStyle())
    }
}

#Preview {
    VStack(spacing: 20) {
        SecondaryButton(title: "Reschedule", icon: "calendar") {}
        SecondaryButton(title: "Cancel") {}
    }
}

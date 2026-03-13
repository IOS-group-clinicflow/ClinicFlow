//
//  PrimaryButton.swift
//  ClinicFlow
//
//  Created by COBSCCOMP242P-070 on 2026-03-12.
//

import SwiftUI

struct PrimaryButton: View {
    
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
        .buttonStyle(PrimaryButtonStyle())
    }
}

#Preview {
    VStack(spacing: 20) {
        PrimaryButton(title: "Get Started", icon: "arrow.right") {}
        PrimaryButton(title: "Log In") {}
    }
}

//
//  TagView.swift
//  ClinicFlow
//
//  Created by Kawish Jayawardena on 2026-03-12.
//

import SwiftUI

struct TagView: View {
    
    let text: String
    var color: Color = AppColors.primary
    
    var body: some View {
        Text(text)
            .font(AppTypography.caption)
            .fontWeight(.medium)
            .foregroundColor(color)
            .padding(.horizontal, AppSpacing.sm + 2)
            .padding(.vertical, AppSpacing.xs)
            .background(color.opacity(0.12))
            .cornerRadius(AppSpacing.sm)
    }
}

#Preview {
    HStack(spacing: 8) {
        TagView(text: "Self")
        TagView(text: "Mother", color: .purple)
        TagView(text: "Penicillin", color: .red)
        TagView(text: "Hypertension", color: .orange)
    }
}

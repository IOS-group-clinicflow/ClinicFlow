//
//  ProfileRow.swift
//  ClinicFlow
//
//  Created by Kawish Jayawardena on 2026-03-12.
//

import SwiftUI

struct ProfileRow: View {
    
    let label: String
    let value: String
    var icon: String? = nil
    
    var body: some View {
        HStack(spacing: AppSpacing.sm + 4) {
            
            if let icon = icon {
                Image(systemName: icon)
                    .font(.system(size: 16))
                    .foregroundColor(AppColors.primary)
                    .frame(width: 24)
            }
            
            Text(label)
                .font(AppTypography.subheadline)
                .foregroundColor(AppColors.textSecondary)
            
            Spacer()
            
            Text(value)
                .font(AppTypography.body)
                .foregroundColor(AppColors.textPrimary)
                .multilineTextAlignment(.trailing)
        }
        .padding(.vertical, AppSpacing.sm)
        .padding(.horizontal, AppSpacing.screenHorizontal)
    }
}

#Preview {
    VStack(spacing: 0) {
        ProfileRow(label: "Name", value: "Kawish Jayawardena", icon: "person")
        Divider().padding(.horizontal, 24)
        ProfileRow(label: "Age", value: "28", icon: "calendar")
        Divider().padding(.horizontal, 24)
        ProfileRow(label: "Emergency Contact", value: "+94 77 123 4567", icon: "phone")
    }
}

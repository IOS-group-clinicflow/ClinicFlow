//
//  PatientProfileCard.swift
//  ClinicFlow
//
//  Created by COBSCCOMP242P-070 on 2026-03-12.
//

import SwiftUI

struct PatientProfileCard: View {
    
    let patient: Patient
    var onTap: (() -> Void)? = nil
    
    var body: some View {
        Button(action: { onTap?() }) {
            HStack(spacing: AppSpacing.md) {
                
                // Avatar
                ZStack {
                    Circle()
                        .fill(AppColors.primaryLight)
                        .frame(width: 52, height: 52)
                    
                    Text(initials)
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(AppColors.primary)
                }
                
                // Info
                VStack(alignment: .leading, spacing: AppSpacing.xs) {
                    Text(patient.name)
                        .font(AppTypography.headline)
                        .foregroundColor(AppColors.textPrimary)
                    
                    HStack(spacing: AppSpacing.sm) {
                        TagView(text: patient.relationship)
                        
                        Text("Age \(patient.age)")
                            .font(AppTypography.caption)
                            .foregroundColor(AppColors.textTertiary)
                    }
                    
                    if !patient.chronicConditions.isEmpty {
                        Text(patient.chronicConditions.joined(separator: ", "))
                            .font(AppTypography.caption)
                            .foregroundColor(AppColors.warning)
                            .lineLimit(1)
                    }
                }
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(AppColors.textTertiary)
            }
            .padding(AppSpacing.cardPadding)
            .background(AppColors.cardBackground)
            .cornerRadius(AppSpacing.cornerRadiusMedium)
            .padding(.horizontal, AppSpacing.screenHorizontal)
        }
        .buttonStyle(.plain)
        .accessibilityElement(children: .ignore)
        .accessibilityLabel("\(patient.name), \(patient.relationship), age \(patient.age)")
        .accessibilityHint("Loads this patient profile")
    }
    
    private var initials: String {
        let parts = patient.name.split(separator: " ")
        let first = parts.first?.prefix(1) ?? ""
        let last = parts.count > 1 ? parts.last!.prefix(1) : ""
        return "\(first)\(last)".uppercased()
    }
}

#Preview {
    VStack(spacing: 12) {
        PatientProfileCard(patient: MockData.currentUser)
        PatientProfileCard(patient: MockData.linkedPatients[0])
    }
}

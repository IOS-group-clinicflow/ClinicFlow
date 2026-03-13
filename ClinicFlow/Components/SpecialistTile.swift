//
//  SpecialistTile.swift
//  ClinicFlow
//
//  Created by COBSCCOMP242P-070 on 2026-03-12.
//

import SwiftUI

struct SpecialistTile: View {
    
    let specialty: String
    let icon: String
    var onTap: (() -> Void)? = nil
    
    var body: some View {
        Button(action: { onTap?() }) {
            VStack(spacing: AppSpacing.sm + 4) {
                
                ZStack {
                    RoundedRectangle(cornerRadius: AppSpacing.cornerRadiusSmall)
                        .fill(AppColors.primaryLight)
                        .frame(width: AppSpacing.iconContainerSize + 10, height: AppSpacing.iconContainerSize + 10)
                    
                    Image(systemName: icon)
                        .font(.system(size: 24))
                        .foregroundColor(AppColors.primary)
                }
                
                Text(specialty)
                    .font(AppTypography.caption)
                    .foregroundColor(AppColors.textPrimary)
                    .multilineTextAlignment(.center)
                    .lineLimit(2)
                    .frame(width: 80)
            }
            .padding(AppSpacing.sm + 4)
            .background(AppColors.cardBackground)
            .cornerRadius(AppSpacing.cornerRadiusMedium)
        }
        .buttonStyle(.plain)
    }
    
    // Helper to map specialty names to SF Symbols
    static func iconFor(_ specialty: String) -> String {
        switch specialty.lowercased() {
        case let s where s.contains("general"): return "stethoscope"
        case let s where s.contains("cardio"): return "heart.fill"
        case let s where s.contains("derma"): return "hand.raised.fill"
        case let s where s.contains("obg"): return "figure.2.and.child.holdinghands"
        case let s where s.contains("pediatri"): return "figure.and.child.holdinghands"
        case let s where s.contains("orthop"): return "figure.walk"
        case let s where s.contains("ent"): return "ear.fill"
        case let s where s.contains("neuro"): return "brain.head.profile"
        case let s where s.contains("ophthal"): return "eye.fill"
        case let s where s.contains("psychi"): return "brain"
        default: return "cross.case.fill"
        }
    }
}

#Preview {
    HStack(spacing: 12) {
        SpecialistTile(specialty: "General Practitioner", icon: "stethoscope")
        SpecialistTile(specialty: "Cardiologist", icon: "heart.fill")
        SpecialistTile(specialty: "Dermatologist", icon: "hand.raised.fill")
    }
}

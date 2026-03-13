//
//  AppointmentCard.swift
//  ClinicFlow
//
//  Created by COBSCCOMP242P-070 on 2026-03-12.
//

import SwiftUI

struct AppointmentCard: View {
    
    let appointment: Appointment
    var onTap: (() -> Void)? = nil
    
    var body: some View {
        Button(action: { onTap?() }) {
            VStack(alignment: .leading, spacing: AppSpacing.md) {
                
                // Status badge and date
                HStack {
                    StatusBadge(text: appointment.status, style: statusStyle)
                    Spacer()
                    Text(appointment.date)
                        .font(AppTypography.caption)
                        .foregroundColor(AppColors.textSecondary)
                }
                
                // Doctor and specialty
                HStack(spacing: AppSpacing.sm + 4) {
                    
                    ZStack {
                        Circle()
                            .fill(AppColors.primaryLight)
                            .frame(width: 48, height: 48)
                        
                        Image(systemName: "stethoscope")
                            .font(.system(size: 20))
                            .foregroundColor(AppColors.primary)
                    }
                    
                    VStack(alignment: .leading, spacing: AppSpacing.xs) {
                        Text(appointment.doctorName)
                            .font(AppTypography.headline)
                            .foregroundColor(AppColors.textPrimary)
                        
                        Text(appointment.specialty)
                            .font(AppTypography.subheadline)
                            .foregroundColor(AppColors.textSecondary)
                    }
                }
                
                // Time and location
                HStack(spacing: AppSpacing.md) {
                    Label(appointment.time, systemImage: "clock")
                        .font(AppTypography.subheadline)
                        .foregroundColor(AppColors.textSecondary)
                    
                    Spacer()
                }
                
                HStack(spacing: AppSpacing.xs) {
                    Image(systemName: "mappin.and.ellipse")
                        .font(.system(size: 12))
                        .foregroundColor(AppColors.textTertiary)
                    
                    Text(appointment.location)
                        .font(AppTypography.caption)
                        .foregroundColor(AppColors.textTertiary)
                        .lineLimit(1)
                }
                
                // Patient name
                if !appointment.patientName.isEmpty {
                    HStack(spacing: AppSpacing.xs) {
                        Image(systemName: "person")
                            .font(.system(size: 12))
                            .foregroundColor(AppColors.textTertiary)
                        
                        Text("Patient: \(appointment.patientName)")
                            .font(AppTypography.caption)
                            .foregroundColor(AppColors.textTertiary)
                    }
                }
            }
            .padding(AppSpacing.cardPadding)
            .background(AppColors.cardBackground)
            .cornerRadius(AppSpacing.cornerRadiusLarge)
            .padding(.horizontal, AppSpacing.screenHorizontal)
        }
        .buttonStyle(.plain)
    }
    
    private var statusStyle: StatusBadge.Style {
        switch appointment.status.lowercased() {
        case "confirmed": return .info
        case "completed": return .success
        case "cancelled": return .error
        case "pending": return .warning
        default: return .info
        }
    }
}

#Preview {
    AppointmentCard(appointment: MockData.upcomingAppointment)
}

//
//  SectionHeader.swift
//  ClinicFlow
//
//  Created by Kawish Jayawardena on 2026-03-12.
//

import SwiftUI

struct SectionHeader: View {
    
    let title: String
    var actionTitle: String? = nil
    var action: (() -> Void)? = nil
    
    var body: some View {
        HStack {
            Text(title)
                .font(AppTypography.title)
                .foregroundColor(AppColors.textPrimary)
                .accessibilityAddTraits(.isHeader)
            
            Spacer()
            
            if let actionTitle = actionTitle {
                TextActionButton(title: actionTitle, icon: "chevron.right") {
                    action?()
                }
            }
        }
        .padding(.horizontal, AppSpacing.screenHorizontal)
    }
}

#Preview {
    VStack(spacing: 20) {
        SectionHeader(title: "Upcoming Appointment")
        SectionHeader(title: "Specialists", actionTitle: "View All") {}
    }
}

//
//  TextActionButton.swift
//  ClinicFlow
//
//  Created by COBSCCOMP242P-070 on 2026-03-12.
//

import SwiftUI

struct TextActionButton: View {
    
    let title: String
    var icon: String? = nil
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: AppSpacing.xs) {
                Text(title)
                    .font(AppTypography.subheadline)
                
                if let icon = icon {
                    Image(systemName: icon)
                        .font(.system(size: 12))
                }
            }
            .foregroundColor(AppColors.primary)
        }
    }
}

#Preview {
    TextActionButton(title: "View All", icon: "chevron.right") {}
}

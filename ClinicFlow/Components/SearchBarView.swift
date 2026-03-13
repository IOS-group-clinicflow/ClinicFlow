//
//  SearchBarView.swift
//  ClinicFlow
//
//  Created by Kawish Jayawardena on 2026-03-12.
//

import SwiftUI

struct SearchBarView: View {
    
    @Binding var text: String
    var placeholder: String = "Search"
    
    var body: some View {
        HStack(spacing: AppSpacing.sm + 4) {
            
            Image(systemName: "magnifyingglass")
                .foregroundColor(AppColors.textTertiary)
            
            TextField(placeholder, text: $text)
                .font(AppTypography.body)
                .textInputAutocapitalization(.never)
                .autocorrectionDisabled()
            
            if !text.isEmpty {
                Button {
                    text = ""
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(AppColors.textTertiary)
                }
            }
        }
        .padding(AppSpacing.sm + 4)
        .background(AppColors.cardBackground)
        .cornerRadius(AppSpacing.cornerRadiusSmall)
        .padding(.horizontal, AppSpacing.screenHorizontal)
    }
}

#Preview {
    SearchBarView(text: .constant(""), placeholder: "Search specialists")
}

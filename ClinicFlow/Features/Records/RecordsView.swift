//
//  RecordsView.swift
//  ClinicFlow
//
//  Created by Kawish Jayawardena on 2026-03-12.
//

import SwiftUI

struct RecordsView: View {
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: AppSpacing.sectionSpacing) {
                    Text("Medical records and test results will be built in Phase 4.")
                        .font(AppTypography.body)
                        .foregroundColor(AppColors.textSecondary)
                        .padding(.horizontal, AppSpacing.screenHorizontal)
                        .padding(.top)
                }
            }
            .background(AppColors.background)
            .navigationTitle("Records")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    RecordsView()
}

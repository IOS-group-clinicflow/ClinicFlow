//
//  PaymentsView.swift
//  ClinicFlow
//
//  Created by Kawish Jayawardena on 2026-03-13.
//

import SwiftUI

struct PaymentsView: View {
    private var paymentItems: [(service: String, amount: String, status: String, date: String)] {
        [
            ("OBG Ultrasound", "LKR 5,500", "Paid", "10 Feb 2026"),
            ("General Consultation", "LKR 3,000", "Pending", "15 Mar 2026"),
            ("Thyroid Function Test", "LKR 2,200", "Required", "18 Mar 2026")
        ]
    }

    var body: some View {
        ScrollView {
            VStack(spacing: AppSpacing.sectionSpacing) {
                ForEach(Array(paymentItems.enumerated()), id: \.offset) { _, item in
                    PaymentSummaryCard(
                        serviceName: item.service,
                        amount: item.amount,
                        status: item.status,
                        date: item.date
                    )
                }

                HStack(alignment: .top, spacing: AppSpacing.sm) {
                    Image(systemName: "creditcard")
                        .foregroundColor(AppColors.info)
                    Text("Only selected services require payment before the appointment.")
                        .font(AppTypography.subheadline)
                        .foregroundColor(AppColors.textSecondary)
                    Spacer()
                }
                .padding(AppSpacing.cardPadding)
                .background(AppColors.cardBackground)
                .cornerRadius(AppSpacing.cornerRadiusMedium)
                .padding(.horizontal, AppSpacing.screenHorizontal)
            }
            .padding(.top)
            .padding(.bottom, AppSpacing.lg)
        }
        .background(AppColors.background)
        .navigationTitle("Payments")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        PaymentsView()
    }
}

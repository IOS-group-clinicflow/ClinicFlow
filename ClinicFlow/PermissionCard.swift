//
//  PermissionCard.swift
//  ClinicFlow
//
//  Created by Kawish Jayawardena on 2026-03-11.
//
import SwiftUI

struct PermissionCard: View {
    
    var icon: String
    var title: String
    var description: String
    
    @Binding var isOn: Bool
    
    var body: some View {
        
        HStack(spacing: 16) {
            
            ZStack {
                
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.blue.opacity(0.15))
                    .frame(width: 45, height: 45)
                
                Image(systemName: icon)
                    .foregroundColor(.blue)
            }
            
            
            VStack(alignment: .leading, spacing: 4) {
                
                Text(title)
                    .font(.system(size: 16, weight: .semibold))
                
                Text(description)
                    .font(.system(size: 14))
                    .foregroundColor(.gray)
            }
            
            
            Spacer()
            
            
            Toggle("", isOn: $isOn)
                .labelsHidden()
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(16)
        .padding(.horizontal)
    }
}

//
//  EmptyStateView.swift
//  Hello World, Maha
//
//  Created by Maha Alhamdan on 02/06/1448 AH.
//

import SwiftUI

struct EmptyStateView: View {
    var body: some View {
        VStack(spacing: 16) {
            Image("EmptyStateIcon")
                .resizable()
                .scaledToFit()
                .frame(width: 150)
            
            Text("Begin Your Journal")
                .font(.headingM)
                .foregroundStyle(Color.textAccent)
            
            Text("Craft your personal diary, tap the plus icon to begin")
                .font(.bodySupporting)
                .foregroundStyle(Color.textPrimary)
                .multilineTextAlignment(.center)
        }
        .padding(.horizontal, 32)
    }
}

#Preview {
    EmptyStateView()
}

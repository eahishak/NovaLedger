//
//  LaunchScreen.swift
//  NovaLedger
//
//  Created by Ahishakiye, Emmanuel on 11/29/25.
//

import SwiftUI

struct LaunchScreen: View {
    
    @State private var isAnimating = false
    
    var body: some View {
        ZStack {
            // Background color
            Color("PrimaryNavy")
                .ignoresSafeArea()
            
            VStack(spacing: 30) {
                // App logo with animation
                Image("NovaLedgerImage")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                    .clipShape(RoundedRectangle(cornerRadius: 40))
                    .shadow(color: .white.opacity(0.3), radius: 20, x: 0, y: 10)
                    .scaleEffect(isAnimating ? 1.0 : 0.6)
                    .opacity(isAnimating ? 1.0 : 0.3)
                
                // App name
                Text("NovaLedger")
                    .font(.system(size: 42, weight: .bold))
                    .foregroundColor(.white)
                    .opacity(isAnimating ? 1.0 : 0.0)
                
                // Tagline
                Text("Track Your Crypto")
                    .font(.title3)
                    .foregroundColor(.white.opacity(0.8))
                    .opacity(isAnimating ? 1.0 : 0.0)
            }
            .onAppear {
                withAnimation(.easeOut(duration: 1.5)) {
                    isAnimating = true
                }
            }
        }
    }
}

#Preview {
    LaunchScreen()
}

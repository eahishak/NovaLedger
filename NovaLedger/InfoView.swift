//
//  InfoView.swift
//  NovaLedger
//
//  Created by Ahishakiye, Emmanuel on 11/29/25.
//

import SwiftUI

struct InfoView: View {
    
    // Bundle information retrieval
    private var appName: String {
        Bundle.main.object(forInfoDictionaryKey: "CFBundleName") as? String ?? "NovaLedger"
    }
    
    private var version: String {
        Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String ?? "1.0"
    }
    
    private var buildNumber: String {
        Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as? String ?? "1"
    }
    
    private var copyright: String {
        Bundle.main.object(forInfoDictionaryKey: "NSHumanReadableCopyright") as? String ?? "© 2025 NovaLedger"
    }
    
    var body: some View {
        ZStack {
            Color(.systemGroupedBackground)
                .ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 30) {
                    
                    Spacer()
                        .frame(height: 40)
                    
                    // App icon with shadow
                    Image("NovaLedgerImage")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 120, height: 120)
                        .clipShape(RoundedRectangle(cornerRadius: 28))
                        .shadow(color: .black.opacity(0.2), radius: 10, x: 0, y: 5)
                    
                    // App name
                    Text(appName)
                        .font(.system(size: 36, weight: .bold))
                        .foregroundColor(Color("PrimaryNavy"))
                    
                    // App description
                    Text("Your Personal Crypto Tracker")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .padding(.bottom, 20)
                    
                    // Information cards
                    VStack(spacing: 15) {
                        infoCard(title: "Version", value: version, icon: "tag.fill")
                        infoCard(title: "Build", value: buildNumber, icon: "hammer.fill")
                        infoCard(title: "Copyright", value: copyright, icon: "c.circle.fill")
                    }
                    .padding(.horizontal)
                    
                    // Additional info section
                    VStack(spacing: 12) {
                        Text("About NovaLedger")
                            .font(.headline)
                            .foregroundColor(Color("PrimaryNavy"))
                        
                        Text("NovaLedger helps you track cryptocurrency prices and market trends in real-time. Stay informed about your favorite digital assets.")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal)
                    }
                    .padding(.vertical, 20)
                    
                    Spacer()
                }
                .padding(.horizontal, 20)
            }
        }
        .navigationTitle("App Info")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    // Reusable info card component
    private func infoCard(title: String, value: String, icon: String) -> some View {
        HStack(spacing: 15) {
            Image(systemName: icon)
                .font(.title2)
                .foregroundColor(.accentColor)
                .frame(width: 40, height: 40)
                .background(Color.accentColor.opacity(0.15))
                .cornerRadius(10)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.caption)
                    .foregroundColor(.secondary)
                
                Text(value)
                    .font(.body.bold())
                    .foregroundColor(Color("PrimaryNavy"))
            }
            
            Spacer()
        }
        .padding()
        .background(Color.white)
        .cornerRadius(12)
        .shadow(color: .black.opacity(0.05), radius: 5, x: 0, y: 2)
    }
}

#Preview {
    NavigationStack {
        InfoView()
    }
}

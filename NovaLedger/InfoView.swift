//
//  InfoView.swift
//  NovaLedger
//
//  Created by Ahishakiye, Emmanuel on 11/29/25.
//
import SwiftUI

struct InfoView: View {

    // Fetching Bundle data
    private var appName: String {
        Bundle.main.object(forInfoDictionaryKey: "CFBundleName") as? String ?? "Unknown"
    }

    private var version: String {
        Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String ?? "Unknown"
    }

    private var build: String {
        Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as? String ?? "Unknown"
    }

    private var copyright: String {
        Bundle.main.object(forInfoDictionaryKey: "NSHumanReadableCopyright") as? String ?? "© 2025 NovaLedger"
    }

    var body: some View {
        VStack(spacing: 25) {

            // App Icon
            Image("NovaLedgerImage")
                .resizable()
                .scaledToFit()
                .frame(width: 120)
                .clipShape(RoundedRectangle(cornerRadius: 25))

            // App name
            Text(appName)
                .font(.largeTitle.bold())
                .foregroundColor(Color("PrimaryNavy"))

            VStack(spacing: 8) {
                Text("Version: \(version)")
                Text("Build: \(build)")
                Text(copyright)
            }
            .font(.headline)
            .foregroundColor(.gray)

            Spacer()
        }
        .padding()
        .navigationTitle("App Info")
    }
}

#Preview {
    InfoView()
}


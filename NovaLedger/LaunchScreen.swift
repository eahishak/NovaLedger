//
//  LaunchScreen.swift
//  NovaLedger
//
//  Created by Ahishakiye, Emmanuel on 11/29/25.
//

import SwiftUI

struct LaunchScreen: View {
    var body: some View {
        ZStack {
            Color("LaunchBackground")
                .ignoresSafeArea()

            Image("NovaLedgerImage")
                .resizable()
                .scaledToFit()
                .frame(width: 200)
        }
    }
}

#Preview {
    LaunchScreen()
}

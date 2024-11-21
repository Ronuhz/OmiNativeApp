//
//  ContentView.swift
//  OmiNativeApp
//
//  Created by Hunor Zoltáni on 12.11.2024.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        WithTabBar { selection in
            switch selection {
                case .memories:
                    MemoriesView()
                case .chat:
                    ChatView()
                case .apps:
                    AppsView()
                case .settings:
                    SettingsView()
            }
        }
    }
}

#Preview {
    ContentView()
}

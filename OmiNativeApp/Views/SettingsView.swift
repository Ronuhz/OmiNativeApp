//
//  SettingsView.swift
//  OmiNativeApp
//
//  Created by Hunor Zoltáni on 12.11.2024.
//

import SwiftUI

struct SettingsView: View {
    var body: some View {
        NavigationStack {
            List {
                Section {
                    SettingsButton("Profile", systemImage: "person.fill", backgroundColor: .blue) { }
                    SettingsButton("Device Settings", systemImage: "gearshape.fill", backgroundColor: .purple) { }
                }
                
                Section {
                    SettingsButton("About Omi", systemImage: "info.circle.fill", backgroundColor: .green) { }
                    SettingsButton("Guides & Tutorials", systemImage: "book.fill", backgroundColor: .orange) { }
                    SettingsButton("Help & Support", systemImage: "questionmark.circle.fill", backgroundColor: .teal) { }
                }
                
                Section {
                    SettingsButton("Developer Mode", systemImage: "hammer.fill", backgroundColor: .gray) { }
                }
                
                Section {
                    SettingsButton("Sign Out", systemImage: "rectangle.portrait.and.arrow.right.fill", backgroundColor: .red) { }
                }
            }
            .navigationTitle("Settings")
            .transition(.blurReplace())
        }
    }
}

struct SettingsButton: View {
    let title: LocalizedStringResource
    let systemImage: String
    let backgroundColor: Color
    let action: () -> Void
    
    init(_ title: LocalizedStringResource, systemImage: String, backgroundColor: Color, action: @escaping () -> Void) {
        self.title = title
        self.systemImage = systemImage
        self.backgroundColor = backgroundColor
        self.action = action
    }
    
    var body: some View {
        Button {
            action()
        } label: {
            HStack(spacing: 15) {
                RoundedRectangle(cornerRadius: 8) // 11
                    .fill(backgroundColor)
                    .frame(width: 30, height: 30)
                    .overlay {
                        Image(systemName: systemImage)
                            .foregroundStyle(.white)
                            .font(.subheadline)
                            .fontWeight(.black)
                            .fontDesign(.rounded)

                    }

                
                Text(title)
                    .fontDesign(.rounded)
                    .fontWeight(.medium)
            }
        }
        .modifier(SettingsButtonStyle())
        .listRowInsets(.init(top: 0, leading: 8, bottom: 0, trailing: 20))
    }
}

struct SettingsButtonStyle: ViewModifier {
    var languageDirection: Locale.LanguageDirection {
        guard let languageIdentifier = Locale.current.language.languageCode?.identifier else { return .leftToRight }
        let language = Locale.Language(identifier: languageIdentifier)
        
        return language.characterDirection
    }
    
    func body(content: Content) -> some View {
        content
            .tint(.primary)
            .frame(maxWidth: /*@START_MENU_TOKEN@*/ .infinity /*@END_MENU_TOKEN@*/, alignment: .leading)
            .overlay {
                HStack {
                    Spacer()
                    Image(systemName: languageDirection == .leftToRight ? "chevron.right" : "chevron.left")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundStyle(.secondary)
                        .opacity(0.5)
                        .accessibilityHidden(true)
                }
            }
    }
}

#Preview {
    SettingsView()
}

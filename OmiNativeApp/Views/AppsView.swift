//
//  AppsView.swift
//  OmiNativeApp
//
//  Created by Hunor Zoltáni on 12.11.2024.
//

import SwiftUI

struct App: Identifiable {
    let id = UUID()
    let name: String
    let description: String
    let icon: String
    let category: String
    let isInstalled: Bool
}

struct AppsView: View {
    let featuredApps: [App] = [
        .init(name: "Voice Notes Pro", description: "Enhanced voice recording with real-time transcription and AI-powered summaries.", icon: "🎙️", category: "Productivity", isInstalled: true),
        .init(name: "Memory Journal", description: "Document your daily memories with voice, photos, and AI organization.", icon: "📔", category: "Lifestyle", isInstalled: false),
        .init(name: "Meeting Assistant", description: "Your AI meeting companion for perfect meeting notes and action items.", icon: "👥", category: "Business", isInstalled: false)
    ]
    
    let categories = ["All", "Productivity", "Business", "Lifestyle", "Education"]
    @State private var selectedCategory = "All"
    @State private var searchText = ""
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack(spacing: 20, pinnedViews: .sectionHeaders) {
                    // Categories picker
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 8) {
                            ForEach(categories, id: \.self) { category in
                                Button(category) {
                                    selectedCategory = category
                                }
                                .buttonStyle(.bordered)
                                .tint(selectedCategory == category ? .blue : .secondary)
                            }
                        }
                        .padding(.horizontal)
                    }
                    .padding(.vertical, 8)
                    
                    // Featured section
                    Section {
                        VStack(alignment: .leading, spacing: 16) {
                            Text("Featured")
                                .font(.title2.bold())
                                .padding(.horizontal)
                            
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 16) {
                                    ForEach(featuredApps) { app in
                                        FeaturedAppCard(app: app)
                                    }
                                }
                                .padding(.horizontal)
                            }
                        }
                    }
                    
                    // All Apps section
                    Section {
                        VStack(alignment: .leading, spacing: 16) {
                            Text("All Apps")
                                .font(.title2.bold())
                                .padding(.horizontal)
                            
                            ForEach(featuredApps) { app in
                                AppListItem(app: app)
                            }
                        }
                    }
                }
                .padding(.vertical)
                .padding(.bottom, 80)

            }
            .navigationTitle("Apps")
            .searchable(text: $searchText, prompt: "Search apps")
        }
    }
}

struct FeaturedAppCard: View {
    let app: App
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text(app.icon)
                    .font(.system(size: 40))
                Spacer()
                InstallButton(isInstalled: app.isInstalled)
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text(app.name)
                    .font(.headline)
                Text(app.category)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            
            Text(app.description)
                .font(.subheadline)
                .foregroundColor(.secondary)
                .lineLimit(2)
        }
        .frame(width: 250)
        .padding()
        .background(Color(.systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: 2)
    }
}

struct AppListItem: View {
    let app: App
    
    var body: some View {
        HStack(spacing: 16) {
            Text(app.icon)
                .font(.system(size: 40))
            
            VStack(alignment: .leading, spacing: 4) {
                HStack {
                    Text(app.name)
                        .font(.headline)
                    Spacer()
                    InstallButton(isInstalled: app.isInstalled)
                }
                Text(app.description)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .lineLimit(2)
            }
        }
        .padding()
        .background(Color(.systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: 2)
        .padding(.horizontal)
    }
}

struct InstallButton: View {
    let isInstalled: Bool
    
    var body: some View {
        Button(action: {}) {
            Text(isInstalled ? "INSTALLED" : "GET")
                .font(.subheadline.bold())
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .background(isInstalled ? Color(.systemGray5) : Color(.systemBlue))
                .foregroundColor(isInstalled ? .secondary : .white)
                .clipShape(RoundedRectangle(cornerRadius: 16))
        }
        .disabled(isInstalled)
    }
}

#Preview {
    AppsView()
}

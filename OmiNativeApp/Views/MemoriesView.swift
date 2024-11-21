//
//  MemoriesView.swift
//  OmiNativeApp
//
//  Created by Hunor Zoltáni on 12.11.2024.
//

import SwiftUI

struct Memory: Identifiable {
    let id = UUID()
    let title: String
    let description: String
    let category: String
    let icon: String
    let createdAt: Date
}

struct MemoriesView: View {
    let memories: [Memory] = [
        .init(title:"Overview of Apple Inc.", description: "Apple Inc. is an American multinational technology company that specializes in consumer electronics, computer software, and online services. Apple is the world's largest technology company by revenue and, since January 2022, the world's most valuable company.", category: "Business", icon: "💼", createdAt: Date().addingTimeInterval(-86400)),
        .init(title: "The History of the iPhone", description: "The iPhone is a line of smartphones designed and marketed by Apple Inc. that use Apple's iOS mobile operating system. The first-generation iPhone was announced by then-CEO Steve Jobs on January 9, 2007.", category: "Technology", icon: "📱", createdAt: Date().addingTimeInterval(-172800)),
    ]
    
    @Namespace private var namespace
    @State private var searchText = ""
    @State private var isLoaded = false
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack(spacing: 0) {
                    // Recording status section
                    recordingStatusSection
                    
                    // Memories list
                    ForEach(memories) { memory in
                        NavigationLink(destination: MemoryDetailView(memory: memory)
                            .navigationTransition(.zoom(sourceID: memory.id, in: namespace))) {
                                MemoryCard(memory: memory)
                                    .matchedTransitionSource(id: memory.id, in: namespace)
                        }
                    }
                }
                .padding(.vertical)
            }
            .navigationTitle("Memories")
            .searchable(text: $searchText, prompt: "Search memories")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                    }) {
                        Image(systemName: "plus.circle.fill")
                            .foregroundColor(.blue)
                    }
                }
            }
        }
        .transition(.opacity)
        .animation(.easeInOut, value: isLoaded)
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                isLoaded = true
            }
        }
    }
    
    private var recordingStatusSection: some View {
        HStack {
            Text("🎙️")
                .font(.system(size: 40))
            VStack(alignment: .leading) {
                Text("Waiting for device...")
                    .font(.headline)
                Text("Tap to start recording")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            Spacer()
            ProgressView()
        }
        .padding()
        .background(Color(.systemGray6))
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .padding(.horizontal, 20)
        .padding(.bottom, 8)
    }
}

struct MemoryCard: View {
    let memory: Memory
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(alignment: .center) {
                Text(memory.icon)
                    .font(.system(size: 40))
                VStack(alignment: .leading) {
                    Text(memory.title)
                        .font(.headline)
                        .lineLimit(1)
                    Text(memory.category)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
            }
            
            Text(memory.description)
                .font(.body)
                .lineLimit(2)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.leading)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(Color(.systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
        .padding(.horizontal, 20)
        .padding(.vertical, 8)
    }
}

#Preview {
    MemoriesView()
}

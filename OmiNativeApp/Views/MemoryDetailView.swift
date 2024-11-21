//
//  MemoryDetailView.swift
//  OmiNativeApp
//
//  Created by Hunor Zoltáni on 12.11.2024.
//

import SwiftUI

struct MemoryDetailView: View {
    let memory: Memory
    @State private var showingDeleteAlert = false
    @State private var selectedTab = 0
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 0) {
                // Header section with icon and metadata
                HStack(alignment: .center) {
                    Text(memory.icon)
                        .font(.system(size: 64))
                    
                    VStack(alignment: .leading) {
                        Chip(memory.category)
                        Text(memory.createdAt.formatted(date: .long, time: .shortened))
                            .foregroundColor(.secondary)
                            .font(.subheadline)
                    }
                }
                .padding()
                
                Picker("View", selection: $selectedTab) {
                    Text("Summary").tag(0)
                    Text("Transcript").tag(1)
                }
                .pickerStyle(.segmented)
                .padding(.horizontal)
                
                TabView(selection: $selectedTab) {
                    // Summary Tab
                    ScrollView {
                        VStack(alignment: .leading, spacing: 16) {
                            Text(memory.title)
                                .font(.title.bold())
                                .padding(.bottom, 4)
                            
                            Text(memory.description)
                                .font(.body)
                                .lineSpacing(4)
                        }
                        .padding()
                    }
                    .tag(0)
                    
                    // Transcript Tab
                    ScrollView {
                        VStack(alignment: .leading, spacing: 16) {
                            ForEach(1...5, id: \.self) { index in
                                VStack(alignment: .leading, spacing: 8) {
                                    Text("Speaker \(index)")
                                        .font(.headline)
                                    Text("This is where the transcript text would go. It would show the full conversation or speech that was recorded.")
                                        .font(.body)
                                }
                            }
                        }
                        .padding()
                    }
                    .tag(1)
                }
                .tabViewStyle(.page(indexDisplayMode: .never))
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Menu {
                        Button {
                        } label: {
                            Label("Share", systemImage: "square.and.arrow.up")
                        }
                        
                        Button {
                        } label: {
                            Label("Edit", systemImage: "pencil")
                        }
                        
                        Button(role: .destructive) {
                            showingDeleteAlert = true
                        } label: {
                            Label("Delete", systemImage: "trash")
                        }
                    } label: {
                        Image(systemName: "ellipsis.circle")
                    }
                }
            }
            .alert("Delete Memory?", isPresented: $showingDeleteAlert) {
                Button("Cancel", role: .cancel) { }
                Button("Delete", role: .destructive) {
                }
            } message: {
                Text("Are you sure you want to delete this memory? This action cannot be undone.")
            }
        }
    }
}


#Preview {
    MemoryDetailView(memory: .init(title:"Overview of Apple Inc.", description: "Apple Inc. is an American multinational technology company that specializes in consumer electronics, computer software, and online services. Apple is the world's largest technology company by revenue and, since January 2022, the world's most valuable company.", category: "Business", icon: "💼", createdAt: Date().addingTimeInterval(-86400)))
}

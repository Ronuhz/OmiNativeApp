//
//  Tabs.swift
//  swiftystuff
//
//  Created by Abdulrahim Illo on 04/05/2024.
//

import Foundation

enum Tabs: CaseIterable {
    case memories, chat, apps, settings
    var item: TabItem {
        switch self {
            case .memories:
                .init(title: "Memories", systemImage: "photo.on.rectangle", color: .purple)
            case .chat:
                .init(title: "Chat", systemImage: "bubble.left.and.bubble.right.fill", color: .blue)
            case .apps:
                .init(title: "Apps", systemImage: "square.grid.2x2", color: .green)
            case .settings:
                .init(title: "Settings", systemImage: "gearshape.fill", color: .orange)
        }
    }
}

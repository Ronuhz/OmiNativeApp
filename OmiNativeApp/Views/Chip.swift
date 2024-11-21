//
//  Chip.swift
//  OmiNativeApp
//
//  Created by Hunor Zoltáni on 12.11.2024.
//

import SwiftUI

struct Chip: View {
    let text: String
    
    init(_ text: String) {
        self.text = text
    }
    var body: some View {
        Text(text)
            .padding(.horizontal, 10)
            .padding(.vertical, 5)
            .background(.regularMaterial)
            .foregroundColor(.primary)
            .clipShape(RoundedRectangle(cornerRadius: 16))
    }
}

#Preview {
    Chip("Test")
}

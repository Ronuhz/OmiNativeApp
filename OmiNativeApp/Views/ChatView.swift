import SwiftUI

struct ChatView: View {
    @State private var messageText = ""
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                ScrollView {
                    LazyVStack(spacing: 24) {
                        VStack(spacing: 16) {
                            Image(systemName: "bubble.left.and.bubble.right.fill")
                                .font(.system(size: 64))
                                .foregroundStyle(.blue)
                                .padding(.top, 32)
                            
                            Text("Chat with Omi")
                                .font(.title2.bold())
                            
                            Text("Ask me anything or tap a suggestion below")
                                .foregroundStyle(.secondary)
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 16)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 8) {
                                ForEach([
                                    "What can you do?",
                                    "Summarize my last memory",
                                    "Create a new memory",
                                    "Help me find something"
                                ], id: \.self) { suggestion in
                                    Button(suggestion) { }
                                        .buttonStyle(.bordered)
                                        .tint(.blue)
                                }
                            }
                            .padding(.horizontal)
                        }
                        
                        // Example messages
                        MessageBubble(
                            text: "Hi! How can I help you today?",
                            isUser: false
                        )
                        
                        MessageBubble(
                            text: "Can you help me find my memories about work?",
                            isUser: true
                        )
                        
                        MessageBubble(
                            text: "I found 3 memories related to work. Here they are...",
                            isUser: false
                        )
                    }
                    .padding(.bottom, 16)
                }
                
                // Message input bar
                VStack(spacing: 0) {
                    Divider()
                    HStack(spacing: 12) {
                        Button {
                        } label: {
                            Image(systemName: "mic.circle.fill")
                                .font(.system(size: 32))
                                .foregroundStyle(.blue)
                        }
                        
                        TextField("Message", text: $messageText, axis: .vertical)
                            .padding(10)
                            .background(Color(.systemGray6))
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                            .lineLimit(1...5)
                        
                        Button {
                        } label: {
                            Image(systemName: messageText.isEmpty ? "arrow.up.circle" : "arrow.up.circle.fill")
                                .font(.system(size: 32))
                                .foregroundStyle(.blue)
                        }
                        .disabled(messageText.isEmpty)
                    }
                    .padding(.horizontal)
                    .padding(.vertical, 12)
                }
                .padding(.bottom, BTTN_HEIGHT + 40)
            }
        }
    }
}

struct MessageBubble: View {
    let text: String
    let isUser: Bool
    
    var body: some View {
        HStack {
            if isUser { Spacer(minLength: 60) }
            
            Text(text)
                .padding(.horizontal, 16)
                .padding(.vertical, 12)
                .background(isUser ? Color.blue : Color(.systemGray6))
                .foregroundStyle(isUser ? .white : .primary)
                .clipShape(RoundedRectangle(cornerRadius: 20))
            
            if !isUser { Spacer(minLength: 60) }
        }
        .padding(.horizontal)
    }
}

#Preview {
    ChatView()
}

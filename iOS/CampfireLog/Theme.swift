import SwiftUI

enum Theme {
    static let accent = Color(hex: "#4A3B2A")
    static let accentSecondary = Color(hex: "#D9622B")
    static let background = Color(hex: "#F2EBE0")
    static let cardBackground = Color.white.opacity(0.7)
    static let textPrimary = Color(hex: "#4A3B2A").opacity(0.95)
    static let textSecondary = Color.gray

    static let titleFont: Font = .system(.title2, design: .serif).weight(.bold)
    static let headlineFont: Font = .system(.headline, design: .serif)
    static let bodyFont: Font = .system(.body, design: .rounded)
}

extension Color {
    init(hex: String) {
        let h = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: h).scanHexInt64(&int)
        let r = Double((int >> 16) & 0xFF) / 255.0
        let g = Double((int >> 8) & 0xFF) / 255.0
        let b = Double(int & 0xFF) / 255.0
        self.init(.sRGB, red: r, green: g, blue: b, opacity: 1.0)
    }
}

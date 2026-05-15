import SwiftUI

struct AtelierTheme {
    // MARK: - Colors
    struct Colors {
        static let backgroundPrimary = Color(hex: "#0F0B09")
        static let backgroundDeep = Color(hex: "#1A1412")
        static let accentGold = Color(hex: "#C9A96E")
        static let success = Color(hex: "#4CBF73")
        static let error = Color(hex: "#D94D4D")
        static let textPrimary = Color(hex: "#FFFFFF")
        static let textSecondary = Color(hex: "#BDB0A6")
    }
    
    // MARK: - Layout
    struct Layout {
        static let spacingXS: CGFloat = 4
        static let spacingS: CGFloat = 8
        static let spacingM: CGFloat = 16
        static let spacingL: CGFloat = 24
        static let spacingXL: CGFloat = 32
        
        static let cardRadius: CGFloat = 20
        static let buttonRadius: CGFloat = 12
    }
    
    // MARK: - Gradients
    struct Gradients {
        static let luxuryGold = LinearGradient(
            gradient: Gradient(colors: [Colors.accentGold, Colors.accentGold.opacity(0.6)]),
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
        
        static let glass = LinearGradient(
            gradient: Gradient(colors: [Color.white.opacity(0.1), Color.white.opacity(0.02)]),
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
    }
    
    // MARK: - Animations
    struct Animation {
        static let standardSpring = SwiftUI.Animation.spring(response: 0.6, dampingFraction: 0.8)
        static let quickSpring = SwiftUI.Animation.spring(response: 0.4, dampingFraction: 0.7)
    }
    
    // Static accessors for backward compatibility
    static let backgroundPrimary = Colors.backgroundPrimary
    static let backgroundDeep = Colors.backgroundDeep
    static let accentGold = Colors.accentGold
    static let success = Colors.success
    static let error = Colors.error
    static let textPrimary = Colors.textPrimary
    static let textSecondary = Colors.textSecondary
    
    static let spacingXS = Layout.spacingXS
    static let spacingS = Layout.spacingS
    static let spacingM = Layout.spacingM
    static let spacingL = Layout.spacingL
    static let spacingXL = Layout.spacingXL
}

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }

        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}

struct AtelierTypography {
    static func luxuryHeader(_ size: CGFloat = 34) -> Font {
        .custom("Georgia", size: size).italic()
    }
    
    static func dashboardTitle(_ size: CGFloat = 24) -> Font {
        .system(size: size, weight: .bold, design: .rounded)
    }
    
    static func bodyText(_ size: CGFloat = 16) -> Font {
        .system(size: size, weight: .regular, design: .default)
    }
    
    static func secondaryText(_ size: CGFloat = 14) -> Font {
        .system(size: size, weight: .medium, design: .default)
    }
}

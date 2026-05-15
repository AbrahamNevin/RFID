import SwiftUI
import UIKit

struct GlassCard<Content: View>: View {
    let content: Content
    var glowColor: Color
    
    init(glowColor: Color = AtelierTheme.accentGold.opacity(0.1), @ViewBuilder content: () -> Content) {
        self.glowColor = glowColor
        self.content = content()
    }
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(AtelierTheme.backgroundDeep.opacity(0.6))
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(AtelierTheme.accentGold.opacity(0.2), lineWidth: 1)
                )
                .background(
                    VisualEffectView(effect: UIBlurEffect(style: .dark))
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                )
                .shadow(color: glowColor, radius: 10, x: 0, y: 5)
            
            content
                .padding(AtelierTheme.spacingM)
        }
    }
}

struct VisualEffectView: UIViewRepresentable {
    var effect: UIVisualEffect?
    func makeUIView(context: UIViewRepresentableContext<Self>) -> UIVisualEffectView { UIVisualEffectView() }
    func updateUIView(_ uiView: UIVisualEffectView, context: UIViewRepresentableContext<Self>) { uiView.effect = effect }
}

struct KPIWidget: View {
    let title: String
    let value: String
    let trend: String?
    let icon: String
    
    var body: some View {
        GlassCard {
            VStack(alignment: .leading, spacing: AtelierTheme.spacingS) {
                HStack {
                    Image(systemName: icon)
                        .foregroundColor(AtelierTheme.accentGold)
                        .font(.system(size: 20))
                    Spacer()
                    if let trend = trend {
                        Text(trend)
                            .font(AtelierTypography.secondaryText(12))
                            .foregroundColor(trend.contains("+") ? AtelierTheme.success : AtelierTheme.error)
                            .padding(.horizontal, 8)
                            .padding(.vertical, 4)
                            .background(
                                Capsule()
                                    .fill(trend.contains("+") ? AtelierTheme.success.opacity(0.1) : AtelierTheme.error.opacity(0.1))
                            )
                    }
                }
                
                Text(value)
                    .font(AtelierTypography.dashboardTitle(28))
                    .foregroundColor(AtelierTheme.textPrimary)
                
                Text(title)
                    .font(AtelierTypography.secondaryText(14))
                    .foregroundColor(AtelierTheme.textSecondary)
                    .textCase(.uppercase)
            }
        }
    }
}

struct LuxuryHeader: View {
    let title: String
    let subtitle: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: AtelierTheme.spacingXS) {
            Text(subtitle.uppercased())
                .font(AtelierTypography.secondaryText(12))
                .foregroundColor(AtelierTheme.accentGold)
                .kerning(2)
            
            Text(title)
                .font(AtelierTypography.luxuryHeader(36))
                .foregroundColor(AtelierTheme.textPrimary)
        }
        .padding(.vertical, AtelierTheme.spacingL)
    }
}

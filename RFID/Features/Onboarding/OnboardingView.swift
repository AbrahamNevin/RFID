import SwiftUI

struct OnboardingView: View {
    @ObservedObject var viewModel: AppViewModel
    @State private var appearanceOpacity: Double = 0
    @State private var roleCardOffsets: [CGFloat] = [100, 100, 100, 100, 100]
    
    var body: some View {
        ZStack {
            AtelierTheme.backgroundPrimary.ignoresSafeArea()
            
            // Background Glow
            RadialGradient(
                gradient: Gradient(colors: [AtelierTheme.accentGold.opacity(0.15), Color.clear]),
                center: .topTrailing,
                startRadius: 100,
                endRadius: 600
            )
            .ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: AtelierTheme.spacingXL) {
                    // Header
                    VStack(spacing: AtelierTheme.spacingS) {
                        Text("ATELIER")
                            .font(AtelierTypography.luxuryHeader(48))
                            .foregroundColor(AtelierTheme.accentGold)
                            .tracking(8)
                        
                        Text("Luxury Retail Intelligence OS")
                            .font(AtelierTypography.secondaryText(14))
                            .foregroundColor(AtelierTheme.textSecondary)
                            .kerning(2)
                    }
                    .padding(.top, 60)
                    .opacity(appearanceOpacity)
                    
                    Text("Select your role to enter the ecosystem")
                        .font(AtelierTypography.secondaryText(16))
                        .foregroundColor(AtelierTheme.textPrimary.opacity(0.8))
                        .padding(.top, 20)
                        .opacity(appearanceOpacity)
                    
                    // Role Cards
                    VStack(spacing: AtelierTheme.spacingM) {
                        ForEach(Array(UserRole.allCases.enumerated()), id: \.element.id) { index, role in
                            RoleSelectionCard(role: role) {
                                viewModel.selectRole(role)
                            }
                            .offset(y: roleCardOffsets[index])
                            .opacity(appearanceOpacity)
                        }
                    }
                    .padding(.horizontal, AtelierTheme.spacingL)
                }
                .padding(.bottom, 40)
            }
        }
        .onAppear {
            withAnimation(.easeOut(duration: 1.2)) {
                appearanceOpacity = 1.0
            }
            
            for index in 0..<5 {
                withAnimation(.spring(response: 0.8, dampingFraction: 0.7).delay(0.2 + Double(index) * 0.1)) {
                    roleCardOffsets[index] = 0
                }
            }
        }
    }
}

struct RoleSelectionCard: View {
    let role: UserRole
    let action: () -> Void
    @State private var isPressed: Bool = false
    
    var body: some View {
        Button(action: action) {
            GlassCard {
                HStack(spacing: AtelierTheme.spacingM) {
                    ZStack {
                        Circle()
                            .fill(AtelierTheme.accentGold.opacity(0.1))
                            .frame(width: 50, height: 50)
                        
                        Image(systemName: role.icon)
                            .font(.system(size: 24, weight: .light))
                            .foregroundColor(AtelierTheme.accentGold)
                    }
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text(role.rawValue)
                            .font(AtelierTypography.dashboardTitle(18))
                            .foregroundColor(AtelierTheme.textPrimary)
                        
                        Text(role.description)
                            .font(AtelierTypography.secondaryText(12))
                            .foregroundColor(AtelierTheme.textSecondary)
                            .multilineTextAlignment(.leading)
                            .lineLimit(2)
                    }
                    
                    Spacer()
                    
                    Image(systemName: "chevron.right")
                        .font(.system(size: 14, weight: .bold))
                        .foregroundColor(AtelierTheme.accentGold.opacity(0.5))
                }
            }
        }
        .buttonStyle(PlainButtonStyle())
        .scaleEffect(isPressed ? 0.98 : 1.0)
        .animation(.spring(), value: isPressed)
    }
}

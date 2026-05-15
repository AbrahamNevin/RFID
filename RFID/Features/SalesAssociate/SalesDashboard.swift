import SwiftUI

struct SalesAssociateDashboard: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: AtelierTheme.spacingL) {
                LuxuryHeader(title: "Client Excellence", subtitle: "Private Clienteling")
                
                // VIP Clients
                VStack(alignment: .leading, spacing: AtelierTheme.spacingM) {
                    Text("ACTIVE VIP CLIENTS")
                        .font(AtelierTypography.secondaryText(14))
                        .foregroundColor(AtelierTheme.textSecondary)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: AtelierTheme.spacingM) {
                            ForEach(MockDataStore.shared.clients) { client in
                                ClientProfileCard(client: client)
                            }
                        }
                    }
                }
                
                // AI Recommendations
                GlassCard {
                    VStack(alignment: .leading, spacing: AtelierTheme.spacingM) {
                        HStack {
                            Image(systemName: "sparkles")
                                .foregroundColor(AtelierTheme.accentGold)
                            Text("AI CLIENT RECOMMENDATIONS")
                                .font(AtelierTypography.secondaryText(14))
                                .foregroundColor(AtelierTheme.accentGold)
                                .kerning(1)
                        }
                        
                        HStack(spacing: AtelierTheme.spacingM) {
                            ForEach(MockDataStore.shared.products.prefix(2)) { product in
                                VStack(alignment: .leading, spacing: 4) {
                                    RoundedRectangle(cornerRadius: 12)
                                        .fill(AtelierTheme.backgroundDeep)
                                        .frame(height: 100)
                                        .overlay(Image(systemName: "tag").foregroundColor(AtelierTheme.accentGold.opacity(0.3)))
                                    
                                    Text(product.name)
                                        .font(AtelierTypography.secondaryText(12))
                                        .foregroundColor(AtelierTheme.textPrimary)
                                    Text("Match for: Alexandra V.")
                                        .font(AtelierTypography.secondaryText(10))
                                        .foregroundColor(AtelierTheme.textSecondary)
                                }
                            }
                        }
                    }
                }
                
                // Active Wishlists
                VStack(alignment: .leading, spacing: AtelierTheme.spacingM) {
                    Text("CURATED WISHLISTS")
                        .font(AtelierTypography.secondaryText(14))
                        .foregroundColor(AtelierTheme.textSecondary)
                    
                    ForEach(0..<2) { _ in
                        WishlistRow()
                    }
                }
            }
            .padding(.horizontal, AtelierTheme.spacingL)
            .padding(.bottom, 30)
        }
        .background(AtelierTheme.backgroundPrimary.ignoresSafeArea())
    }
}

struct ClientProfileCard: View {
    let client: Client
    
    var body: some View {
        GlassCard {
            VStack(alignment: .center, spacing: AtelierTheme.spacingS) {
                Circle()
                    .fill(AtelierTheme.accentGold.opacity(0.1))
                    .frame(width: 60, height: 60)
                    .overlay(
                        Text(String(client.name.prefix(1)))
                            .font(AtelierTypography.luxuryHeader(24))
                            .foregroundColor(AtelierTheme.accentGold)
                    )
                
                Text(client.name)
                    .font(AtelierTypography.dashboardTitle(16))
                    .foregroundColor(AtelierTheme.textPrimary)
                
                Text(client.tier)
                    .font(AtelierTypography.secondaryText(10))
                    .foregroundColor(AtelierTheme.accentGold)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 4)
                    .background(Capsule().fill(AtelierTheme.accentGold.opacity(0.1)))
                
                Divider().background(AtelierTheme.textSecondary.opacity(0.2))
                
                VStack(alignment: .leading, spacing: 4) {
                    Text("Last Visit: \(client.lastVisit, format: .dateTime.month().day())")
                        .font(AtelierTypography.secondaryText(10))
                        .foregroundColor(AtelierTheme.textSecondary)
                }
            }
            .frame(width: 140)
        }
    }
}

struct WishlistRow: View {
    var body: some View {
        HStack(spacing: AtelierTheme.spacingM) {
            Circle()
                .fill(AtelierTheme.backgroundDeep)
                .frame(width: 50, height: 50)
                .overlay(Image(systemName: "list.bullet.rectangle.portrait").foregroundColor(AtelierTheme.accentGold))
            
            VStack(alignment: .leading, spacing: 2) {
                Text("Spring Selection")
                    .font(AtelierTypography.dashboardTitle(16))
                    .foregroundColor(AtelierTheme.textPrimary)
                Text("Client: Alexandra Vance • 5 Items")
                    .font(AtelierTypography.secondaryText(12))
                    .foregroundColor(AtelierTheme.textSecondary)
            }
            
            Spacer()
            
            Image(systemName: "paperplane.fill")
                .foregroundColor(AtelierTheme.accentGold)
        }
        .padding(AtelierTheme.spacingM)
        .background(AtelierTheme.backgroundDeep.opacity(0.4))
        .cornerRadius(16)
    }
}

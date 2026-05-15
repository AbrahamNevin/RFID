import SwiftUI

struct CorporateAdminDashboard: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: AtelierTheme.spacingL) {
                LuxuryHeader(title: "Global Executive Intelligence", subtitle: "Corporate Administration")
                
                // KPI Grid
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: AtelierTheme.spacingM) {
                    KPIWidget(title: "Net Revenue", value: "$42.8M", trend: "+12.4%", icon: "dollarsign.circle")
                    KPIWidget(title: "Inv. Accuracy", value: "99.82%", trend: "+0.05%", icon: "checkmark.shield")
                    KPIWidget(title: "Global Shrink", value: "0.14%", trend: "-2.1%", icon: "arrow.down.right.circle")
                    KPIWidget(title: "Active RFID Tags", value: "142,503", trend: nil, icon: "antenna.radiowaves.left.and.right")
                }
                
                // AI Insights
                GlassCard {
                    VStack(alignment: .leading, spacing: AtelierTheme.spacingM) {
                        HStack {
                            Image(systemName: "sparkles")
                                .foregroundColor(AtelierTheme.accentGold)
                            Text("AI EXECUTIVE INSIGHTS")
                                .font(AtelierTypography.secondaryText(14))
                                .foregroundColor(AtelierTheme.accentGold)
                                .kerning(1)
                        }
                        
                        Text("Predictive analysis suggests a 15% increase in Couture demand in the North American region for Q3. Recommend reallocating 500 units from EMEA.")
                            .font(AtelierTypography.bodyText(15))
                            .foregroundColor(AtelierTheme.textPrimary.opacity(0.9))
                            .lineSpacing(4)
                        
                        Button(action: {}) {
                            Text("View Detailed Forecast")
                                .font(AtelierTypography.secondaryText(12))
                                .foregroundColor(AtelierTheme.accentGold)
                                .padding(.horizontal, 16)
                                .padding(.vertical, 8)
                                .background(Capsule().stroke(AtelierTheme.accentGold, lineWidth: 1))
                        }
                    }
                }
                
                // Regional Sales Chart Placeholder
                GlassCard {
                    VStack(alignment: .leading, spacing: AtelierTheme.spacingM) {
                        Text("REGIONAL SALES DISTRIBUTION")
                            .font(AtelierTypography.secondaryText(14))
                            .foregroundColor(AtelierTheme.textSecondary)
                        
                        // Simple Chart Mockup
                        HStack(alignment: .bottom, spacing: 20) {
                            ChartBar(label: "NA", value: 0.8, color: AtelierTheme.accentGold)
                            ChartBar(label: "EU", value: 0.6, color: AtelierTheme.accentGold.opacity(0.8))
                            ChartBar(label: "ASIA", value: 0.9, color: AtelierTheme.accentGold)
                            ChartBar(label: "ME", value: 0.4, color: AtelierTheme.accentGold.opacity(0.6))
                        }
                        .frame(height: 150)
                        .padding(.top, 10)
                    }
                }
                
                // Top Products
                VStack(alignment: .leading, spacing: AtelierTheme.spacingM) {
                    Text("TOP PERFORMING COLLECTIONS")
                        .font(AtelierTypography.secondaryText(14))
                        .foregroundColor(AtelierTheme.textSecondary)
                    
                    ForEach(MockDataStore.shared.products.prefix(3)) { product in
                        ProductRow(product: product)
                    }
                }
            }
            .padding(.horizontal, AtelierTheme.spacingL)
            .padding(.bottom, 30)
        }
        .background(AtelierTheme.backgroundPrimary.ignoresSafeArea())
    }
}

struct ChartBar: View {
    let label: String
    let value: CGFloat
    let color: Color
    @State private var barHeight: CGFloat = 0
    
    var body: some View {
        VStack {
            Spacer()
            RoundedRectangle(cornerRadius: 6)
                .fill(color)
                .frame(width: 30, height: barHeight)
            Text(label)
                .font(AtelierTypography.secondaryText(10))
                .foregroundColor(AtelierTheme.textSecondary)
        }
        .onAppear {
            withAnimation(.spring(response: 1.0, dampingFraction: 0.7).delay(0.5)) {
                barHeight = 120 * value
            }
        }
    }
}

struct ProductRow: View {
    let product: Product
    
    var body: some View {
        HStack(spacing: AtelierTheme.spacingM) {
            RoundedRectangle(cornerRadius: 12)
                .fill(AtelierTheme.backgroundDeep)
                .frame(width: 60, height: 60)
                .overlay(
                    Image(systemName: "photo")
                        .foregroundColor(AtelierTheme.textSecondary.opacity(0.3))
                )
            
            VStack(alignment: .leading, spacing: 2) {
                Text(product.name)
                    .font(AtelierTypography.dashboardTitle(16))
                    .foregroundColor(AtelierTheme.textPrimary)
                Text(product.brand)
                    .font(AtelierTypography.secondaryText(12))
                    .foregroundColor(AtelierTheme.textSecondary)
            }
            
            Spacer()
            
            Text("$\(Int(product.price))")
                .font(AtelierTypography.dashboardTitle(16))
                .foregroundColor(AtelierTheme.accentGold)
        }
        .padding(AtelierTheme.spacingM)
        .background(AtelierTheme.backgroundDeep.opacity(0.4))
        .cornerRadius(16)
    }
}

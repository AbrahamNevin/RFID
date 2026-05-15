//
//  ContentView.swift
//  RFID
//
//  Created by Nevin Abraham on 15/05/26.
//

import SwiftUI
import Combine

struct ContentView: View {
    @StateObject var viewModel = AppViewModel()
    
    var body: some View {
        ZStack {
            if viewModel.showOnboarding {
                OnboardingView(viewModel: viewModel)
                    .transition(.opacity)
            } else {
                RoleRootView(role: viewModel.selectedRole)
                    .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading)))
            }
        }
        .animation(.spring(response: 0.6, dampingFraction: 0.8), value: viewModel.showOnboarding)
    }
}

struct RoleRootView: View {
    let role: UserRole?
    @EnvironmentObject var viewModel: AppViewModel
    
    var body: some View {
        NavigationView {
            ZStack {
                switch role {
                case .corporateAdmin:
                    CorporateAdminDashboard()
                case .boutiqueManager:
                    BoutiqueManagerDashboard()
                case .salesAssociate:
                    SalesAssociateDashboard()
                case .inventoryController:
                    InventoryControllerDashboard()
                case .afterSalesSpecialist:
                    AfterSalesDashboard()
                case .none:
                    Text("No Role Selected")
                }
            }
            .navigationBarItems(leading: Button(action: { viewModel.reset() }) {
                Image(systemName: "chevron.left")
                    .foregroundColor(AtelierTheme.accentGold)
                Text("Role Selection")
                    .foregroundColor(AtelierTheme.accentGold)
            })
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

enum UserRole: String, CaseIterable, Identifiable {
    case corporateAdmin = "Corporate Admin"
    case boutiqueManager = "Boutique Manager"
    case salesAssociate = "Sales Associate"
    case inventoryController = "Inventory Controller"
    case afterSalesSpecialist = "After-Sales Specialist"
    
    var id: String { self.rawValue }
    
    var description: String {
        switch self {
        case .corporateAdmin: return "Global intelligence and executive insights."
        case .boutiqueManager: return "Boutique operations and client excellence."
        case .salesAssociate: return "Personalized clienteling and luxury storytelling."
        case .inventoryController: return "Real-time RFID intelligence and stock precision."
        case .afterSalesSpecialist: return "Authentication, repairs, and service lifecycle."
        }
    }
    
    var icon: String {
        switch self {
        case .corporateAdmin: return "chart.bar.xaxis"
        case .boutiqueManager: return "building.2"
        case .salesAssociate: return "person.text.rectangle"
        case .inventoryController: return "antenna.radiowaves.left.and.right"
        case .afterSalesSpecialist: return "wrench.and.screwdriver"
        }
    }
}

final class AppViewModel: ObservableObject {
    @Published var selectedRole: UserRole? = nil
    @Published var showOnboarding: Bool = true
    
    func selectRole(_ role: UserRole) {
        withAnimation(.spring(response: 0.6, dampingFraction: 0.8)) {
            selectedRole = role
            showOnboarding = false
        }
    }
    
    func reset() {
        withAnimation {
            selectedRole = nil
            showOnboarding = true
        }
    }
}

import SwiftUI
import Combine

enum UserRole: String, CaseIterable, Identifiable, Codable {
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

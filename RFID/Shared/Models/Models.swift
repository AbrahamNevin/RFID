import Foundation

enum ProductStatus: String, Codable {
    case inStock = "In Stock"
    case sold = "Sold"
    case inService = "In Service"
    case transferred = "Transferred"
    case missing = "Missing"
}

struct Product: Identifiable, Codable {
    let id: UUID
    let sku: String
    let name: String
    let brand: String
    let category: String // Watches, Jewelry, Couture, Handbags
    let price: Double
    let status: ProductStatus
    let rfidTag: String
    let imageUrl: String
    let location: String
}

struct RFIDEvent: Identifiable {
    let id = UUID()
    let timestamp: Date
    let rfidTag: String
    let location: String
    let eventType: RFIDEventType
    let productName: String
}

enum RFIDEventType: String {
    case detected = "Detected"
    case moved = "Moved"
    case missing = "Missing"
    case duplicate = "Duplicate"
    case unauthorized = "Unauthorized Movement"
}

struct Client: Identifiable {
    let id: UUID
    let name: String
    let tier: String // VIP, Platinum, Gold
    let purchaseHistory: [String]
    let preferredCategories: [String]
    let lastVisit: Date
}

struct RepairTicket: Identifiable {
    let id: UUID
    let productName: String
    let status: String // Intake, Assessment, Repairing, QA, Ready
    let intakeDate: Date
    let estimatedCompletion: Date
    let clientName: String
}

struct Appointment: Identifiable {
    let id: UUID
    let clientName: String
    let type: String // Private Viewing, Fitting, Repair Consultation
    let time: Date
    let staffName: String
}

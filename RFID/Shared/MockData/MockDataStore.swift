import Foundation

class MockDataStore {
    static let shared = MockDataStore()
    
    let products: [Product] = [
        Product(id: UUID(), sku: "W-ROX-SUB-01", name: "Submariner Date", brand: "Rolex", category: "Watches", price: 10500, status: .inStock, rfidTag: "E280116060000205", imageUrl: "watch_rolex", location: "Boutique A - Shelf 1"),
        Product(id: UUID(), sku: "W-AP-RO-02", name: "Royal Oak", brand: "Audemars Piguet", category: "Watches", price: 45000, status: .inStock, rfidTag: "E280116060000206", imageUrl: "watch_ap", location: "Boutique A - Vault"),
        Product(id: UUID(), sku: "H-LV-CAP-03", name: "Capucines MM", brand: "Louis Vuitton", category: "Handbags", price: 6100, status: .inStock, rfidTag: "E280116060000207", imageUrl: "bag_lv", location: "Boutique A - Display"),
        Product(id: UUID(), sku: "J-CAR-LOVE-04", name: "LOVE Bracelet", brand: "Cartier", category: "Jewelry", price: 7350, status: .inStock, rfidTag: "E280116060000208", imageUrl: "jewelry_cartier", location: "Boutique A - Showcase 2"),
        Product(id: UUID(), sku: "C-HER-BIR-05", name: "Birkin 30", brand: "Hermès", category: "Handbags", price: 12000, status: .inStock, rfidTag: "E280116060000209", imageUrl: "bag_hermes", location: "Boutique A - Shelf 4")
    ]
    
    let clients: [Client] = [
        Client(id: UUID(), name: "Alexandra Vance", tier: "VIP", purchaseHistory: ["Rolex Submariner", "Cartier Love Ring"], preferredCategories: ["Watches", "Jewelry"], lastVisit: Date().addingTimeInterval(-86400 * 5)),
        Client(id: UUID(), name: "Julian Thorne", tier: "Platinum", purchaseHistory: ["Birkin 35", "LV Keepall"], preferredCategories: ["Handbags", "Couture"], lastVisit: Date().addingTimeInterval(-86400 * 2))
    ]
    
    let repairs: [RepairTicket] = [
        RepairTicket(id: UUID(), productName: "Daytona 116500LN", status: "Repairing", intakeDate: Date().addingTimeInterval(-86400 * 10), estimatedCompletion: Date().addingTimeInterval(86400 * 5), clientName: "Marcus Reed"),
        RepairTicket(id: UUID(), productName: "Love Bracelet Gold", status: "QA Approval", intakeDate: Date().addingTimeInterval(-86400 * 3), estimatedCompletion: Date().addingTimeInterval(86400 * 1), clientName: "Elena Moretti")
    ]
    
    let appointments: [Appointment] = [
        Appointment(id: UUID(), clientName: "Alexandra Vance", type: "Private Viewing", time: Date().addingTimeInterval(3600 * 2), staffName: "Jean-Paul"),
        Appointment(id: UUID(), clientName: "Julian Thorne", type: "Repair Consultation", time: Date().addingTimeInterval(3600 * 4), staffName: "Sarah Chen")
    ]
}

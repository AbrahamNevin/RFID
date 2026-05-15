import Foundation

protocol AtelierRepository {
    func fetchProducts() -> [Product]
    func fetchClients() -> [Client]
    func fetchRepairs() -> [RepairTicket]
    func fetchAppointments() -> [Appointment]
}

final class MockRepository: AtelierRepository {
    private let store = MockDataStore.shared
    
    func fetchProducts() -> [Product] {
        return store.products
    }
    
    func fetchClients() -> [Client] {
        return store.clients
    }
    
    func fetchRepairs() -> [RepairTicket] {
        return store.repairs
    }
    
    func fetchAppointments() -> [Appointment] {
        return store.appointments
    }
}

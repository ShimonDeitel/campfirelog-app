import Foundation

struct CampsiteEntry: Identifiable, Codable, Equatable {
    var id: UUID = UUID()
    var name: String
    var location: String
    var dates: String
    var rating: String
    var notes: String
    var dateCreated: Date = Date()
}

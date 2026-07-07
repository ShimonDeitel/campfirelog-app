import Foundation
import Combine

@MainActor
final class Store: ObservableObject {
    @Published var entries: [CampsiteEntry] = []
    @Published var isPro: Bool = false

    static let freeLimit = 23

    private let fileURL: URL = {
        let dir = FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask).first!
        try? FileManager.default.createDirectory(at: dir, withIntermediateDirectories: true)
        return dir.appendingPathComponent("campfirelog_entries.json")
    }()

    init() {
        load()
        if entries.isEmpty {
            seed()
        }
    }

    func seed() {
        entries = [
        CampsiteEntry(name: "Pine Ridge Site 14", location: "Pine Ridge Campground", dates: "Jun 12-14", rating: "5", notes: "Great fire pit, near water"),
        CampsiteEntry(name: "Lakeview Dispersed", location: "Lakeview backcountry", dates: "Jul 3-5", rating: "4", notes: "No cell signal, quiet"),
        CampsiteEntry(name: "Cedar Hollow #3", location: "Cedar Hollow State Park", dates: "Aug 20-21", rating: "3", notes: "Crowded on weekends")
        ]
        save()
    }

    var canAddMore: Bool {
        isPro || entries.count < Store.freeLimit
    }

    func add(location: String, dates: String, rating: String, notes: String) {
        guard canAddMore else { return }
        let entry = CampsiteEntry(name: name, location: location, dates: dates, rating: rating, notes: notes)
        entries.insert(entry, at: 0)
        save()
    }

    func update(_ entry: CampsiteEntry) {
        if let idx = entries.firstIndex(where: { $0.id == entry.id }) {
            entries[idx] = entry
            save()
        }
    }

    func delete(at offsets: IndexSet) {
        entries.remove(atOffsets: offsets)
        save()
    }

    func delete(_ entry: CampsiteEntry) {
        entries.removeAll { $0.id == entry.id }
        save()
    }

    func load() {
        guard let data = try? Data(contentsOf: fileURL) else { return }
        if let decoded = try? JSONDecoder().decode([CampsiteEntry].self, from: data) {
            entries = decoded
        }
    }

    func save() {
        guard let data = try? JSONEncoder().encode(entries) else { return }
        try? data.write(to: fileURL, options: .atomic)
    }
}

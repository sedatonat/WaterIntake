// Copied from IOS Example ToDo App

import Foundation

actor InMemoryStorageService: StorageServiceProtocol {
    var dataFieldsWaterIntakes: AsyncStream<[DataFieldsWaterIntake]> {
        get async {
            values
        }
    }
    private let (input, values) = AsyncStream<[DataFieldsWaterIntake]>.pipe()
    private var value: [DataFieldsWaterIntake] = [] {
        didSet {
            input(value)
        }
    }
    func create(dataFieldsWaterIntake: DataFieldsWaterIntake) async throws {
        guard index(with: dataFieldsWaterIntake.id) == nil else { return }
        value.append(dataFieldsWaterIntake)
    }

    func read(_ id: UUID) async throws -> DataFieldsWaterIntake? {
        index(with: id).map { value[$0] }
    }

    func update(dataFieldsWaterIntake: DataFieldsWaterIntake) async throws {
        guard let index = index(with: dataFieldsWaterIntake.id) else { return }
        value[index] = dataFieldsWaterIntake
    }

    func delete(id: UUID) async throws {
        guard let index = index(with: id) else { return }
        value.remove(at: index)
    }

    private func index(with id: UUID) -> Int? {
        value.firstIndex(where: { $0.id == id })
    }

}

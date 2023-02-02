// Copied from IOS Example ToDo App

import Foundation

protocol StorageServiceProtocol {
    var dataFieldsWaterIntakes: AsyncStream<[DataFieldsWaterIntake]> { get async }
    func create(dataFieldsWaterIntake: DataFieldsWaterIntake) async throws
    func read(_ id: UUID) async throws -> DataFieldsWaterIntake?
    func update(dataFieldsWaterIntake: DataFieldsWaterIntake) async throws
    func delete(id: UUID) async throws
}

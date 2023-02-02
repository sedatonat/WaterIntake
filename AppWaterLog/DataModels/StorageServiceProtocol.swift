// Copied from IOS Example ToDo App

import Foundation

protocol StorageServiceProtocol {
    var dataFields: AsyncStream<[DataFields]> { get async }
    func create(dataFields: DataFields) async throws
    func read(_ id: UUID) async throws -> DataFields?
    func update(dataFields: DataFields) async throws
    func delete(id: UUID) async throws
}

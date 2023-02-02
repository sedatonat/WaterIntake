// Copied from IOS Example ToDo App

import Foundation

actor InMemoryStorageService: StorageServiceProtocol {
    var toDos: AsyncStream<[DataField]> {
        get async {
            values
        }
    }
    private let (input, values) = AsyncStream<[ToDo]>.pipe()
    private var value: [DataField] = [] {
        didSet {
            input(value)
        }
    }
    func create(dataField: DataField) async throws {
        guard index(with: toDo.id) == nil else { return }
        value.append(toDo)
    }

    func read(_ id: UUID) async throws -> ToDo? {
        index(with: id).map { value[$0] }
    }

    func update(dataField: DataField) async throws {
        guard let index = index(with: dataField.id) else { return }
        value[index] = dataField
    }

    func delete(id: UUID) async throws {
        guard let index = index(with: id) else { return }
        value.remove(at: index)
    }

    private func index(with id: UUID) -> Int? {
        value.firstIndex(where: { $0.id == id })
    }

}

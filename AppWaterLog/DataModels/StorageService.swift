// Copied from IOS Example ToDo App

import CoreData

actor StorageService: StorageServiceProtocol {

    private let container: NSPersistentContainer
    private let delegate: Delegate
    private let context: NSManagedObjectContext
    var dataFieldsWaterIntakes: AsyncStream<[DataFieldsWaterIntake]> {
        get async { delegate.values }
    }
    init() {
        container = NSPersistentCloudKitContainer(name: "EntityWaterIntake")
        container.loadPersistentStores { storeDescription, error in
            print(storeDescription, String(describing: error))
        }
        context = container.newBackgroundContext()
        context.automaticallyMergesChangesFromParent = true
        delegate = .init(context: context)
    }

    func create(dataFieldsWaterIntake: DataFieldsWaterIntake) async throws {
        _ = EntityWaterIntake(dataFieldsWaterIntake: dataFieldsWaterIntake, context: context)
        try context.save()
    }

    func read(_ id: UUID) async throws -> DataFieldsWaterIntake? {
        try fetch(by: id).map(DataFieldsWaterIntake.init(from:))
    }

    func update(dataFieldsWaterIntake: DataFieldsWaterIntake) async throws {
        guard let toUpdate = try fetch(by: dataFieldsWaterIntake.id) else { return }
        toUpdate.update(from: dataFieldsWaterIntake)
        try context.save()
    }

    func delete(id: UUID) async throws {
        guard let toDelete = try fetch(by: id) else { return }
        context.delete(toDelete)
        try context.save()
    }

    private func fetch(by id: UUID) throws -> EntityWaterIntake? {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: EntityWaterIntake.description())
        let sort = NSSortDescriptor(key: "id", ascending: false)
        request.sortDescriptors = [sort]
        request.predicate = NSPredicate(format: "id = %@", id as NSUUID)
        guard let found = try context.fetch(request).first as? EntityWaterIntake else { return nil }
        return found
    }

    private final class Delegate: NSObject, NSFetchedResultsControllerDelegate {
        let values: AsyncStream<[DataFieldsWaterIntake]>
        let controller:  NSFetchedResultsController<NSFetchRequestResult>
        private let input: ([DataFieldsWaterIntake]) -> ()
        init(context: NSManagedObjectContext) {
            (input, values) = AsyncStream<[DataFieldsWaterIntake]>.pipe()
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: EntityWaterIntake.description())
            let sort = NSSortDescriptor(key: "id", ascending: false)
            request.sortDescriptors = [sort]
            controller = NSFetchedResultsController<NSFetchRequestResult>(fetchRequest: request, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
            super.init()
            controller.delegate = self
            try? controller.performFetch()
            controllerDidChangeContent(controller)
        }
        func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
            guard let dataFieldsWaterIntakes = controller
                    .fetchedObjects?
                    .compactMap({ $0 as? EntityWaterIntake })
                    .map(DataFieldsWaterIntake.init(from:)) else { return }
            input(dataFieldsWaterIntakes)
        }
    }

}


private extension EntityWaterIntake {
    convenience init(dataFieldsWaterIntake: DataFieldsWaterIntake, context: NSManagedObjectContext) {
        self.init(context: context)
        id = dataFieldsWaterIntake.id
        update(from: dataFieldsWaterIntake)
    }
    func update(from dataFieldsWaterIntake: DataFieldsWaterIntake) {
        intakeDate = dataFieldsWaterIntake.intakeDate
        intakeType = dataFieldsWaterIntake.intakeType
        intakeAmount = dataFieldsWaterIntake.intakeAmount
    }
}

private extension DataFieldsWaterIntake {
    init(from entityWaterIntake: EntityWaterIntake) {
        id = entityWaterIntake.id  ?? .init()
        intakeDate = entityWaterIntake.intakeDate!
        intakeType = entityWaterIntake.intakeType ?? ""
        intakeAmount = entityWaterIntake.intakeAmount
    }
}



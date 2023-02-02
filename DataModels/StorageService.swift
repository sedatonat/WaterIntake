//
//  Model_Input.swift
//  SOPS001X
//
//  Created by Sedat Onat on 31.01.2023.
//
//
//import Foundation
//import SwiftUI
//import CoreData
//
//class ClassDataIntake: NSManagedObject, Identifiable {
//
//    @NSManaged var intakeAmount: Double
//    @NSManaged var intakeDate: Date
//    @NSManaged var intakeID: UUID
//    @NSManaged var intakeType: String
//    @NSManaged var timeStamp: Date
//}
//
//public extension NSManagedObject {
//    convenience init(context: NSManagedObjectContext) {
//        let name = String(describing: type(of: self))
//        let entity = NSEntityDescription.entity(forEntityName: name, in: context)!
//        self.init(entity: entity, insertInto: context)
//    }
//}
//
//extension ClassDataIntake {
//    static func getListItemFetchRequest() -> NSFetchRequest<ClassDataIntake>{
//        let request = ClassDataIntake.fetchRequest() as! NSFetchRequest<ClassDataIntake>
//        request.sortDescriptors = [NSSortDescriptor(key: "intakeID", ascending: true)]
//        return request
//    }
//}



// Copied from IOS Example ToDo App

import CoreData

actor StorageService: StorageServiceProtocol {

    private let container: NSPersistentContainer
    private let delegate: Delegate
    private let context: NSManagedObjectContext
    var dataFields: AsyncStream<[DataField]> {
        get async { delegate.values }
    }
    init() {
        container = NSPersistentCloudKitContainer(name: "EntityDataIntake")
        container.loadPersistentStores { storeDescription, error in
            print(storeDescription, String(describing: error))
        }
        context = container.newBackgroundContext()
        context.automaticallyMergesChangesFromParent = true
        delegate = .init(context: context)
    }

    func create(dataField: DataField) async throws {
        _ = EntityDataIntake(dataField: dataField, context: context)
        try context.save()
    }

    func read(_ id: UUID) async throws -> DataField? {
        try fetch(by: id).map(ToDo.init(from:))
    }

    func update(dataField: Datafield) async throws {
        guard let toUpdate = try fetch(by: dataField.id) else { return }
        toUpdate.update(from: dataField)
        try context.save()
    }

    func delete(id: UUID) async throws {
        guard let toDelete = try fetch(by: id) else { return }
        context.delete(toDelete)
        try context.save()
    }

    private func fetch(by id: UUID) throws -> EntityDataIntake? {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: EntityDataIntake.description())
        let sort = NSSortDescriptor(key: "id", ascending: false)
        request.sortDescriptors = [sort]
        request.predicate = NSPredicate(format: "id = %@", id as NSUUID)
        guard let found = try context.fetch(request).first as? EntityDataIntake else { return nil }
        return found
    }

    private final class Delegate: NSObject, NSFetchedResultsControllerDelegate {
        let values: AsyncStream<[DataField]>
        let controller:  NSFetchedResultsController<NSFetchRequestResult>
        private let input: ([DataField]) -> ()
        init(context: NSManagedObjectContext) {
            (input, values) = AsyncStream<[DataField]>.pipe()
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: EntityDataIntake.description())
            let sort = NSSortDescriptor(key: "id", ascending: false)
            request.sortDescriptors = [sort]
            controller = NSFetchedResultsController<NSFetchRequestResult>(fetchRequest: request, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
            super.init()
            controller.delegate = self
            try? controller.performFetch()
            controllerDidChangeContent(controller)
        }
        func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
            guard let datafields = controller
                    .fetchedObjects?
                    .compactMap({ $0 as? EntityDataIntake })
                    .map(DataField.init(from:)) else { return }
            input(DataFields)
        }
    }

}


private extension EntityDataIntake {
    convenience init(dataField: DataField, context: NSManagedObjectContext) {
        self.init(context: context)
        id = dataField.id
        update(from: dataField)
    }
    func update(from todo: ToDo) {
        created = todo.created
        title = todo.title
        subtitle = todo.subtitle
        completed = todo.completed
    }
}

private extension ToDo {
    init(from managedToDo: EntityDataIntake) {
        id = managedToDo.id  ?? .init()
        created = managedToDo.created ?? .now
        title = managedToDo.title ?? ""
        subtitle = managedToDo.subtitle ?? ""
        completed = managedToDo.completed
    }
}


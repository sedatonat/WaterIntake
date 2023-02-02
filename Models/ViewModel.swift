//
//  Model_Input.swift
//  SOPS001X
//
//  Created by Sedat Onat on 31.01.2023.
//

import Foundation
import SwiftUI
import CoreData

class ClassDataIntake: NSManagedObject , Identifiable {
    
    @NSManaged var intakeAmount: Double
    @NSManaged var intakeDate: Date
    @NSManaged var intakeID: UUID
    @NSManaged var intakeType: String
    @NSManaged var timeStamp: Date
}

public extension NSManagedObject {
    convenience init(context: NSManagedObjectContext) {
        let name = String(describing: type(of: self))
        let entity = NSEntityDescription.entity(forEntityName: name, in: context)!
        self.init(entity: entity, insertInto: context)
    }
}

extension ClassDataIntake {
    static func getListItemFetchRequest() -> NSFetchRequest<ClassDataIntake>{
        let request = ClassDataIntake.fetchRequest() as! NSFetchRequest<ClassDataIntake>
        request.sortDescriptors = [NSSortDescriptor(key: "intakeID", ascending: true)]
        return request
    }
}



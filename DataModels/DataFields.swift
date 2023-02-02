// Copied from IOS Example ToDo App

import Foundation

struct DataFields: Hashable, Identifiable {
    var id: UUID
    var timeStamp: Date
    var intakeDate: Date
    var intakeType: String
    var intakeAmount: Double
}

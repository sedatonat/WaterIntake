// Copied from IOS Example ToDo App

import Foundation

struct DataFieldsWaterIntake: Hashable, Identifiable {
    var id = UUID()
    var intakeDate: Date
    var intakeType: String
    var intakeAmount: Double
}

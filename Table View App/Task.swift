import Foundation

enum TaskType{
    case daily
    case weekly
    case monthly
}

struct Task {
    var name: String
    var type: TaskType
    var completed: Bool
    var lastCompleted: NSDate?
}

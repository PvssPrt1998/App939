
import Foundation
import CoreData


extension TrainingCD {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TrainingCD> {
        return NSFetchRequest<TrainingCD>(entityName: "TrainingCD")
    }

    @NSManaged public var speed: String
    @NSManaged public var distance: String
    @NSManaged public var time: Int32
    @NSManaged public var tid: Int32
    @NSManaged public var date: String
    @NSManaged public var uuid: UUID

}

extension TrainingCD : Identifiable {

}

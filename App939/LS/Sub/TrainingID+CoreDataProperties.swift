import Foundation
import CoreData


extension TrainingID {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TrainingID> {
        return NSFetchRequest<TrainingID>(entityName: "TrainingID")
    }

    @NSManaged public var tid: Int32

}

extension TrainingID : Identifiable {

}

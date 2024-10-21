
import Foundation
import CoreData


extension DailyTrainingTime {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DailyTrainingTime> {
        return NSFetchRequest<DailyTrainingTime>(entityName: "DailyTrainingTime")
    }

    @NSManaged public var time: Int32

}

extension DailyTrainingTime : Identifiable {

}

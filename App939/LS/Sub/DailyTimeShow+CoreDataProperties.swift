
import Foundation
import CoreData


extension DailyTimeShow {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DailyTimeShow> {
        return NSFetchRequest<DailyTimeShow>(entityName: "DailyTimeShow")
    }

    @NSManaged public var show: Bool

}

extension DailyTimeShow : Identifiable {

}

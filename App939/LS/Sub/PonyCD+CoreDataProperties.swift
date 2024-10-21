
import Foundation
import CoreData


extension PonyCD {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PonyCD> {
        return NSFetchRequest<PonyCD>(entityName: "PonyCD")
    }

    @NSManaged public var name: String
    @NSManaged public var breed: String
    @NSManaged public var age: String
    @NSManaged public var height: String
    @NSManaged public var weight: String
    @NSManaged public var personality: String
    @NSManaged public var color: String
    @NSManaged public var ponyId: UUID
    @NSManaged public var ponyImageData: Data

}

extension PonyCD : Identifiable {

}

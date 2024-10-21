
import Foundation
import CoreData


extension BasicInfo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<BasicInfo> {
        return NSFetchRequest<BasicInfo>(entityName: "BasicInfo")
    }

    @NSManaged public var image: Data
    @NSManaged public var name: String
    @NSManaged public var address: String

}

extension BasicInfo : Identifiable {

}

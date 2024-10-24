

import Foundation
import CoreData


extension NewPonyName {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<NewPonyName> {
        return NSFetchRequest<NewPonyName>(entityName: "NewPonyName")
    }

    @NSManaged public var name: String?

}

extension NewPonyName : Identifiable {

}

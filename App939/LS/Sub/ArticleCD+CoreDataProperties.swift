

import Foundation
import CoreData


extension ArticleCD {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ArticleCD> {
        return NSFetchRequest<ArticleCD>(entityName: "ArticleCD")
    }

    @NSManaged public var aId: UUID
    @NSManaged public var name: String
    @NSManaged public var descr: String
    @NSManaged public var image: Data

}

extension ArticleCD : Identifiable {

}

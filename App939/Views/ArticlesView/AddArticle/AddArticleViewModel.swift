
import Foundation

final class AddArticleViewModel: ObservableObject {
    
    let dm: DataController
    
    @Published var image: Data?
    @Published var name: String = ""
    @Published var articleText: String = ""
    
    var articleDisabled: Bool {
        name == "" || articleText == ""
    }
    
    init(dm: DataController) {
        self.dm = dm
    }
    
    func articleSave() {
        guard let image = image else { return }
        dm.saveArticle(Article(id: UUID(), image: image, name: name, description: articleText))
    }
}

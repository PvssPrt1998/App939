import Foundation

final class AddKartViewModel: ObservableObject {
    
    let dm: DataController
    
    var addBasicDisabled: Bool {
        basicName == "" || basicAddress == "" || imageData == nil
    }
    
    @Published var basicName: String = ""
    @Published var basicAddress: String = ""
    @Published var imageData: Data?
    
    init(dm: DataController) {
        self.dm = dm
    }
    
    func basicSave() {
        guard let imageData = imageData else { return }
        let kart = Kart(image: imageData, name: basicName, address: basicAddress)
        dm.saveKart(kart)
        basicName = ""
        basicAddress = ""
        self.imageData = nil
    }
}

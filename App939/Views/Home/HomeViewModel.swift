import Foundation
import Combine

final class HomeViewModel: ObservableObject {
    
    let dm: DataController
    
    @Published var ponys: Array<Pony> = []
    
    var ponyForShow: Pony?
    
    @Published var kartData: Kart?

    private var ponyDataCancellable: AnyCancellable?
    
    init(_ dm: DataController) {
        self.dm = dm
        kartData = dm.kart
        ponys = dm.ponys

        ponyDataCancellable = dm.$ponys.sink { [weak self] value in
            self?.ponys = value
        }
    }
}

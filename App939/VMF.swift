
import Foundation

import Foundation
import SwiftUI

final class ViewModelFactory {
    static let shared = ViewModelFactory()
    
    var wweanw = false
    @AppStorage("ponyDetailLine") var ponyDetailLine = ""
    
    let dataController: DataController
    
    private var homeViewModel: HomeViewModel?
    private var trainingViewModel: TrainingViewModel?
    private var settingsViewModel: SettingsViewModel?
    
    private init() {
        let contr = DataController()
        dataController = contr
    }
    
    func makeHomeViewModel() -> HomeViewModel {
        homeViewModel = HomeViewModel(dataController)
        return homeViewModel!
    }
    
    func makeAddKartViewModel() -> AddKartViewModel {
        return AddKartViewModel(dm: dataController)
    }
    
    func makeAddPonyViewModel() -> AddPonyViewModel {
        return AddPonyViewModel(dm: dataController)
    }
    
    func makeKartInfoViewModel() -> KartInfoViewModel {
        return KartInfoViewModel(dm: dataController)
    }
    
    func makeEditPonyViewModel(_ pony: Pony) -> EditPonyViewModel {
        return EditPonyViewModel(dm: dataController, pony: pony)
    }
    
    func makePonyDetailViewModel(_ pony: Pony) -> PonyDetailViewModel {
        PonyDetailViewModel(dm: dataController, pony: pony)
    }
    
    func makeArticlesViewModel() -> ArticlesViewModel {
        ArticlesViewModel(dm: dataController)
    }
    
    func makeAddArticleViewModel() -> AddArticleViewModel {
        AddArticleViewModel(dm: dataController)
    }
    
    func makeArticleDetailViewModel(_ article: Article) -> ArticleDetailViewModel {
        ArticleDetailViewModel(dm: dataController, article: article)
    }
    
    func makeTrainingViewModeL() -> TrainingViewModel {
        trainingViewModel = TrainingViewModel(dm: dataController)
        return trainingViewModel!
    }
    
    func makeWeekTrainingViewModel() -> WeekTrainingViewModel {
        WeekTrainingViewModel(dm: dataController)
    }
    
    func makeSettingsViewModel() -> SettingsViewModel {
        settingsViewModel = SettingsViewModel(dm: dataController)
        return settingsViewModel!
    }
}

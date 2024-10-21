import Foundation

final class DataController {
    
    @Published var kart: Kart?
    @Published var ponys: Array<Pony> = []
    @Published var articles: Array<Article> = []
    @Published var trainings: Array<Training> = []
    
    var trainingId = 1
    
    @Published var profilePicture: Data?
    @Published var dailyTrainingTime: Int = 30
    
    let ls = LS()
    
    func load() {
        DispatchQueue.global(qos: .utility).async { [weak self] in
            guard let self = self else { return }
            
            if let ponys = try? ls.fetchPonys() {
                self.ponys = ponys
            }
            if let kart = try? ls.fetchKart() {
                self.kart = kart
            }
            if let articles = try? ls.fetchArticles() {
                self.articles = articles
            }
            if let profilePic = try? ls.fetchProfilePicture() {
                self.profilePicture = profilePic
            }
            if let time = try? ls.fetchDailyTrainingTime() {
                self.dailyTrainingTime = time
            }
            if let trainings = try? ls.fetchTrainings() {
                self.trainings = trainings
            }
            if let trainingID = try? ls.fetchTrainingID() {
                self.trainingId = trainingID
            }
        }
    }
    
    func saveTraining(_ training: Training) {
        trainings.append(training)
        ls.saveTraining(training)
        trainingId += 1
        ls.saveOrEditTrainingId(trainingId)
    }
    
    func deleteTraining(_ training: Training) {
        guard let index = trainings.firstIndex(where: {$0.uuid == training.uuid}) else { return }
        trainings.remove(at: index)
        try? ls.removeTraining(training)
    }
    
    func saveDailyTrainingTime(_ time: Int) {
        dailyTrainingTime = time
        ls.saveOrEditTime(time)
    }
    
    func saveProfilePicture(_ imageData: Data) {
        profilePicture = imageData
        ls.saveOrEditProfilePicture(imageData)
    }
    
    func saveArticle(_ article: Article) {
        articles.append(article)
        ls.saveArticle(article)
    }
    func deleteArticle(_ article: Article) {
        guard let index = articles.firstIndex(where: {$0.id == article.id}) else { return }
        articles.remove(at: index)
        try? ls.deleteArticle(article)
    }
    
    func deletePony(_ pony: Pony) {
        guard let index = ponys.firstIndex(where: {pony.ponyId == $0.ponyId}) else { return }
        ponys.remove(at: index)
        try? ls.deletePony(pony)
    }
    
    func saveKart(_ kart: Kart) {
        ls.saveOrEditKart(kart)
        self.kart = kart
    }
    
    func savePony(_ pony: Pony) {
        ponys.append(pony)
        ls.savePony(pony)
    }
    
    func editPony(_ pony: Pony) {
        guard let index = ponys.firstIndex(where: {pony.ponyId == $0.ponyId}) else { return }
        ponys[index] = pony
        ls.editPony(pony)
    }
}

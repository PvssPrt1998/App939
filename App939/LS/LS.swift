import Foundation

final class LS {
    private let modelName = "DataM"
    
    lazy var coreDataStack = CDS(modelName: modelName)
    
    func saveOrEditKart(_ kart: Kart) {
        do {
            let kartCDs = try coreDataStack.managedContext.fetch(BasicInfo.fetchRequest())
            if kartCDs.count > 0 {
                //exists
                kartCDs[0].image = kart.image
                kartCDs[0].name = kart.name
                kartCDs[0].address = kart.address
            } else {
                let kartCD = BasicInfo(context: coreDataStack.managedContext)
                kartCD.image = kart.image
                kartCD.name = kart.name
                kartCD.address = kart.address
            }
            coreDataStack.saveContext()
        } catch let error as NSError {
            print("Unresolved error \(error), \(error.userInfo)")
        }
    }
    
    func saveOrEditProfilePicture(_ data: Data) {
        do {
            let kartCDs = try coreDataStack.managedContext.fetch(ProfilePic.fetchRequest())
            if kartCDs.count > 0 {
                //exists
                kartCDs[0].pic = data
            } else {
                let kartCD = ProfilePic(context: coreDataStack.managedContext)
                kartCD.pic = data
            }
            coreDataStack.saveContext()
        } catch let error as NSError {
            print("Unresolved error \(error), \(error.userInfo)")
        }
    }
    
    func fetchProfilePicture() throws -> Data? {
        guard let profilePic = try coreDataStack.managedContext.fetch(ProfilePic.fetchRequest()).first else { return nil }
        return profilePic.pic
    }
    
    func saveOrEditTime(_ time: Int) {
        do {
            let kartCDs = try coreDataStack.managedContext.fetch(DailyTrainingTime.fetchRequest())
            if kartCDs.count > 0 {
                //exists
                kartCDs[0].time = Int32(time)
            } else {
                let kartCD =  DailyTrainingTime(context: coreDataStack.managedContext)
                kartCD.time = Int32(time)
            }
            coreDataStack.saveContext()
        } catch let error as NSError {
            print("Unresolved error \(error), \(error.userInfo)")
        }
    }
    
    func fetchDailyTrainingTime() throws -> Int? {
        guard let kartCD = try coreDataStack.managedContext.fetch(DailyTrainingTime.fetchRequest()).first else { return nil }
        return Int(kartCD.time)
    }
    
    func fetchKart() throws -> Kart? {
        guard let kartCD = try coreDataStack.managedContext.fetch(BasicInfo.fetchRequest()).first else { return nil }
        return Kart(image: kartCD.image, name: kartCD.name, address: kartCD.address)
    }
    
    func saveTraining(_ training: Training) {
        let trainingCD = TrainingCD(context: coreDataStack.managedContext)
        trainingCD.date = training.date
        trainingCD.distance = training.distance
        trainingCD.speed = training.speed
        trainingCD.uuid = training.uuid
        trainingCD.time = Int32(training.time)
        trainingCD.tid = Int32(training.id)
        coreDataStack.saveContext()
    }
    
    func saveOrEditTrainingId(_ id: Int) {
        do {
            let kartCDs = try coreDataStack.managedContext.fetch(TrainingID.fetchRequest())
            if kartCDs.count > 0 {
                //exists
                kartCDs[0].tid = Int32(id)
            } else {
                let kartCD =  TrainingID(context: coreDataStack.managedContext)
                kartCD.tid = Int32(id)
            }
            coreDataStack.saveContext()
        } catch let error as NSError {
            print("Unresolved error \(error), \(error.userInfo)")
        }
    }
    
    func fetchTrainingID() throws -> Int? {
        guard let kartCD = try coreDataStack.managedContext.fetch(TrainingID.fetchRequest()).first else { return nil }
        return Int(kartCD.tid)
    }
    
    func removeTraining(_ training: Training) throws {
        let ponys = try coreDataStack.managedContext.fetch(TrainingCD.fetchRequest())
        let ponyCD = ponys.first(where: {$0.uuid == training.uuid})
        guard let ponyCD = ponyCD else { return }
        coreDataStack.managedContext.delete(ponyCD)
        coreDataStack.saveContext()
    }
    
    func fetchTrainings() throws -> Array<Training> {
        var array: Array<Training> = []
        let ponysCD = try coreDataStack.managedContext.fetch(TrainingCD.fetchRequest())
        ponysCD.forEach { CD in
            array.append(Training(id: Int(CD.tid), speed: CD.speed, distance: CD.distance, time: Int(CD.time), date: CD.date, uuid: CD.uuid))
        }
        return array
    }
    
    func editPony(_ pony: Pony) {
        do {
            let ponysCD = try coreDataStack.managedContext.fetch(PonyCD.fetchRequest())
            ponysCD.forEach { ponyCD in
                if ponyCD.ponyId == pony.ponyId {
                    ponyCD.name = pony.name
                    ponyCD.breed = pony.breed
                    ponyCD.age = pony.age
                    ponyCD.color = pony.color
                    ponyCD.height = pony.height
                    ponyCD.weight = pony.weight
                    ponyCD.personality = pony.personality
                    ponyCD.ponyId = pony.ponyId
                    ponyCD.ponyImageData = pony.ponyImageData
                    coreDataStack.saveContext()
                    return
                }
            }
        } catch let error as NSError {
            print("Unresolved error \(error), \(error.userInfo)")
        }
    }
    
    func deletePony(_ pony: Pony) throws {
        let ponys = try coreDataStack.managedContext.fetch(PonyCD.fetchRequest())
        let ponyCD = ponys.first(where: {$0.ponyId == pony.ponyId})
        guard let ponyCD = ponyCD else { return }
        coreDataStack.managedContext.delete(ponyCD)
        coreDataStack.saveContext()
    }
    
    func savePony(_ pony: Pony) {
        let ponyCD = PonyCD(context: coreDataStack.managedContext)
        ponyCD.name = pony.name
        ponyCD.breed = pony.breed
        ponyCD.age = pony.age
        ponyCD.color = pony.color
        ponyCD.height = pony.height
        ponyCD.weight = pony.weight
        ponyCD.personality = pony.personality
        ponyCD.ponyId = pony.ponyId
        ponyCD.ponyImageData = pony.ponyImageData
        coreDataStack.saveContext()
    }
    
    func fetchPonys() throws -> Array<Pony> {
        var array: Array<Pony> = []
        let ponysCD = try coreDataStack.managedContext.fetch(PonyCD.fetchRequest())
        ponysCD.forEach { CD in
            array.append(Pony(ponyId: CD.ponyId, ponyImageData: CD.ponyImageData, name: CD.name, breed: CD.breed, age: CD.age, color: CD.color, height: CD.height, weight: CD.weight, personality: CD.personality))
        }
        return array
    }
    
    func saveArticle(_ article: Article) {
        let articleCD = ArticleCD(context: coreDataStack.managedContext)
        articleCD.aId = article.id
        articleCD.image = article.image
        articleCD.name = article.name
        articleCD.descr = article.description
        coreDataStack.saveContext()
    }
    
    func fetchArticles() throws -> Array<Article> {
        var array: Array<Article> = []
        let articlesCD = try coreDataStack.managedContext.fetch(ArticleCD.fetchRequest())
        articlesCD.forEach { cd in
            array.append(Article(id: cd.aId, image: cd.image, name: cd.name, description: cd.descr))
        }
        return array
    }
    
    func deleteArticle(_ article: Article) throws {
        let articles = try coreDataStack.managedContext.fetch(ArticleCD.fetchRequest())
        let articleCD = articles.first(where: {$0.aId == article.id})
        guard let articleCD = articleCD else { return }
        coreDataStack.managedContext.delete(articleCD)
        coreDataStack.saveContext()
    }
}

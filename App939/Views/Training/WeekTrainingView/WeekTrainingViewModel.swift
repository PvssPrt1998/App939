import Foundation
import Combine

final class WeekTrainingViewModel: ObservableObject {
    
    let dm: DataController
    
    private var timeCancellable: AnyCancellable?
    
    init(dm: DataController) {
        self.dm = dm
        
        timeCancellable = dm.$dailyTrainingTime.sink { [weak self] _ in
            self?.objectWillChange.send()
        }
    }
    
    func getMonday() -> Date {
        var dValue: Double = 0
        var days: Double = 0
        var date = Date()
        while date.weekday() != 2 {
            days += 1
            dValue = days * 24 * 60 * 60
            date = date.addingTimeInterval(-dValue)
        }
        return date
    }
    
    func configure(_ date: Date) -> Int {
        var value = 0
        let date = dateToString(date)
        dm.trainings.forEach { training in
            if training.date == date {
                value += training.time
            }
        }
        return value
    }
    
    
    func getTuesday() -> Date {
        getMonday().addingTimeInterval(24 * 60 * 60)
    }
    func getWednesday() -> Date {
        getMonday().addingTimeInterval(2 * 24 * 60 * 60)
    }
    func getThursday() -> Date {
        getMonday().addingTimeInterval(3 * 24 * 60 * 60)
    }
    func getFriday() -> Date {
        getMonday().addingTimeInterval(4 * 24 * 60 * 60)
    }
    func getSaturday() -> Date {
        getMonday().addingTimeInterval(5 * 24 * 60 * 60)
    }
    func getSunday() -> Date {
        getMonday().addingTimeInterval(6 * 24 * 60 * 60)
    }
    
    func descriptionFor(_ date: Date) -> (String, String) {
        var day: String = ""
        var weekday: String = ""
        switch date.weekday() {
        case 1: weekday = "Sun"
        case 2: weekday = "Mon"
        case 3: weekday = "Tue"
        case 4: weekday = "Wed"
        case 5: weekday = "Thu"
        case 6: weekday = "Fri"
        case 7: weekday = "Sat"
        default: {}()
        }
        
        day = dateToString(date).components(separatedBy: "/")[2]

        return (day, weekday)
    }
    
    func isToday(_ date: Date) -> Bool {
        if dateToString(Date()).components(separatedBy: "/")[2] == dateToString(date).components(separatedBy: "/")[2] {
            return true
        } else {
            return false
        }
    }
    
    private func dateToString(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd"
        return dateFormatter.string(from: date)
    }
    
    private func stringToDate(_ str: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        dateFormatter.dateFormat = "dd.MM.yyyy"
        let date = dateFormatter.date(from: str)
        if let date = date {
            return date
        } else { return nil }
    }
}

extension Date {
    func weekday() -> Int {
        let timeZone = TimeZone(abbreviation: "UTC")
        let component =  Calendar.current.dateComponents(in: timeZone!, from: self)
        return component.weekday!
    }
}

enum Weekday: Int {
    case sunday = 1
    case monday
    case tuesday
    case wednesday
    case thursday
    case friday
    case saturday
}

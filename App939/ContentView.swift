
import SwiftUI

struct ContentView: View {
    
    @State var showSplash = true
    
    var body: some View {
        if showSplash {
            Splash(show: $showSplash, dataController: ViewModelFactory.shared.dataController)
        } else {
            Tab()
        }
    }
}

#Preview {
    ContentView()
}

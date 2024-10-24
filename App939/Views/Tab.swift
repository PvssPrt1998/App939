import SwiftUI

struct Tab: View {
    
    @State var selection: Int = 0
    
    init() {
        UITabBar.appearance().isHidden = true
    }
    
    var body: some View {
        ZStack {
            TabView(selection: $selection) {
                Home(viewModel: ViewModelFactory.shared.makeHomeViewModel())
                    .tag(0)
                ArticlesView().tag(1)
                TrainingView(viewModel: ViewModelFactory.shared.makeTrainingViewModeL()).tag(2)
                SettingsView(viewModel: ViewModelFactory.shared.makeSettingsViewModel()).tag(3)
            }
            tabBar
        }
        .onAppear {
            AppDelegate.orientationLock = .portrait
        }
    }
    
    private var tabBar: some View {
        HStack(spacing: 0) {
            tabItem(imageName: "house.fill", title: "Home", color: selection == 0 ? Color.primaryYellow : .white.opacity(0.2)) {
                    selection = 0
            }
            Spacer()
            tabItem(imageName: "book", title: "Articles", color: selection == 1 ? Color.primaryYellow : .white.opacity(0.2)) {
                        selection = 1
                }
            Spacer()
            tabItem(imageName: "dumbbell.fill", title: "My training", color: selection == 2 ? Color.primaryYellow : .white.opacity(0.2)) {selection = 2}
            Spacer()
            tabItem(imageName: "person.fill", title: "profile", color: selection == 3 ? Color.primaryYellow : .white.opacity(0.2)) {selection = 3}
        }
        .padding(.horizontal, 24)
        .frame(height: 68)
        .background(Color.bgMain)
        .clipShape(.rect(cornerRadius: 60))
        .overlay(RoundedRectangle(cornerRadius: 60).stroke(Color.white.opacity(0.15), lineWidth: 1))
        .padding(EdgeInsets(top: 0, leading: 16, bottom: 8, trailing: 16))
        .frame(maxHeight: .infinity, alignment: .bottom)
    }
    
    private func tabItem(imageName: String, title: String, color: Color, action: @escaping () -> Void) -> some View {
        VStack(spacing: 0) {
            Image(systemName: imageName)
                .resizable()
                .scaledToFit()
                .foregroundColor(color)
            Text(title)
                .font(.system(size: 10, weight: .medium))
                .foregroundColor(color)
                .frame(maxHeight: .infinity, alignment: .bottom)
        }
        .frame(height: 40)
        .onTapGesture {
            action()
        }
    }
}

#Preview {
    ZStack {
        Color.black
        Tab()
    }
}

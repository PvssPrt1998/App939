import SwiftUI

struct Splash: View {
    
    @State var isPortrait = UIDevice.current.orientation.isPortrait
    @Binding var show: Bool
    
    @State var rotationValue: CGFloat = 0
    let dataController: DataController
    
    var body: some View {
        ZStack {
            Image("LoadingBackground")
                .resizable()
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                Image("Logo")
                    .resizable()
                    .scaledToFit()
                    .frame(maxHeight: 191)
                    .padding(.top, 64)
                (
                    Text("Create your own\n")
                        .font(.largeTitle.bold())
                        .foregroundColor(.white)
                    + Text("path to victory")
                        .font(.largeTitle.bold())
                        .foregroundColor(.primaryYellow)
                )
                .padding(.top, 10)
            }
            .frame(maxHeight: .infinity, alignment: .top)
            .padding(.horizontal, 15)
            
            VStack(spacing: 0) {
                Spacer()
                Spacer()
                Spacer()
                Spacer()
                ZStack {
                    Button {
                        withAnimation {
                            show = false
                        }
                    } label: {
                        Image(systemName: "arrow.right")
                            .resizable()
                            .scaledToFit()
                            .foregroundColor(.white)
                            .padding(EdgeInsets(top: 25, leading: 21, bottom: 25, trailing: 21))
                            .frame(width: 80, height: 80)
                    }
                    Circle()
                        .trim(from: 0, to: 0.6)
                        .stroke(Color.primaryYellow, style: StrokeStyle(lineWidth: 8, lineCap: .round))
                        .rotationEffect(.degrees(-90))
                        .frame(height: 122)
                        .rotationEffect(.degrees(rotationValue))
                }
                .padding(.leading, isPortrait ? 0 : UIScreen.main.bounds.width * 0.6)
                .frame(maxWidth: .infinity)
                .onReceive(NotificationCenter.default.publisher(for: UIDevice.orientationDidChangeNotification)) { _ in
                                guard let scene = UIApplication.shared.windows.first?.windowScene else { return }
                                self.isPortrait = scene.interfaceOrientation.isPortrait
                            }
                Spacer()
            }
            
        }
        .onAppear {
            dataController.load()
            withAnimation(.linear(duration: 1).repeatForever(autoreverses: false)) {
                rotationValue = 360
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                show = false
            }
        }
    }
}

struct Splash_Preview: PreviewProvider {
    
    @State static var show = true
    
    static var previews: some View {
        Splash(show: $show, dataController: DataController())
    }
    
}

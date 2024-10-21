import SwiftUI

struct Splash: View {
    
    @Binding var show: Bool
    
    @State var rotationValue: CGFloat = 0
    let dataController: DataController
    
    var body: some View {
        ZStack {
            Image("LoadingBackground")
                .resizable()
                .ignoresSafeArea()
            Color.black
                .opacity(0.4)
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                Spacer()
                Text("Create a detailed record of your pony's exercises")
                    .font(.largeTitle.bold())
                    .foregroundColor(.white)
                Spacer()
                Spacer()
                Spacer()
                Spacer()
                Spacer()
            }
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

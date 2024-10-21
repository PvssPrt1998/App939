import SwiftUI
import Combine

struct KartInfoView: View {
    
    @ObservedObject var viewModel: KartInfoViewModel = ViewModelFactory.shared.makeKartInfoViewModel()
    
    var body: some View {
        ZStack {
            if let imageData = viewModel.kartData?.image,
               let image = UIImage(data: imageData) {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
                    .frame(width: UIScreen.main.bounds.width, height: 320)
                    .clipped()
            } else {
                Image(systemName: "person.fill")
                    .resizable()
                    .scaledToFill()
                    .foregroundColor(.white)
                    .clipped()
                    .frame(width: UIScreen.main.bounds.width, height: 320)
                    .clipped()
            }
            LinearGradient(colors: [.basicGradient1, .basicGradient2], startPoint: .top, endPoint: .bottom)
                .frame(height: 320)
                .overlay(
                    VStack(spacing: 4) {
                        Text(viewModel.kartData?.name ?? "")
                            .font(.title.bold())
                            .lineLimit(1)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Text(viewModel.kartData?.address ?? "")
                            .font(.callout)
                            .lineLimit(1)
                            .foregroundColor(.c244248255)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .padding(EdgeInsets(top: 0, leading: 16, bottom: 40, trailing: 16))
                    ,alignment: .bottom
                )
            
        }
    }

}

#Preview {
    KartInfoView()
}

final class KartInfoViewModel: ObservableObject {
    
    let dm: DataController
    
    @Published var kartData: Kart?
    
    private var kartDataCancellable: AnyCancellable?
    
    init(dm: DataController) {
        self.dm = dm
        kartDataCancellable = dm.$kart.sink { [weak self] value in
            self?.kartData = value
        }
    }
    
}

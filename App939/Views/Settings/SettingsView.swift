import SwiftUI
import Combine
import StoreKit

struct SettingsView: View {
    
    @Environment(\.openURL) var openURL
    
    @State var showAlert = false
    @ObservedObject var viewModel: SettingsViewModel
    
    var body: some View {
        ZStack {
            Color.bgMain.ignoresSafeArea()
            
            VStack(spacing: 0) {
                ProfileImageView(imageData: $viewModel.imageData, image: setImage())
                    .padding(.top, 24)
                dailyTrainingTime
                    .padding(.top, 24)
                settingsButtons
                    .padding(.top, 40)
            }
            .padding(.horizontal, 15)
            .frame(maxHeight: .infinity, alignment: .top)
            
            if showAlert {
                CustomAlert(text: $viewModel.alertText, title: "Time for daily training", subtitle: "Enter a time plan for your daily workouts") {
                    viewModel.saveAlert()
                    withAnimation {
                        showAlert = false
                    }
                } close: {
                    withAnimation {
                        showAlert = false
                    }
                }

            }
            
        }
    }
    
    private var dailyTrainingTime: some View {
        VStack(spacing: 12) {
            HStack {
                Text("TIME FOR DAILY TRAINING")
                    .font(.system(size: 17, weight: .regular))
                    .foregroundColor(.white)
                
                Spacer()
                Button {
                    withAnimation {
                        showAlert = true
                    }
                   
                } label: {
                    Image(systemName: "square.and.pencil")
                        .font(.system(size: 24, weight: .regular))
                        .foregroundColor(.primaryYellow)
                }
            }
            Text("\(viewModel.time)")
                .font(.system(size: 50, weight: .regular))
                .foregroundColor(.white)
        }
        .padding(EdgeInsets(top: 12, leading: 12, bottom: 8, trailing: 12))
        .background(Color.white.opacity(0.05))
        .clipShape(.rect(cornerRadius: 24))
        
    }
    private var settingsButtons: some View {
        VStack(spacing: 20) {
            Button {
                actionSheet()
            } label: {
                HStack(spacing: 4) {
                    Image(systemName: "square.and.arrow.up.fill")
                        .font(.system(size: 20, weight: .regular))
                        .foregroundColor(.white)
                    Text("Share app")
                        .font(.subheadline.weight(.semibold))
                        .foregroundColor(.white)
                    Spacer()
                    Image(systemName: "chevron.right")
                        .font(.system(size: 20, weight: .regular))
                        .foregroundColor(.white)
                }
                .frame(maxHeight: .infinity)
                .padding(.horizontal, 15)
                .frame(height: 60)
                .background(Color.white.opacity(0.2))
                .clipShape(.rect(cornerRadius: 62))
            }
            Button {
                SKStoreReviewController.requestReviewInCurrentScene()
            } label: {
                HStack(spacing: 4) {
                    Image(systemName: "star.fill")
                        .font(.system(size: 20, weight: .regular))
                        .foregroundColor(.white)
                    Text("Rate Us")
                        .font(.subheadline.weight(.semibold))
                        .foregroundColor(.white)
                    Spacer()
                    Image(systemName: "chevron.right")
                        .font(.system(size: 20, weight: .regular))
                        .foregroundColor(.white)
                }
                .frame(maxHeight: .infinity)
                .padding(.horizontal, 15)
                .frame(height: 60)
                .background(Color.white.opacity(0.2))
                .clipShape(.rect(cornerRadius: 62))
            }
            Button {
                if let url = URL(string: "https://www.termsfeed.com/live/88234dfa-a486-4178-bf20-b8e2e702cad4") {
                    openURL(url)
                }
            } label: {
                HStack(spacing: 4) {
                    Image(systemName: "doc.text.fill")
                        .font(.system(size: 20, weight: .regular))
                        .foregroundColor(.white)
                    Text("Usage Policy")
                        .font(.subheadline.weight(.semibold))
                        .foregroundColor(.white)
                    Spacer()
                    Image(systemName: "chevron.right")
                        .font(.system(size: 20, weight: .regular))
                        .foregroundColor(.white)
                }
                .frame(maxHeight: .infinity)
                .padding(.horizontal, 15)
                .frame(height: 60)
                .background(Color.white.opacity(0.2))
                .clipShape(.rect(cornerRadius: 62))
            }
            
            
        }
    }
    
    private func setImage() -> Image? {
        guard let imageData = viewModel.imageData,
                let image = UIImage(data: imageData) else {
            return nil
        }
        return Image(uiImage: image)
    }
    
    func actionSheet() {
        guard let urlShare = URL(string: "https://apps.apple.com/us/app/bari-match-pony-ride-tracker/id6737126380")  else { return }
        let activityVC = UIActivityViewController(activityItems: [urlShare], applicationActivities: nil)
        if #available(iOS 15.0, *) {
            UIApplication
            .shared
            .connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .flatMap { $0.windows }
            .first { $0.isKeyWindow }?.rootViewController?
            .present(activityVC, animated: true, completion: nil)
        } else {
            UIApplication.shared.windows.first?.rootViewController?.present(activityVC, animated: true, completion: nil)
        }
        
    }
}

#Preview {
    SettingsView(viewModel: SettingsViewModel(dm: DataController()))
}

final class SettingsViewModel: ObservableObject {
    
    let dm: DataController
    
    @Published var time: Int = 30
    
    @Published var alertText = ""
    
    @Published var imageData: Data? {
        didSet {
            if imageData != oldValue && imageData != nil {
                saveImage()
            }
        }
    }
    private var imageCancellable: AnyCancellable?
    private var timeCancellable: AnyCancellable?
    
    init(dm: DataController) {
        self.dm = dm
        
        self.imageData = dm.profilePicture
        self.time = dm.dailyTrainingTime
        
        imageCancellable = dm.$profilePicture.sink { [weak self] value in
            self?.imageData = value
        }
        timeCancellable = dm.$dailyTrainingTime.sink { [weak self] value in
            self?.time = value
        }
    }
    
    func saveAlert() {
        if let value = Int(alertText) {
            dm.saveDailyTrainingTime(value)
        }
        alertText = ""
    }
    
    func saveImage() {
        guard let imageData = imageData else { return }
        dm.saveProfilePicture(imageData)
    }
    
}

extension SKStoreReviewController {
    public static func requestReviewInCurrentScene() {
        if let scene = UIApplication.shared.connectedScenes.first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene {
            DispatchQueue.main.async {
                requestReview(in: scene)
            }
        }
    }
}

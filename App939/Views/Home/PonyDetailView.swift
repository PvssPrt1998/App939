

import SwiftUI
import Combine

struct PonyDetailView: View {
    
    @ObservedObject var viewModel: PonyDetailViewModel
    
    @Binding var showPonyDetail: Bool
    @State var showDeleteAlert: Bool = false
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.bgMain.ignoresSafeArea()
                VStack {
                    if 
                       let image = UIImage(data: viewModel.pony.ponyImageData) {
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFill()
                            .clipped()
                            .frame(width: UIScreen.main.bounds.width, height: 252)
                            .clipped()
                            .overlay(LinearGradient(colors: [.basicGradient1, .basicGradient2], startPoint: .top, endPoint: .bottom))
                            .overlay(ponyDetailHeader)
                    } else {
                        Image(systemName: "person.fill")
                            .resizable()
                            .scaledToFill()
                            .foregroundColor(.white)
                            .clipped()
                            .frame(width: UIScreen.main.bounds.width, height: 252)
                            .clipped()
                    }
                        
                    VStack(spacing: 22) {
                        Text(viewModel.pony.personality)
                            .font(.body)
                            .foregroundColor(.white)
                            .multilineTextAlignment(.leading)
                            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                            .padding(EdgeInsets(top: 14, leading: 16, bottom: 14, trailing: 16))
                            .frame(width: 330, height: 93)
                            .background(Color.white.opacity(0.1))
                            .clipShape(.rect(cornerRadius: 6))
                        
                        HStack {
                            Image("ponyIcon")
                                .resizable()
                                .scaledToFit()
                                .frame(maxWidth: 247, maxHeight: 247)
                            Text(viewModel.pony.height)
                                .font(.body)
                                .foregroundColor(.white)
                            Image("Arrow")
                                .resizable()
                                .scaledToFit()
                        }
                        .frame(maxHeight: 284)
                        .padding(.horizontal, 30)
                    }
                    .padding(.top, 22)
                }
                .frame(maxHeight: .infinity, alignment: .top)
                VStack(spacing: 0) {
                    RoundedRectangle(cornerRadius: 19)
                        .fill(Color.c60606703)
                        .frame(width: 36, height: 5)
                        .padding(.vertical, 10)
                    HStack(spacing: 0) {
                        Button {
                            showPonyDetail = false
                        } label: {
                            HStack(spacing: 3) {
                                Image(systemName: "chevron.left")
                                    .font(.system(size: 17, weight: .semibold))
                                    .foregroundColor(.primaryYellow)
                                
                                Text("Back")
                                    .font(.system(size: 17, weight: .regular))
                                    .foregroundColor(.primaryYellow)
                            }
                            .padding(.horizontal, 8)
                        }
                        
                        Spacer()
                        
                        HStack(spacing: 16) {
                            NavigationLink {
                                EditPonyView(viewModel: ViewModelFactory.shared.makeEditPonyViewModel(viewModel.pony))
                            } label: {
                                Image(systemName: "pencil")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 22, height: 22)
                                    .foregroundColor(.primaryYellow)
                            }
                            Button {
                                withAnimation {
                                    showDeleteAlert = true
                                }
                            } label: {
                                Image(systemName: "trash")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 24, height: 22)
                                    .foregroundColor(.primaryYellow)
                                .padding(.trailing, 16)
                            }
                            .alert(isPresented: $showDeleteAlert) {
                                Alert(title: Text("Delete"), message: Text("Do you really want to delete this?"), primaryButton: .default(Text("Delete"), action: {
                                    viewModel.deletePony()
                                    showPonyDetail = false
                                }), secondaryButton: .destructive(Text("Close")))
                            }
                        }
                    }
                    .overlay(
                        Text(viewModel.pony.name)
                            .font(.system(size: 17, weight: .semibold))
                            .foregroundColor(.white)
                    )
                }
                .frame(maxHeight: .infinity, alignment: .top)
            }
        }
    }
    
    var ponyDetailHeader: some View {
        VStack(spacing: 22) {
            Text(viewModel.pony.breed)
                .font(.title2)
                .foregroundColor(.white)
            HStack(spacing: 0) {
                Text(viewModel.pony.age)
                    .font(.body)
                    .foregroundColor(.white)
                    .lineLimit(2)
                    .frame(width: 84, height: 84)
                    .background(Color.white.opacity(0.1))
                    .clipShape(.circle)
                    .frame(maxWidth: .infinity)
                Text(viewModel.pony.weight)
                    .font(.body)
                    .foregroundColor(.white)
                    .lineLimit(2)
                    .frame(width: 84, height: 84)
                    .background(Color.white.opacity(0.1))
                    .clipShape(.circle)
                    .frame(maxWidth: .infinity)
                Text(viewModel.pony.color)
                    .font(.body)
                    .foregroundColor(.white)
                    .lineLimit(2)
                    .frame(width: 84, height: 84)
                    .background(Color.white.opacity(0.1))
                    .clipShape(.circle)
                    .frame(maxWidth: .infinity)
            }
            .frame(maxWidth: 335)
            .padding(.horizontal, 27)
        }
        .padding(.top, 82)
    }
}

final class PonyDetailViewModel: ObservableObject {
    
    let dm: DataController
    var pony: Pony
    
    private var ponysCancellable: AnyCancellable?
    
    init(dm: DataController, pony: Pony) {
        self.dm = dm
        self.pony = pony
        ponysCancellable = dm.$ponys.sink { [weak self] value in
            dm.ponys.forEach { dmPony in
                if dmPony.ponyId == pony.ponyId {
                    self?.pony = dmPony
                    return
                }
            }
        }
    }
    
    func deletePony() {
        dm.deletePony(pony)
    }
}

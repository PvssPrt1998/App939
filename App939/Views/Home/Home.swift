import SwiftUI

struct Home: View {
    
    @ObservedObject var viewModel: HomeViewModel
    
    @Environment(\.safeAreaInsets) private var safeAreaInsets
    
    @State var showKartSheet: Bool = false
    @State var showAddPonySheet: Bool = false
    @State var showPonyDetail: Bool = false
    
    var body: some View {
        ZStack {
            Color.c474747.ignoresSafeArea()
            
            if viewModel.kartData == nil {
                EmptyPhotoView(showKartSheet: $showKartSheet)
                    .padding(.top, 40)
                    .frame(maxHeight: .infinity, alignment: .top)
            } else {
                KartInfoView()
                    .ignoresSafeArea()
                    .frame(maxHeight: .infinity, alignment: .top)
            }
            
            sheetView
                .overlay(sheetOverlay)
                .overlay(grabber, alignment: .top)
                .padding(.top, 297)
                .ignoresSafeArea()
            
            if !viewModel.ponys.isEmpty {
                Button {
                    showAddPonySheet = true
                } label: {
                    Text("Add a pony")
                        .font(.body)
                        .foregroundColor(.black)
                        .frame(width: 286, height: 50)
                        .background(Color.primaryYellow)
                        .clipShape(.rect(cornerRadius: 10))
                }
                .padding(.bottom, 84)
                .frame(maxHeight: .infinity, alignment: .bottom)
            }
        }
        .sheet(isPresented: $showKartSheet) {
            AddKartView(showKartSheet: $showKartSheet)
        }
        .sheet(isPresented: $showAddPonySheet) {
            AddPonyView(showAddPonySheet: $showAddPonySheet)
        }
        .sheet(isPresented: $showPonyDetail) {
            PonyDetailView(viewModel: ViewModelFactory.shared.makePonyDetailViewModel(viewModel.ponyForShow!), showPonyDetail: $showPonyDetail)
        }
    }
}

#Preview {
    Home(viewModel: ViewModelFactory.shared.makeHomeViewModel())
}

extension Home {
    @ViewBuilder var sheetOverlay: some View {
        if viewModel.ponys.isEmpty {
            emptyContent.padding(.horizontal, 16)
        } else {
            ponyCollection.padding(.horizontal, 16)
        }
    }

    private var sheetView: some View {
        ZStack {
            Color.bgMain.ignoresSafeArea()
        }
        .cornerRadius(20, corners: [.topLeft, .topRight])
    }
    private var grabber: some View {
        RoundedRectangle(cornerRadius: 19)
            .fill(Color.c244248255012)
            .frame(width: 40, height: 5)
            .padding(.top, 15)
    }
    private var emptyContent: some View {
        VStack(spacing: 12) {
            Text("My pony")
                .font(.title2.bold())
                .foregroundColor(.white)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            emptyCollection
        }
        .padding(.top, 40)
        .overlay(emptyAdd)
        .frame(maxHeight: .infinity, alignment: .top)
        .ignoresSafeArea()
    }
    private var emptyCollection: some View {
        VStack(spacing: 12) {
            HStack(spacing: 12) {
                RoundedRectangle(cornerRadius: 12)
                    .fill(.white.opacity(0.05))
                    .frame(height: 242)
                RoundedRectangle(cornerRadius: 12)
                    .fill(.white.opacity(0.05))
                    .frame(height: 242)
            }
            HStack(spacing: 12) {
                RoundedRectangle(cornerRadius: 12)
                    .fill(.white.opacity(0.05))
                RoundedRectangle(cornerRadius: 12)
                    .fill(.white.opacity(0.05))
            }
        }
        .frame(maxHeight: .infinity, alignment: .top)
    }
    private var emptyAdd: some View {
        VStack(spacing: 17) {
            VStack(spacing: 4) {
                Text("Add pony")
                    .font(.title.bold())
                    .foregroundColor(.white)
                Text("Hippodrome management")
                    .font(.callout)
                    .foregroundColor(.c244248255)
            }
            
            Button {
                showAddPonySheet = true
            } label: {
                Text("Add a pony")
                    .font(.subheadline.weight(.regular))
                    .foregroundColor(.black)
                    .padding(EdgeInsets(top: 7, leading: 14, bottom: 7, trailing: 14))
                    .background(Color.primaryYellow)
                    .clipShape(.rect(cornerRadius: 10))
            }
        }
    }

    private var sheetGrabber: some View {
        RoundedRectangle(cornerRadius: 19)
            .fill(Color.c60606703)
            .frame(width: 36, height: 5)
            .padding(.vertical, 10)
    }
    
    private var ponyCollection: some View {
        ScrollView(.vertical, showsIndicators: false) {
            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 12) {
                ForEach(viewModel.ponys, id: \.self) { pony in
                    ponyCard(pony).onTapGesture {
                        viewModel.ponyForShow = pony
                        showPonyDetail = true
                    }
                }
            }
            .padding(.bottom, 142 + safeAreaInsets.bottom)
        }
        .padding(.top, 40)
    }
    
    private func ponyCard(_ pony: Pony) -> some View {
        VStack(spacing: 8) {
            setPonyImage(pony.ponyImageData)
                .clipShape(.rect(cornerRadius: 8))
            VStack(spacing: 16) {
                Text(pony.name)
                    .font(.subheadline.weight(.semibold))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, alignment: .leading)
                VStack(spacing: 8) {
                    HStack(spacing: 0) {
                        Text("Age")
                            .font(.caption)
                            .foregroundColor(.c244248255)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Text(pony.age)
                            .font(.caption)
                            .foregroundColor(.c2442482551)
                    }
                    HStack(spacing: 0) {
                        Text("Weight")
                            .font(.caption)
                            .foregroundColor(.c244248255)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Text(pony.weight)
                            .font(.caption)
                            .foregroundColor(.c2442482551)
                    }
                }
            }
            .padding(.horizontal, 6)
        }
        .padding(EdgeInsets(top: 6, leading: 6, bottom: 12, trailing: 6))
        .background(Color.white.opacity(0.05))
        .clipShape(.rect(cornerRadius: 12))
    }
    
    @ViewBuilder private func setPonyImage(_ imageData: Data?) -> some View {
        if let imageData = imageData,
           let image = UIImage(data: imageData) {
            Image(uiImage: image)
                .resizable()
                .scaledToFit()
                .background(Color.white)
        } else {
            Image(systemName: "person.fill")
                .resizable()
                .scaledToFit()
                .background(Color.white)
        }
    }

}

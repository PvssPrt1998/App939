import SwiftUI

struct ArticleDetail: View {
    
    @ObservedObject var viewModel: ArticleDetailViewModel
    let back: () -> Void
    
    @State var showDeleteAlert: Bool = false
    
    var body: some View {
        ZStack {
            Color.bgMain.ignoresSafeArea()
            VStack(spacing: 22) {
                setupImage()
                
                ScrollView(.vertical) {
                    Text(viewModel.article.description)
                        .font(.body)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .multilineTextAlignment(.leading)
                        .padding(EdgeInsets(top: 11, leading: 16, bottom: 11, trailing: 16))
                        .background(Color.white.opacity(0.1))
                        .clipShape(.rect(cornerRadius: 6))
                        .padding(.horizontal, 30)
                        .padding(.bottom, 50)
                }
                .ignoresSafeArea()
            }
            .frame(maxHeight: .infinity, alignment: .top)
            .ignoresSafeArea()
        }
    }
    private var nav: some View {
        VStack(spacing: 0) {
            RoundedRectangle(cornerRadius: 19)
                .fill(Color.c60606703)
                .frame(width: 36, height: 5)
                .padding(.vertical, 10)
            ZStack {
                HStack(spacing: 0) {
                    Button {
                        back()
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
                    Text("Useful")
                        .font(.system(size: 17, weight: .semibold))
                        .foregroundColor(.white)
                    Spacer()
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
                            viewModel.deleteArticle()
                            back()
                        }), secondaryButton: .destructive(Text("Close")))
                    }
                }
                
                
                
            }
        }
    }
    
    @ViewBuilder private func setupImage() -> some View {
        if
            let image = UIImage(data: viewModel.article.image) {
            Image(uiImage: image)
                .resizable()
                .scaledToFill()
                .clipped()
                .frame(width: UIScreen.main.bounds.width, height: 252)
                .clipped()
                .overlay(LinearGradient(colors: [.basicGradient1, .basicGradient2], startPoint: .top, endPoint: .bottom))
                .overlay(
                    Text(viewModel.article.name)
                        .font(.title2.bold())
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 32)
                        .padding(.top, 100)
                )
                .overlay(nav, alignment: .top)
                .ignoresSafeArea()
        } else {
            Image(systemName: "person.fill")
                .resizable()
                .scaledToFill()
                .foregroundColor(.white)
                .clipped()
                .frame(width: UIScreen.main.bounds.width, height: 252)
                .clipped()
        }
    }
    
}

final class ArticleDetailViewModel: ObservableObject {
    
    let dm: DataController
    
    let article: Article
    
    init(dm: DataController, article: Article) {
        self.dm = dm
        self.article = article
    }
    
    func deleteArticle() {
        dm.deleteArticle(article)
    }
}

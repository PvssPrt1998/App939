import SwiftUI

struct ArticlesView: View {
    
    @ObservedObject var viewModel: ArticlesViewModel = ViewModelFactory.shared.makeArticlesViewModel()
    
    @State var selection = 0
    @State var showUsefulDetail = false
    @State var showArticleDetail = false
    @State var showAddArticle = false
    
    init() {
        UISegmentedControl.appearance().selectedSegmentTintColor = .primaryYellow
        UISegmentedControl.appearance().backgroundColor = UIColor(Color.c118118128.opacity(0.24))
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.black], for: .selected)
            UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.white], for: .normal)
    }
    
    var body: some View {
        ZStack {
            Color.bgMain.ignoresSafeArea()
            VStack(spacing: 20) {
                Text("Articles")
                    .font(.system(size: 34, weight: .bold))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(EdgeInsets(top: 3, leading: 0, bottom: 8, trailing: 0))
                    .padding(.top, 44)
                Picker("",selection: $selection) {
                    Text("Useful").tag(0)
                    Text("My articles").tag(1)
                }
                .pickerStyle(.segmented)
                
                if selection == 0 {
                    ScrollView(.vertical, showsIndicators: false) {
                        LazyVStack(spacing: 16) {
                            ForEach(viewModel.usefulArticles, id: \.self) { article in
                                usefulCard(article)
                                    .onTapGesture {
                                        viewModel.usefulArticleForShow = article
                                        showUsefulDetail = true
                                    }
                            }
                        }
                        .padding(.bottom, 82)
                    }
                } else {
                    if viewModel.articles.isEmpty {
                        emptyArticles
                    } else {
                        ScrollView(.vertical, showsIndicators: false) {
                            LazyVStack(spacing: 16) {
                                ForEach(viewModel.articles, id: \.self) { article in
                                    articleCard(article)
                                        .onTapGesture {
                                            viewModel.articleForShow = article
                                            showArticleDetail = true
                                        }
                                }
                            }
                            .padding(.bottom, 82)
                        }
                    }
                }
            }
            .padding(.horizontal, 16)
            .frame(maxHeight: .infinity, alignment: .top)
        }
        .sheet(isPresented: $showUsefulDetail) {
            UsefulDetail(article: viewModel.usefulArticleForShow!) {
                showUsefulDetail = false
            }
        }
        .sheet(isPresented: $showAddArticle) {
            AddArticleView(showAddArticle: $showAddArticle)
        }
        .sheet(isPresented: $showArticleDetail) {
            articleDetail
        }
    }

    private func usefulCard(_ article: UsefulArticle) -> some View {
        ZStack {
            Image(article.imageName)
                .resizable()
                .scaledToFill()
                .clipped()
                .overlay(Color.black.opacity(0.55))
                .clipShape(.rect(cornerRadius: 6))
            
            Text(article.name)
                .font(.title2.bold())
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 52)
            
            Image(systemName: "arrow.right")
                .resizable()
                .scaledToFit()
                .frame(width: 33, height: 27)
                .foregroundColor(.white)
                .padding(12)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
        }
        .frame(height: 163)
        .frame(maxWidth: .infinity)
    }
    private func articleCard(_ article: Article) -> some View {
        ZStack {
            setArticleImage(article.image)
           
            Text(article.name)
                .font(.title2.bold())
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 52)
            
            Image(systemName: "arrow.right")
                .resizable()
                .scaledToFit()
                .frame(width: 33, height: 27)
                .foregroundColor(.white)
                .padding(12)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
        }
        .frame(height: 163)
        .frame(maxWidth: .infinity)
    }
    @ViewBuilder private func setArticleImage(_ imageData: Data?) -> some View {
        if let imageData = imageData,
           let image = UIImage(data: imageData) {
            Image(uiImage: image)
                .resizable()
                .scaledToFill()
                .overlay(Color.black.opacity(0.55))
                .frame(height: 163)
                .clipped()
                .clipShape(.rect(cornerRadius: 6))
            
        } else {
            Image(systemName: "person.fill")
                .resizable()
                .scaledToFill()
                .clipped()
                .overlay(Color.black.opacity(0.55))
                .clipShape(.rect(cornerRadius: 6))
        }
    }
    private var emptyArticles: some View {
        VStack(spacing: 16) {
            RoundedRectangle(cornerRadius: 6)
                .fill(Color.c166166166.opacity(0.04))
            RoundedRectangle(cornerRadius: 6)
                .fill(Color.c166166166.opacity(0.04))
            RoundedRectangle(cornerRadius: 6)
                .fill(Color.c166166166.opacity(0.04))
        }
        .overlay(
            VStack(spacing: 17) {
                VStack(spacing: 4) {
                    Text("Add your articles")
                        .font(.title.bold())
                        .foregroundColor(.white)
                    Text("Write your own articles")
                        .font(.callout)
                        .foregroundColor(.c244248255)
                }
                
                Button {
                    showAddArticle = true
                } label: {
                    Text("Add articles")
                        .font(.subheadline.weight(.regular))
                        .foregroundColor(.black)
                        .padding(EdgeInsets(top: 7, leading: 14, bottom: 7, trailing: 14))
                        .background(Color.primaryYellow)
                        .clipShape(.rect(cornerRadius: 10))
                }
            }
        )
        .padding(.bottom, 82)
    }
    private var articleDetail: some View {
        ArticleDetail(viewModel: ViewModelFactory.shared.makeArticleDetailViewModel(viewModel.articleForShow!), back: {showArticleDetail = false})
    }
}

#Preview {
    ArticlesView()
}

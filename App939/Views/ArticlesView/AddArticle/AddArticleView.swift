import SwiftUI

struct AddArticleView: View {
    
    @ObservedObject var viewModel: AddArticleViewModel = ViewModelFactory.shared.makeAddArticleViewModel()
    
    @Binding var showAddArticle: Bool
    
    var body: some View {
        ZStack {
            Color.bgMain.ignoresSafeArea()
            VStack(spacing: 0) {
                RoundedRectangle(cornerRadius: 19)
                    .fill(Color.c60606703)
                    .frame(width: 36, height: 5)
                    .padding(.vertical, 10)
                HStack(spacing: 0) {
                    Button {
                        showAddArticle = false
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
                    
                    Button {
                        viewModel.articleSave()
                        showAddArticle = false
                    } label: {
                        Text("Save")
                            .font(.system(size: 17, weight: viewModel.articleDisabled ? .regular : .semibold))
                            .foregroundColor(viewModel.articleDisabled ? .c244248255012 : .primaryYellow)
                        .padding(.horizontal, 16)
                    }
                    .disabled(viewModel.articleDisabled)
                }
                .overlay(
                    Text("New article")
                        .font(.system(size: 17, weight: .semibold))
                        .foregroundColor(.white)
                )
                ScrollView(.vertical) {
                    VStack(spacing: 20) {
                        ImageView(imageData: $viewModel.image)
                        VStack(spacing: 16) {
                            VStack(spacing: 8) {
                                Text("Name")
                                    .font(.footnote)
                                    .foregroundColor(.white.opacity(0.7))
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                AddTextField(text: $viewModel.name, placeholder: "Enter name")
                            }
                            VStack(spacing: 8) {
                                Text("Description")
                                    .font(.footnote)
                                    .foregroundColor(.white.opacity(0.7))
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                if #available(iOS 16.0, *) {
                                    TextEditor(text: $viewModel.articleText)
                                        .foregroundColor(.white)
                                        .scrollContentBackground(.hidden)
                                        .background(
                                            placeholderView(isShow: viewModel.articleText == "")
                                        )
                                        .padding(EdgeInsets(top: 12, leading: 13, bottom: 12, trailing: 13))
                                        .background(Color.white.opacity(0.05))
                                        .clipShape(.rect(cornerRadius: 12))
                                        .frame(height: 115)
                                        .padding(.top, 12)
                                } else {
                                    TextEditor(text: $viewModel.articleText)
                                        .foregroundColor(.white)
                                        .background(
                                            placeholderView(isShow: viewModel.articleText == "")
                                        )
                                        .padding(EdgeInsets(top: 12, leading: 13, bottom: 12, trailing: 13))
                                        .background(Color.white.opacity(0.05))
                                        .clipShape(.rect(cornerRadius: 12))
                                        .frame(height: 115)
                                        .padding(EdgeInsets(top: 12, leading: 16, bottom: 0, trailing: 16))
                                }
                            }
                        }
                        .padding(EdgeInsets(top: 20, leading: 16, bottom: 20, trailing: 16))
                    }
                }
                .padding(.top, 40)
            }
            .frame(maxHeight: .infinity, alignment: .top)
        }
    }
    
    func placeholderView(isShow: Bool) -> some View {
        Text(isShow ? "Write your article" : "")
            .font(.body)
            .foregroundColor(.white.opacity(0.3))
            .padding(EdgeInsets(top: 8, leading: 4, bottom: 0, trailing: 0))
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
    }
}

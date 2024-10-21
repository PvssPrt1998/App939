import SwiftUI

struct AddKartView: View {
    
    @ObservedObject var viewModel: AddKartViewModel = ViewModelFactory.shared.makeAddKartViewModel()
    
    @Binding var showKartSheet: Bool
    
    var body: some View {
        ZStack {
            Color.bgMain.ignoresSafeArea()
            
            ScrollView(.vertical,showsIndicators: false) {
                VStack(spacing: 0) {
                    RoundedRectangle(cornerRadius: 19)
                        .fill(Color.c60606703)
                        .frame(width: 36, height: 5)
                        .padding(.vertical, 10)
                    HStack(spacing: 0) {
                        Button {
                            showKartSheet = false
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
                            viewModel.basicSave()
                            showKartSheet = false
                        } label: {
                            Text("Save")
                                .font(.system(size: 17, weight: viewModel.addBasicDisabled ? .regular : .semibold))
                                .foregroundColor(viewModel.addBasicDisabled ? .c244248255012 : .primaryYellow)
                            .padding(.horizontal, 16)
                        }
                        .disabled(viewModel.addBasicDisabled)
                    }
                    .overlay(
                        Text("Edit basic information")
                            .font(.system(size: 17, weight: .semibold))
                            .foregroundColor(.white)
                    )
                    VStack(spacing: 20) {
                        ImageView(imageData: $viewModel.imageData)
                        VStack(spacing: 16) {
                            VStack(spacing: 8) {
                                Text("Name")
                                    .font(.footnote)
                                    .foregroundColor(.white.opacity(0.7))
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                AddTextField(text: $viewModel.basicName, placeholder: "Enter name")
                            }
                            VStack(spacing: 8) {
                                Text("Address")
                                    .font(.footnote)
                                    .foregroundColor(.white.opacity(0.7))
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                AddTextField(text: $viewModel.basicAddress, placeholder: "Enter address")
                            }
                        }
                        .padding(EdgeInsets(top: 20, leading: 16, bottom: 20, trailing: 16))
                    }
                    .padding(.top, 40)
                }
                //.frame(maxHeight: .infinity, alignment: .top)
            }
            
        }
    }
}

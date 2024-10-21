import SwiftUI

struct AddPonyView: View {
    
    @ObservedObject var viewModel: AddPonyViewModel = ViewModelFactory.shared.makeAddPonyViewModel()
    
    @Binding var showAddPonySheet: Bool
    
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
                        showAddPonySheet = false
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
                        viewModel.ponySave()
                        showAddPonySheet = false
                    } label: {
                        Text("Save")
                            .font(.system(size: 17, weight: viewModel.addPonyDisabled ? .regular : .semibold))
                            .foregroundColor(viewModel.addPonyDisabled ? .c244248255012 : .primaryYellow)
                        .padding(.horizontal, 16)
                    }
                    .disabled(viewModel.addPonyDisabled)
                }
                .overlay(
                    Text("New pony")
                        .font(.system(size: 17, weight: .semibold))
                        .foregroundColor(.white)
                )
                ScrollView(.vertical) {
                    VStack(spacing: 20) {
                        ImageView(imageData: $viewModel.ponyImageData)
                        VStack(spacing: 16) {
                            VStack(spacing: 8) {
                                Text("Name")
                                    .font(.footnote)
                                    .foregroundColor(.white.opacity(0.7))
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                AddTextField(text: $viewModel.name, placeholder: "Enter name")
                            }
                            VStack(spacing: 8) {
                                Text("Breed")
                                    .font(.footnote)
                                    .foregroundColor(.white.opacity(0.7))
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                AddTextField(text: $viewModel.breed, placeholder: "Enter breed")
                            }
                            VStack(spacing: 8) {
                                Text("Age")
                                    .font(.footnote)
                                    .foregroundColor(.white.opacity(0.7))
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                AddTextField(text: $viewModel.age, placeholder: "Enter age")
                            }
                            VStack(spacing: 8) {
                                Text("Color")
                                    .font(.footnote)
                                    .foregroundColor(.white.opacity(0.7))
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                AddTextField(text: $viewModel.color, placeholder: "Enter color")
                            }
                            VStack(spacing: 8) {
                                Text("Height")
                                    .font(.footnote)
                                    .foregroundColor(.white.opacity(0.7))
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                AddTextField(text: $viewModel.height, placeholder: "Enter height")
                            }
                            VStack(spacing: 8) {
                                Text("Weight")
                                    .font(.footnote)
                                    .foregroundColor(.white.opacity(0.7))
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                AddTextField(text: $viewModel.weight, placeholder: "Enter weight")
                            }
                            VStack(spacing: 8) {
                                Text("Name")
                                    .font(.footnote)
                                    .foregroundColor(.white.opacity(0.7))
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                if #available(iOS 16.0, *) {
                                    TextEditor(text: $viewModel.personality)
                                        .foregroundColor(.white)
                                        .scrollContentBackground(.hidden)
                                        .background(
                                            placeholderView(isShow: viewModel.personality == "")
                                        )
                                        .padding(EdgeInsets(top: 12, leading: 13, bottom: 12, trailing: 13))
                                        .background(Color.white.opacity(0.05))
                                        .clipShape(.rect(cornerRadius: 12))
                                        .frame(height: 115)
                                        .padding(.top, 12)
                                } else {
                                    TextEditor(text: $viewModel.personality)
                                        .foregroundColor(.white)
                                        .background(
                                            placeholderView(isShow: viewModel.personality == "")
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
        Text(isShow ? "Enter personality" : "")
            .font(.body)
            .foregroundColor(.white.opacity(0.3))
            .padding(EdgeInsets(top: 8, leading: 4, bottom: 0, trailing: 0))
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
    }
}

final class AddPonyViewModel: ObservableObject {
    
    let dm: DataController
    
    @Published var ponyImageData: Data?
    
    var addPonyDisabled: Bool {
        name == "" || breed == "" || age == "" || color == "" || height == "" || weight == "" || personality == "" || ponyImageData == nil
    }
    
    @Published var name: String = ""
    @Published var breed: String = ""
    @Published var age: String = ""
    @Published var color: String = ""
    @Published var height: String = ""
    @Published var weight: String = ""
    @Published var personality: String = ""
    
    init(dm: DataController) {
        self.dm = dm
    }
    
    func ponySave() {
        guard let ponyImageData = ponyImageData else { return }
        let pony = Pony(ponyId: UUID(), ponyImageData: ponyImageData, name: name, breed: breed, age: age, color: color, height: height, weight: weight, personality: personality)
        dm.savePony(pony)
        self.ponyImageData = nil
        name = ""
        breed = ""
        age = ""
        color = ""
        height = ""
        weight = ""
        personality = ""
        self.ponyImageData = nil
    }
}

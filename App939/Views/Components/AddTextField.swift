import SwiftUI

struct AddTextField: View {
    
    @Binding var text: String
    
    let placeholder: String
    var trailingPadding: CGFloat = 0
    
    var body: some View {
        TextField("", text: $text)
            .font(.subheadline.weight(.regular))
            .frame(height: 45)
            .foregroundColor(.white)
            .autocorrectionDisabled(true)
            .accentColor(.white)
            .background(
                placeholderView()
            )
            .padding(EdgeInsets(top: 4, leading: 16, bottom: 4, trailing: 0))
            .background(
                Color.white.opacity(0.05)
            )
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(.c244248255012, lineWidth: 1)
            )
            .clipShape(.rect(cornerRadius: 12))
    }
    
    @ViewBuilder func placeholderView() -> some View {
        Text(text != "" ? "" : placeholder)
            .font(.subheadline.weight(.regular))
            .foregroundColor(.c9999101)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
}

struct TextFieldCustom_Preview: PreviewProvider {
    
    @State static var text = ""
    
    static var previews: some View {
        AddTextField(text: $text, placeholder: "Name")
            .padding()
            .background(Color.white.opacity(0.05))
            .background(Color.bgMain)
            .frame(height: 200)
    }
}

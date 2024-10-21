import SwiftUI

struct AlertTextField: View {
    
    @Binding var text: String
    
    let placeholder: String
    var trailingPadding: CGFloat = 0
    
    var body: some View {
        TextField("", text: $text)
            .font(.system(size: 17, weight: .regular))
            .foregroundColor(.white)
            .autocorrectionDisabled(true)
            .background(
                placeholderView()
            )
            .padding(.leading, 6)
            .frame(height: 26)
            .background(
                Color.black
            )
            .clipShape(.rect(cornerRadius: 5))
            .padding(0.5)
            .background(Color.c235235245.opacity(0.3))
            .clipShape(.rect(cornerRadius: 5))
    }
    
    @ViewBuilder func placeholderView() -> some View {
        Text(text != "" ? "" : placeholder)
            .font(.system(size: 17, weight: .regular))
            .foregroundColor(.c235235245.opacity(0.3))
            .frame(maxWidth: .infinity, alignment: .leading)
    }
}

struct AlertTextField_Preview: PreviewProvider {
    
    @State static var text = ""
    
    static var previews: some View {
        AlertTextField(text: $text, placeholder: "Title")
            .padding()
            .background(Color.bgMain)
            .frame(height: 200)
    }
}

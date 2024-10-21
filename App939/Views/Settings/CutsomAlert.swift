import SwiftUI

struct CustomAlert: View {
    
    @Binding var text: String
    let title: String
    let subtitle: String
    
    let save: () -> Void
    let close: () -> Void
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.6)
                .ignoresSafeArea()
            VStack(spacing: 0) {
                Text(title)
                    .font(.body.weight(.semibold))
                    .foregroundColor(.white)
                    .padding(.top, 19)
                Text(subtitle)
                    .font(.caption)
                    .foregroundColor(.white)
                    .padding(.top, 2)
                AlertTextField(text: $text, placeholder: title)
                    .onChange(of: text, perform: { newValue in
                        validation(newValue)
                    })
                    .keyboardType(.numberPad)
                    .padding(EdgeInsets(top: 14, leading: 16, bottom: 0, trailing: 16))
                Rectangle()
                    .fill(.white.opacity(0.4))
                    .frame(height: 0.33)
                    .padding(.top, 15)
                Button {
                    save()
                } label: {
                    Text("Save")
                        .font(.body.weight(.semibold))
                        .foregroundColor(.primaryYellow)
                        .frame(maxWidth: .infinity)
                        .frame(height: 44)
                }
                Rectangle()
                    .fill(.white.opacity(0.4))
                    .frame(height: 0.33)
                Button {
                    close()
                } label: {
                    Text("Close")
                        .font(.body.weight(.semibold))
                        .foregroundColor(.white.opacity(0.4))
                        .frame(maxWidth: .infinity)
                        .frame(height: 44)
                }
            }
            .frame(width: 270)
            .background(Color.c373737.opacity(0.82))
            .clipShape(.rect(cornerRadius: 14))
        }
    }
    
    func validation(_ newValue: String) {
        var filtered = newValue.filter { Set("0123456789").contains($0) }

        if filtered != "" {
            text = filtered
        } else {
            text = ""
        }
    }
}

struct CustomAlert_Preview: PreviewProvider {
    
    @State static var text: String = ""
    
    static var previews: some View {
        CustomAlert(text: $text, title: "Title", subtitle: "Subtitle") {
            
        } close: {
            
        }
        .padding()
        .background(Color.bgMain)
    }
    
}

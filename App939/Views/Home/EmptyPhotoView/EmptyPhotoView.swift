import SwiftUI

struct EmptyPhotoView: View {
    
    @Binding var showKartSheet: Bool
    
    var body: some View {
        VStack(spacing: 17) {
            VStack(spacing: 4) {
                Text("Add the data")
                    .font(.title.bold())
                    .foregroundColor(.white)
                Text("Indicate basic information")
                    .font(.callout)
                    .foregroundColor(.c244248255)
            }
            
            Button {
                showKartSheet = true
            } label: {
                Text("Add information")
                    .font(.subheadline.weight(.regular))
                    .foregroundColor(.black)
                    .padding(EdgeInsets(top: 7, leading: 14, bottom: 7, trailing: 14))
                    .background(Color.primaryYellow)
                    .clipShape(.rect(cornerRadius: 10))
            }
        }
        .padding(.vertical, 26)
        .frame(width: 270)
        .background(Color.white.opacity(0.05))
        .clipShape(.rect(cornerRadius: 16))
    }
}

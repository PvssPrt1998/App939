import PhotosUI
import SwiftUI

struct ProfileImageView: View {
   
    @Binding var imageData: Data?
    @State var image: Image?
    @State private var showingImagePicker = false
    @State private var inputImage: UIImage?
    
    var body: some View {
        ZStack {
            Color.white.opacity(0.2)
            if let image = image {
                ZStack {
                    Color.white
                    image
                        .resizable()
                        .scaledToFit()
                }
            } else {
                Image(systemName: "camera.fill")
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(.white)
                    .frame(width: 66, height: 53)
            }
        }
        .frame(width: 136, height: 136)
        .clipShape(.circle)
        .onTapGesture {
            showingImagePicker = true
        }
        .onChange(of: inputImage) { _ in
            loadImage()
        }
        .sheet(isPresented: $showingImagePicker) {
            ImagePicker(image: $inputImage)
                .ignoresSafeArea()
        }
    }
    
    func loadImage() {
        guard let inputImage = inputImage else { return }
        image = Image(uiImage: inputImage)
        imageData = inputImage.pngData()
    }
}

struct ProfilePictureView_Preview: PreviewProvider {
    
    @State static var data: Data?
    
    static var previews: some View {
        ProfileImageView(imageData: $data)
            .padding()
            .background(Color.bgMain)
    }
    
}

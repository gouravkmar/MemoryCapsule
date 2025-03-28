//
//  ContentView.swift
//  MemoryCapsule
//
//  Created by Gourav Kumar on 26/03/25.
//

import SwiftUI
import FirebaseCore
struct ContentView: View {
    @State private var image: UIImage?
    @State private var isCameraPresented = false

    var body: some View {
        VStack {
            if let image = image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 300)
            } else {
                Text("No Image Selected")
            }
            Button("Take Photo") {
                isCameraPresented = true
            }.padding()
                .frame(width: 200, height: 50)
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
            .sheet(isPresented: $isCameraPresented) {
//                CameraView(image: $image)
            }
        }
    }
}


//struct CameraView: UIViewControllerRepresentable {
//    @Binding var image: UIImage?
//    @Environment(\.presentationMode) var presentationMode
//
//    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
//        var parent: CameraView
//
//        init(parent: CameraView) {
//            self.parent = parent
//        }
//
//        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
//            if let selectedImage = info[.originalImage] as? UIImage {
//                parent.image = selectedImage
//            }
//            parent.presentationMode.wrappedValue.dismiss()
//        }
//    }
//
//    func makeCoordinator() -> Coordinator {
//        return Coordinator(parent: self)
//    }
//
//    func makeUIViewController(context: Context) -> UIImagePickerController {
//        let picker = UIImagePickerController()
//        picker.delegate = context.coordinator
//        picker.sourceType = .camera // Opens the camera directly
//        picker.allowsEditing = false
//        return picker
//    }
//
//    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}
//}



//func testFirestore() {
//    let memory = Memory(
//        id: UUID().uuidString,
//        name: "gourav",
//        title: "test",
//        description: "testing",
//        imageURL: "asd",
//        lat: -21.0,
//        long: 25.0,
//        timestamp: Date()
//    )
//    try? FireStoreManager.shared.saveData(memory)
//    Task {
//        let mem = try? await FireStoreManager.shared.fetchData(
//            for: "gourav" ,
//            lat: -21.0,
//            long: 25.0,
//            radiusMeters: 100
//        )
//        print(mem)
//        
//        
//        
//    }
//}
//
//func testCloud(){
//    guard let image = UIImage(systemName: "photo") else {return}
//    Task {
//      let urlStr = try? await CloudStorage.shared.uploadImage(image: image)
//        print(urlStr)
//        let img = try? await CloudStorage.shared.downloadImage(urlString: urlStr!)
//        print(img)
//    }
//}
//func fullTest() {
//    guard let image = UIImage(systemName: "photo") else {return}
//    MemoryManager.shared.saveImageToMemory(image: image, imageTitle: "test")
////    Task {
//
//        
//       
////        let memories = try?  MemoryManager.shared.fetchMemoriesForCurrentPlace()
////        print(memories)
////    }
//}
//
#Preview {
    ContentView()
}

//
//  ContentView.swift
//  MemoryCapsule
//
//  Created by Gourav Kumar on 26/03/25.
//

import SwiftUI
import FirebaseCore
struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
            Button(
                "Save Data",
                action: {
                    testCloud()
                    }
                )
            .padding()
            .background(Color.red)
            .textCase(.uppercase)
            .foregroundColor(.white)
            .cornerRadius(10)
        }
        .padding()
    }
}

func testFirestore() {
    let memory = Memory(
        id: UUID().uuidString,
        name: "gourav",
        title: "test",
        description: "testing",
        imageURL: "asd",
        lat: -21.0,
        long: 25.0,
        timestamp: Date()
    )
    try? FireStoreManager.shared.saveData(memory)
    Task {
        let mem = try? await FireStoreManager.shared.fetchData(
            for: "gourav" ,
            lat: -21.0,
            long: 25.0,
            radiusMeters: 100
        )
        print(mem)
        
        
        
    }
}

func testCloud(){
    guard let image = UIImage(systemName: "photo") else {return}
    Task {
      let urlStr = try? await CloudStorage.shared.uploadImage(image: image)
        print(urlStr)
        let img = try? await CloudStorage.shared.downloadImage(urlString: urlStr!)
        print(img)
    }
}

//#Preview {
//    ContentView()
//}

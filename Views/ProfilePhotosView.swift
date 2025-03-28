//
//  ProfilePhotoView.swift
//  MemoryCapsule
//
//  Created by Gourav Kumar on 28/03/25.
//

import SwiftUI

struct ProfilePhotoView: View {
    @EnvironmentObject var memoryModel : MemoriesViewModel
    var body: some View {
        let columns = [
            GridItem(.flexible(), spacing: 10),
            GridItem(.flexible(), spacing: 10),
            GridItem(.flexible(), spacing: 10)
        ]
        ScrollView{
            LazyVGrid(columns: columns){
                ForEach(memoryModel.memories ?? [], content: {memory in
                    memory.image?
                        .resizable()
                        .frame(height: 120)
                        .cornerRadius(10)
                })
            }
        }
    }
}

#Preview {
    ProfilePhotoView()
}

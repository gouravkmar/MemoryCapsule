//
//  ProfileView.swift
//  MemoryCapsule
//
//  Created by Gourav Kumar on 27/03/25.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var memoryModel : MemoriesViewModel
    
    var body: some View {
            ZStack(alignment: .top) {
                
                Color.black.ignoresSafeArea()

                VStack(spacing: 0) {
                    
                    ProfileHeaderView(memoriesHere: memoryModel.memories?.count ?? 0)
                        .padding(.top, -30)
                    
                    ProfilePhotoView()
                    
                }
            }
        }
}

#Preview {
    ProfileView()
}

